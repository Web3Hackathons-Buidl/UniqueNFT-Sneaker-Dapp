//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./TradeableERC721Token.sol";
import "../contracts/openzeppelin/contracts/access/Ownable.sol";


/**
 * @title Sneakr
 * Sneakr - a contract for my non-fungible Sneakrs.
 */
contract Sneakr is TradeableERC721Token {
  constructor(address _proxyRegistryAddress) TradeableERC721Token("Sneakr", "OSC", _proxyRegistryAddress) public {  }

  function baseTokenURI() public view returns (string memory) {
    return "https://opensea-Sneakrs-api.herokuapp.com/api/Sneakr/";
  }
}