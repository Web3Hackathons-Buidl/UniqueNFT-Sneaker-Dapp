require('dotenv').config();
const { ethers } = require("hardhat");
const { CollectionHelpersFactory, ContractHelpersFactory } = require("@unique-nft/solidity-interfaces");
const { CollectionManager__factory } = require('../typechain-types');
const { Address, Ethereum } = require("@unique-nft/utils");

async function main() {
  // Define a provider
  const provider = ethers.provider;

  // Create a signer
  const privateKey = process.env.PRIVATE_KEY;
  if (!privateKey)
    throw new Error('Missing private key');
  const wallet = new ethers.Wallet(privateKey, provider);

  // Address received after the deployment - see the section above
  const contractAddress = '0xFcD9dC04af91B033834B230A1D8B4CDd7fDfFbb4';

  const collectionHelpers = await CollectionHelpersFactory(wallet, ethers);

  // Create a contract instance
  const collectionManager = CollectionManager__factory.connect(contractAddress, wallet);
  console.log(`Contract address found: ${collectionManager.address}`);

  // Create a new collection
  let newCollection = await collectionManager.createCollection(
    '0xb4d6A98aa8CD5396069c2818Adf4ae1A0384b43a',
    '0xb4d6A98aa8CD5396069c2818Adf4ae1A0384b43a',
    'My new collection',
    'This collection is for testing purposes',
    'TC',
    'https://ipfs.unique.network/ipfs/',
    {
      value: await collectionHelpers.collectionCreationFee(),
    }
  );

  const transactionReceipt = await newCollection.wait();
  const collectionAddress = transactionReceipt.events?.[0].args?.collectionId;
  const collectionId = Address.collection.addressToId(collectionAddress);

  console.log(`Collection created!`);
  console.log(`Address: ${collectionAddress}, id: ${collectionId}`);

  console.log(`Contract address found: ${collectionManager.address}`);
  const contractHelpers = await ContractHelpersFactory(wallet, ethers);

  // ---- Second account - sponsor
  const privateKeySecondary = process.env.PRIVATE_KEY_SECONDARY;
  if (!privateKeySecondary)
    throw new Error('Missing private key');
  const walletConfirm = new ethers.Wallet(privateKeySecondary, provider);
  const contractHelpersConfirm = await ContractHelpersFactory(walletConfirm, ethers);
  // ----

  const setSponsorTx = await (
    await contractHelpers.setSponsor(
      collectionManager.address,
      '0x83E02d8ab05913bA7b5A76fA828A95E5118255E8'
    )
  ).wait();

  const confirmSponsorTx = await contractHelpersConfirm.confirmSponsorship(collectionManager.address, {
    gasLimit: 10000000,
  });

  const parsedSetSponsorTx = Ethereum.parseEthersTxReceipt(setSponsorTx);
  console.log(`New sponsor was set for the contract. The sponsor address: ${parsedSetSponsorTx.events.ContractSponsorSet.sponsor}`);
}

main().catch(console.error);
