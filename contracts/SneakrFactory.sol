//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../contracts/openzeppelin/contracts/access/Ownable.sol";
import "./Factory.sol";
import "./Sneakr.sol";
import "./SneakrShoeBox.sol";
import "./Strings.sol";
// import "./Strings.sol";

contract SneakrFactory is Factory, Ownable {
  using Strings for string;

  address public proxyRegistryAddress;
  address public nftAddress;
  address public ShoeBoxNftAddress;
  string public baseURI = "https://opensea-Sneakrs-api.herokuapp.com/api/factory/";

  /**
   * Enforce the existence of only 23 OpenSea Sneakrs.
   */
  uint256 Sneakr_SUPPLY = 23;

  /**
   * Three different options for minting Sneakrs (basic, premium, and gold).
   */
  uint256 NUM_OPTIONS = 3;
  uint256 SINGLE_Sneakr_OPTION = 0;
  uint256 MULTIPLE_Sneakr_OPTION = 1;
  uint256 ShoeBOX_OPTION = 2;
  uint256 NUM_SneakrS_IN_MULTIPLE_Sneakr_OPTION = 4;

  constructor(address _proxyRegistryAddress, address _nftAddress) public {
    proxyRegistryAddress = _proxyRegistryAddress;
    nftAddress = _nftAddress;
    ShoeBoxNftAddress = address(new SneakrShoeBox(_proxyRegistryAddress, address(this)));
  }

  function name() external view returns (string memory) {
    return "OpenSeaSneakr Item Sale";
  }

  function symbol() external view returns (string memory) {
    return "SNKR";
  }

  function supportsFactoryInterface() public view returns (bool) {
    return true;
  }

  function numOptions() public view returns (uint256) {
    return NUM_OPTIONS;
  }
  
  function mint(uint256 _optionId, address _toAddress) public {
    // Must be sent from the owner proxy or owner.
    ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
    assert(address(proxyRegistry.proxies(owner())) == msg.sender || owner() == msg.sender || msg.sender == ShoeBoxNftAddress);
    require(canMint(_optionId));

    Sneakr openSeaSneakr = Sneakr(nftAddress);
    if (_optionId == SINGLE_Sneakr_OPTION) {
      openSeaSneakr.mintTo(_toAddress);
    } else if (_optionId == MULTIPLE_Sneakr_OPTION) {
      for (uint256 i = 0; i < NUM_SneakrS_IN_MULTIPLE_Sneakr_OPTION; i++) {
        openSeaSneakr.mintTo(_toAddress);
      }
    } else if (_optionId == ShoeBOX_OPTION) {
      SneakrShoeBox openSeaSneakrShoeBox = SneakrShoeBox(ShoeBoxNftAddress);
      openSeaSneakrShoeBox.mintTo(_toAddress);
    } 
  }

  function canMint(uint256 _optionId) public view returns (bool) {
    if (_optionId >= NUM_OPTIONS) {
      return false;
    }

    Sneakr openSeaSneakr = Sneakr(nftAddress);
    uint256 SneakrSupply = openSeaSneakr.totalSupply();

    uint256 numItemsAllocated = 0;
    if (_optionId == SINGLE_Sneakr_OPTION) {
      numItemsAllocated = 1;
    } else if (_optionId == MULTIPLE_Sneakr_OPTION) {
      numItemsAllocated = NUM_SneakrS_IN_MULTIPLE_Sneakr_OPTION;
    } else if (_optionId == ShoeBOX_OPTION) {
      SneakrShoeBox openSeaSneakrShoeBox = SneakrShoeBox(ShoeBoxNftAddress);
      numItemsAllocated = openSeaSneakrShoeBox.itemsPerShoebox();
    }
    return SneakrSupply < (Sneakr_SUPPLY - numItemsAllocated);
  }
  
  function tokenURI(uint256 _optionId) external view returns (string memory) {
    return Strings.strConcat(
        baseURI,
        Strings.uint2str(_optionId)
    );
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use transferFrom so the frontend doesn't have to worry about different method names.
   */
  function transferFrom(address _from, address _to, uint256 _tokenId) public {
    mint(_tokenId, _to);
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use isApprovedForAll so the frontend doesn't have to worry about different method names.
   */
  function isApprovedForAll(
    address _owner,
    address _operator
  )
    public
    view
    returns (bool)
  {
    if (owner() == _owner && _owner == _operator) {
      return true;
    }

    ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
    if (owner() == _owner && address(proxyRegistry.proxies(_owner)) == _operator) {
      return true;
    }

    return false;
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use isApprovedForAll so the frontend doesn't have to worry about different method names.
   */
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return owner();
  }
}