# for a fresh install
$ git clone https://github.com/casmirconsensys/sneakr_cred.git <br>
$ cd sneakr_cred/ <br>
$ cd metadata-api/ <br>

# Set up python environment
$ python3 -m venv env <br>
$ source env/bin/activate

# Install these packages first
$ pip install flask <br>
$ pip install google-cloud-storage <br>
$ pip install pillow <br>

# Use requirements to install all other dependences 
$ pip install -r requirements.txt

# start the app
$ python3 app.py

to view in browser go to: <br>
# localhost:5000
Index page

# localhost:5000/api/shoe/{id}
where id is any integer

# create shoebox
/api/box/{token_id} <br>

# create lootbox
/api/factory/{token_id}
only 0, 1, and 2 are valid keys <br>