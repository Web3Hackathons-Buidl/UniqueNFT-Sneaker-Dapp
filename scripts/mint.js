const HDWalletProvider = require("truffle-hdwallet-provider")
const web3 = require('web3')
const MNEMONIC = process.env.MNEMONIC
const INFURA_KEY = process.env.INFURA_KEY
const FACTORY_CONTRACT_ADDRESS = process.env.FACTORY_CONTRACT_ADDRESS
const NFT_CONTRACT_ADDRESS = process.env.NFT_CONTRACT_ADDRESS
const OWNER_ADDRESS = process.env.OWNER_ADDRESS
const NETWORK = process.env.NETWORK
const NUM_SNEAKRS = 12
const NUM_SHOEBOXES = 4
const DEFAULT_OPTION_ID = 0
const SHOEBOX_OPTION_ID = 2

if (!MNEMONIC || !INFURA_KEY || !OWNER_ADDRESS || !NETWORK) {
    console.error("Please set a mnemonic, infura key, owner, network, and contract address.")
    return
}

const NFT_ABI = [{
    "constant": false,
    "inputs": [
      {
        "name": "_to",
        "type": "address"
      }
    ],
    "name": "mintTo",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
}]

const FACTORY_ABI = [{
    "constant": false,
    "inputs": [
      {
        "name": "_optionId",
        "type": "uint256"
      },
      {
        "name": "_toAddress",
        "type": "address"
      }
    ],
    "name": "mint",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
}]

async function main() {
    const provider = new HDWalletProvider(MNEMONIC, `https://${RINKEBY}.infura.io/v3/${INFURA_KEY47f21c3dddc84d5198b7ae16263cf7b7}`)
    const web3Instance = new web3(
        provider
    )

    if (NFT_CONTRACT_ADDRESS) {
        const nftContract = new web3Instance.eth.Contract(NFT_ABI, NFT_CONTRACT_ADDRESS, { gasLimit: "1000000" })

        // SNEAKRS issued directly to the owner.
        for (var i = 0; i < NUM_SNEAKRS; i++) {
            const result = await nftContract.methods.mintTo(OWNER_ADDRESS).send({ from: OWNER_ADDRESS });
            console.log("Minted creature. Transaction: " + result.transactionHash)
        }
    } else if (FACTORY_CONTRACT_ADDRESS) {
        const factoryContract = new web3Instance.eth.Contract(FACTORY_ABI, FACTORY_CONTRACT_ADDRESS, { gasLimit: "1000000" })

        // SNEAKRS issued directly to the owner.
        for (var i = 0; i < NUM_SNEAKRS; i++) {
            const result = await factoryContract.methods.mint(DEFAULT_OPTION_ID, OWNER_ADDRESS).send({ from: OWNER_ADDRESS });
            console.log("Minted creature. Transaction: " + result.transactionHash)
        }

        // SHOEboxes issued directly to the owner.
        for (var i = 0; i < NUM_SHOEBOXES; i++) {
            const result = await factoryContract.methods.mint(SHOEBOX_OPTION_ID, OWNER_ADDRESS).send({ from: OWNER_ADDRESS });
            console.log("Minted SHOEbox. Transaction: " + result.transactionHash)
        }
    }
}

main()
