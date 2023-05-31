## SNEAKRCRED ERC721 contracts

### About SNEAKRCRED.
This project is a submission for Unique.Network bounty and Polkadot's grand prize.
Title: NFT Customization dApp: Empowering Creative Expression in the World of Sneaker Collectibles

Description: We proudly present our innovative hackathon submission, an NFT Customization dApp designed to revolutionize the sneaker collectibles industry. Our team embarked on an exciting journey, starting by seamlessly connecting to the Opal Testnet blockchain, where we established a secure account. Leveraging the power of Remix and Hardhat, we successfully deployed a robust smart contract to the Opal Testnet, ensuring a reliable and efficient platform for NFT creation and customization.

With meticulous attention to detail, we crafted a cutting-edge sneaker customization interface that empowers users to unleash their creativity. Our intuitive drag-and-drop functionality enables the seamless combination of NFT pieces, resulting in captivating Shoe Boxes that reflect individual style and personality. We went beyond conventional customization options by allowing users to select specific portions of the shoe color as NFTs, providing unprecedented levels of personalization.

To enhance the overall experience, our dApp features a comprehensive method for minting sneakers. Each NFT incorporates multiple layers, attributes, and boosts meticulously designed to elevate gameplay and deliver a truly immersive experience. By seamlessly integrating the Sneakr API, we demonstrate the dynamic refresh of sneaker NFTs, showcasing the remarkable results of our cutting-edge technology.

Join us in this hackathon submission as we present our professional and groundbreaking NFT Customization dApp. Witness the convergence of art, technology, and collectibles as we unlock endless possibilities for self-expression in the world of sneaker enthusiasts.

For this hackathon, we have enhanced our tech stack by incorporating Polkadot into our existing project. Our improved tech stack now includes a mintNFT Collection Helpers Factory, Unique NFT Solidity Interfaces, Collection Manager Factory, Collection Bundles, and the unique.network SDK. By integrating Polkadot, we have leveraged its powerful features and capabilities to enhance the functionality and scalability of our project. The mintNFT Collection Helpers Factory enables seamless and efficient minting of NFTs, while the Unique NFT Solidity Interfaces provide standardized interfaces for interacting with NFT contracts. The Collection Manager Factory allows for the creation and management of collections, and the Collection Bundles feature facilitates the bundling and trading of NFTs. Additionally, the unique.network SDK offers a comprehensive set of tools and resources for developers, making it easier to build and integrate with our project. Through these improvements, we have strengthened our tech stack and harnessed the potential of Polkadot to take our project to new heights in terms of functionality, scalability, and developer experience.

Answers: 

Potential Impact: The UniqueNFT Sneaker Dapp fills a significant gap in the universe of sneaker collectibles by offering a seamless and intuitive platform for customization. With its potential to be used frequently by a large and diverse audience, it empowers sneaker enthusiasts to express their individuality and creativity in a unique and personalized way.

Novelty/Creativity: Our project stands out with its innovative approach to sneaker customization. By allowing users to select specific portions of the shoe color as an NFT and combining different pieces in a drag-and-drop interface, we offer a novel and creative way to create truly unique sneaker collectibles. This not only solves a new problem but also brings a smile to the faces of sneaker enthusiasts who crave individuality in their collections.

Technical Accomplishment: The code behind the UniqueNFT Sneaker Dapp is elegantly designed, clean, and technically impressive. We have successfully deployed the smart contract to the Opal Testnet using Remix and Hardhat. The project is complete, offering a seamless user experience and comprehensive functionality for sneaker customization.

Design: The UX/UI/DX of our Dapp is carefully crafted to ensure ease of use and a delightful experience for users. The interface is intuitive, allowing users to effortlessly drag and drop NFT pieces onto each other to create their desired Shoe Boxes. The visual design adds an element of excitement and enhances the overall user experience.

Business Plan: We have developed a sustainable business plan for the UniqueNFT Sneaker Dapp. Proper licensing is in place, ensuring compliance with relevant regulations. Additionally, we are exploring avenues to create utility for XDC, such as staking and TVL infrastructure, which will contribute to the long-term viability and growth of the project.

Resources: Throughout the development process, we have utilized a range of resources, including the Opal Testnet blockchain, Remix, Hardhat, and Metamask. These resources have been instrumental in successfully building and deploying the UniqueNFT Sneaker Dapp, showcasing our ability to leverage available tools and technologies effectively.

