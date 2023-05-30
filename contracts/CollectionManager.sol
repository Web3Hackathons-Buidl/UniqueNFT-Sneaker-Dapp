// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {CollectionHelpers, CollectionHelpersEvents} from  "@unique-nft/solidity-interfaces/contracts/CollectionHelpers.sol";
import {UniqueNFT, CrossAddress} from "@unique-nft/solidity-interfaces/contracts/UniqueNFT.sol";

// inherit contract from our interface 
contract CollectionManager is CollectionHelpersEvents {
  // a «static» smart contract in our chain (CollectionHelpers.sol) obtained by its address 
  CollectionHelpers helpers = CollectionHelpers(0x6C4E9fE1AE37a41E93CEE429e8E1881aBdcbb54F);

  function createCollection(
    address owner,
    address managerContract,
    string calldata name,
    string calldata description,
    string calldata symbol,
    string calldata baseURI
  ) public payable virtual returns (address){
    // create a collection using the method from the library 
    address collectionAddress = helpers.createNFTCollection{value: helpers.collectionCreationFee()}(name, description, symbol);
    // make the collection ERC721Metadata compatible
    helpers.makeCollectionERC721MetadataCompatible(collectionAddress, baseURI);
    // get the collection object by its address 
    UniqueNFT collection = UniqueNFT(collectionAddress);
    // set the collection admin and owner using cross address
    collection.addCollectionAdminCross(CrossAddress(managerContract, 0));
    collection.changeCollectionOwnerCross(CrossAddress(owner, 0));
    // return the collection address 
    return collectionAddress;
  }
}
