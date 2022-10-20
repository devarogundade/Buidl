// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BdlNft is ERC721 {

    address deployer;
    uint256 tokenID = 1;

    constructor() ERC721("Buidl NFT", "BNFT") {
        deployer = msg.sender;
    }

    function mint(address beneficiary) public {
        _safeMint(
            beneficiary,
            tokenID
        );

        tokenID++;
    }


}