We Connected to an account (on the Opal Testnet blockchain)
We send OPL Tokens to our metamask account from the Telegram Bot.
We use Remix & Hardhat to deploy the smart contract to the Opal Testnet.
We made custom sneaker customization interface for customizing NFTs by dragging and dropping them onto each other (creating Shoe Boxes)
What we did was we allow the pieces of the shoe to be selected for specific portions of the shoe color as an NFT, this whole sneaker with color is able to be selected by the customizer. 
We provided a method to mint a sneaker with all of the pieces of the shoe in a different layer, along with the Attributes and Boosts for Game Play. 
At the end of the sneakr API we show the results of refresh of dynamic sneaker NFT’s part of the ShoeBox

We proudly present our innovative hackathon submission, an NFT Customization dApp designed to revolutionize the sneaker collectibles industry. Our team embarked on an exciting journey, starting by seamlessly connecting to the Opal Testnet blockchain, where we established a secure account. Leveraging the power of Remix and Hardhat, we successfully deployed a robust smart contract to the Opal Testnet, ensuring a reliable and efficient platform for NFT creation and customization.

With meticulous attention to detail, we crafted a cutting-edge sneaker customization interface that empowers users to unleash their creativity. Our intuitive drag-and-drop functionality enables the seamless combination of NFT pieces, resulting in captivating Shoe Boxes that reflect individual style and personality. We went beyond conventional customization options by allowing users to select specific portions of the shoe color as NFTs, providing unprecedented levels of personalization.

To enhance the overall experience, our dApp features a comprehensive method for minting sneakers. Each NFT incorporates multiple layers, attributes, and boosts meticulously designed to elevate gameplay and deliver a truly immersive experience. By seamlessly integrating the Sneakr API, we demonstrate the dynamic refresh of sneaker NFTs, showcasing the remarkable results of our cutting-edge technology.

Please accept our submission to Unique.Network and Polkadot for the Web3athon 2023 hackathon submission as we present our professional and groundbreaking NFT Customization dApp. Witness the convergence of art, technology, and collectibles as we unlock endless possibilities for self-expression in the world of sneaker enthusiasts.
"sneakercred is an NFT gaming dex focused on sneaker based collectibles for NBA2K and sneaker culture connoisseurs to use as an asset class and participate in open financial markets while being reputationally mutually secured in a validation verification backed by StockX and issued certificates on the blockchain"

## Requirements

### Node version

Either make sure you're running a version of node compliant with the `engines` requirement in `package.json`, or install Node Version Manager [`nvm`](https://github.com/creationix/nvm) and run `nvm use` to use the correct version of node.

## Installation

Run
```bash
npm install
```

If you run into an error while building the dependencies and you're on a Mac, run the code below, remove your `node_modules` folder, and do a fresh `npm install`:

```bash
xcode-select --install # Install Command Line Tools if you haven't already.
sudo xcode-select --switch /Library/Developer/CommandLineTools # Enable command line tools
sudo npm explore npm -g -- npm install node-gyp@latest # Update node-gyp
```

## Deploying

### Deploying to the Rinkeby network.

1. You'll need to sign up for [Infura](https://infura.io). and get an API key.
2. Using your API key and the mnemonic for your Metamask wallet (make sure you're using a Metamask seed phrase that you're comfortable using for testing purposes), run:

```
export INFURA_KEY="<infura_key>"
export MNEMONIC="<metmask_mnemonic>"
truffle deploy --network rinkeby
```

### Minting tokens.

After deploying to the Rinkeby network, there will be a contract on Rinkeby that will be viewable on [Rinkeby Etherscan](https://rinkeby.etherscan.io). For example, here is a [recently deployed contract](https://rinkeby.etherscan.io/address/0xeba05c5521a3b81e23d15ae9b2d07524bc453561). You should set this contract address and the address of your Metamask account as environment variables when running the minting script:

```
export OWNER_ADDRESS="<my_address>"
export NFT_CONTRACT_ADDRESS="<deployed_contract_address>"
export NETWORK="rinkeby"
node scripts/mint.js
```

Note: When running the minting script on mainnet, your environment variable needs to be set to `mainnet` not `live`.  The environment variable affects the Infura URL in the minting script, not truffle. When you deploy, you're using truffle and you need to give truffle an argument that corresponds to the naming in truffle.js (`--network live`).  But when you mint, you're relying on the environment variable you set to build the URL (https://github.com/ProjectOpenSea/opensea-creatures/blob/master/scripts/mint.js#L54), so you need to use the term that makes Infura happy (`mainnet`).  Truffle and Infura use the same terminology for Rinkeby, but different terminology for mainnet.  If you start your minting script, but nothing happens, double check your environment variables.
