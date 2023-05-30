from flask import Flask, render_template
from flask import jsonify
from google.cloud import storage
from google.oauth2 import service_account
from PIL import Image, ImageFilter
import os, sys
import mimetypes
from random import randint

# GOOGLE_STORAGE_PROJECT = os.environ['GOOGLE_STORAGE_PROJECT']
# GOOGLE_STORAGE_BUCKET = os.environ['GOOGLE_STORAGE_BUCKET']

app = Flask(__name__)

SHOE_MODEL = 'Air Jordan I '

BOOSTS = [  'Foul', 
            'Dunk', 
            'Pass', 
            'PNRDIQ', 
            'Speed', 
            'LatQui', 
            'Vision', 
            'PFade', 
            'Acceleration', 
            'Mid Move', 
            'Steal', 
            'Layup', 
            'Speed Ball', 
            'Block', 
            '3 Point Move', 
            '3 Point Open'   ]

BOOST_ATTRIBUTES = ['']

# random hex color generator
# COLORS = ['%06X' % randint(0, 0xFFFFFF) for x in range(10)]


SOLES = ['white', 'black', 'grey', 'orange', 'red', 'yellow' ]
SWOOSHES = ['white','black', 'blue', 'grey', 'lightblue', 'orange', 'purple', 'red', 'yellow', 'lightgreen']
BACKS = ['white','black', 'blue', 'grey', 'lightblue', 'orange', 'purple', 'red', 'yellow']
BODIES = ['white','black', 'blue', 'red', 'lightblue', 'orange', 'purple', 'grey', 'elephant']
TOPS = ['white','black', 'blue', 'lightblue', 'orange', 'purple', 'red']
TOES = ['white','black', 'green', 'grey', 'lightblue', 'orange', 'purple', 'red']

@app.route('/')
def index():
    return render_template("index.html")

# endpoint for creation of single shoe
@app.route('/api/shoe/<token_id>')
def shoe(token_id):
    token_id = int(token_id)
    num_boosts = len(BOOSTS)
    boost = BOOSTS[token_id % num_boosts]

    sole = SOLES[token_id % len(SOLES)]
    swoosh = SWOOSHES[token_id % len(SWOOSHES)]
    back = BACKS[token_id % len(BACKS)]
    body = BODIES[token_id % len(BODIES)]
    top = TOPS[token_id % len(TOPS)]
    toe = TOES[token_id % len(TOES)]
    image_url = _compose_image(['images/images/factory/top/top_%s.png' % top,
                                'images/images/factory/sole_laces/sole_laces_%s.png' % sole,
                                'images/images/factory/back/back_%s.png' % back,
                                'images/images/factory/panels/panels_%s.png' % body,
                                'images/images/factory/swoosh/swoosh_%s.png' % swoosh,
                                'images/images/factory/toe/toe_%s.png' % toe],
                               token_id, "shoe")

    attributes = []
    _add_attribute(attributes, 'sole', SOLES, token_id)
    _add_attribute(attributes, 'swoosh', SWOOSHES, token_id)
    _add_attribute(attributes, 'back', BACKS, token_id)
    _add_attribute(attributes, 'body', BODIES, token_id)
    _add_attribute(attributes, 'top', TOPS, token_id)
    _add_attribute(attributes, 'toe', TOES, token_id)
    _add_attribute(attributes, 'boost', BOOST_ATTRIBUTES, token_id, display_type="boost_number")

    return jsonify({
    # data = ({
        'name': SHOE_MODEL,
        'description': "Rare Colorway",
        'image': image_url,
        'sole': sole,
        'swoosh': swoosh,
        'body': body,
        'top': top,
        'toe': toe,
        'back': back,
        'token_id': token_id,
        'boost': boost,
        'external_url': 'https://sneakrcred.com/%s' % token_id,
        'attributes': attributes,
        # 'colors': COLORS
    })
    # return render_template("shoe.html", data=data)

# endpoint to create shoebox
@app.route('/api/box/<token_id>')
def box(token_id):
    token_id = int(token_id)
    image_url = _compose_image(['images/jordan_box_placeholder.png'], token_id, "box")

    attributes = []
    _add_attribute(attributes, 'number_inside', [3], token_id)

    return jsonify({
        'name': "Shoe Box",
        'description': "This box contains some New Jordans! It can also be traded!",
        'image': image_url,

        #TODO
        'external_url': 'static/output/box/%s' % token_id,
        
        'attributes': attributes
    })

# endpoint to create lootbox that contain shoeboxes
@app.route('/api/factory/<token_id>')
def factory(token_id):
    token_id = int(token_id)
    if token_id == 0:
        name = "One Box"
        description = "When you purchase this option, you will receive a single pair of new Jordans of a random variety. " \
                      "Enjoy and take good care of your new kicks!"
        image_url = _compose_image(['images/jordan_box_placeholder.png'], token_id, "factory")
        num_inside = 1
    elif token_id == 1:
        name = "Four Boxes"
        description = "When you purchase this option, you will receive 4 new pairs of Jordans of random varieties. " \
                      "Enjoy and take good care of your new kicks!"
        image_url = _compose_image(['images/jordan_box_placeholder.png'], token_id, "factory")
        num_inside = 4
    elif token_id == 2:
        name = "One Sneakrcred Lootbox"
        description = "When you purchase this option, you will receive a lootbox with 3 new pairs of Jordans of random varieties. " \
                      "Enjoy and take good care of your new kicks!"
        image_url = _compose_image(['images/jordan_box_placeholder.png'], token_id, "factory")
        num_inside = 3

    attributes = []
    _add_attribute(attributes, 'number_inside', [num_inside], token_id)

    return jsonify({
        'name': name,
        'description': description,
        'image': image_url,
        'external_url': 'https://sneakrcred.com/static/output/box/%s' % token_id,
        'attributes': attributes
    })


def _add_attribute(existing, attribute_name, options, token_id, display_type=None):
    trait = {
        'trait_type': attribute_name,
        'value': options[token_id % len(options)]
    }
    if display_type:
        trait['display_type'] = display_type
    existing.append(trait)

# create and save image
def _compose_image(image_files, token_id, path):
    composite = None
    for image_file in image_files:
        foreground = Image.open(image_file).convert("RGBA")

        if composite:
            composite = Image.alpha_composite(composite, foreground)
        else:
            composite = foreground
        output_path = "static/output/" + path + "/%s.png" % token_id
    
    try:  
        composite.save(output_path)
    except FileNotFoundError:
        os.mkdir("static/output/shoe", 770)
        os.mkdir("static/output/box", 770)
        composite.save(output_path)

    # Bucket needs to be set up
    # blob = _get_bucket().blob(f"{path}/{token_id}.png")
    # blob.upload_from_filename(filename=output_path)
    # return blob.public_url
    

# This is set up for google cloud. Possible to implement any cloud service here
def _get_bucket():
    # credentials = service_account.Credentials.from_service_account_file('credentials/google-storage-credentials.json')
    # if credentials.requires_scopes:
    #     credentials = credentials.with_scopes(['https://www.googleapis.com/auth/devstorage.read_write'])
    # client = storage.Client(project=GOOGLE_STORAGE_PROJECT, credentials=credentials)
    # return client.get_bucket(GOOGLE_STORAGE_BUCKET)
    pass
   


if __name__ == '__main__':
    app.run(debug=True, use_reloader=True)