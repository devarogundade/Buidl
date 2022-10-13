// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC721.sol";

contract BuidlNft is ERC721 {

  address deployer;

  constructor() ERC721("Buidl NFT", "BNFT") {
      deployer = msg.sender;
  }

  // function mint() public {
  //     _;
  // }

}
