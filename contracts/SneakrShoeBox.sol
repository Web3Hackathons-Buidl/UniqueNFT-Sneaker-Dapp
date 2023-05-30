//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./TradeableERC721Token.sol";
import "./Sneakr.sol";
import "./Factory.sol";
import "../contracts/openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SneakrShoeBox
 *
 * SneakrShoeBox - a tradeable Shoe box of Sneakrs.
 */
contract SneakrShoeBox is TradeableERC721Token {
    uint256 NUM_SneakrS_PER_BOX = 2;
    uint256 OPTION_ID = 0;
    address factoryAddress;

    constructor(address _proxyRegistryAddress, address _factoryAddress) TradeableERC721Token("SneakrShoeBox", "ShoeBOX", _proxyRegistryAddress) public {
        factoryAddress = _factoryAddress;
    }

    function unpack(uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender);

        // Insert custom logic for configuring the item here.
        for (uint256 i = 0; i < NUM_SneakrS_PER_BOX; i++) {
            // Mint the ERC721 item(s).
            Factory factory = Factory(factoryAddress);
            factory.mint(OPTION_ID, msg.sender);
        }

        // Burn the presale item.
        _burn(msg.sender, _tokenId);
    }

    function baseTokenURI() public view returns (string memory) {
        return "https://opensea-Sneakrs-api.herokuapp.com/api/box/";
    }

    function itemsPerShoebox() public view returns (uint256) {
        return NUM_SneakrS_PER_BOX;
    }
}