const Sneakr = artifacts.require("./Sneakr.sol");
const SneakrFactory = artifacts.require("./SneakrFactory.sol")
const SneakrShoeBox = artifacts.require("./SneakrShoeBox.sol");

module.exports = function(deployer, network) {
  // OpenSea proxy registry addresses for rinkeby and mainnet.
  let proxyRegistryAddress = ""
  if (network === 'rinkeby') {
    proxyRegistryAddress = "0xf57b2c51ded3a29e6891aba85459d600256cf317";
  } else {
    proxyRegistryAddress = "0xa5409ec958c83c3f309868babaca7c86dcb077c1";
  }

  deployer.deploy(Sneakr, proxyRegistryAddress, {gas: 5000000});
  
  // Uncomment this if you want initial item sale support.
  // deployer.deploy(Sneakr, proxyRegistryAddress, {gas: 5000000}).then(() => {
  //   return deployer.deploy(SneakrFactory, proxyRegistryAddress, Sneakr.address, {gas: 7000000});
  // }).then(async() => {
  //   var Sneakr = await Sneakr.deployed();
  //   return Sneakr.transferOwnership(SneakrFactory.address);
  // })
};
