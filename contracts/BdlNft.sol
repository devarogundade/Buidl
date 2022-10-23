// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BdlNft is ERC721, Ownable {
    address deployer;
    uint256 tokenID = 1;

    using Strings for uint256;

    mapping(uint256 => string) private tokenURIs;
    string private baseURIextended;

    constructor() ERC721("Buidl NFT", "BNFT") {
        deployer = msg.sender;
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        baseURIextended = baseURI;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI)
        internal
        virtual
    {
        require(_exists(tokenId), "!exist");
        tokenURIs[tokenId] = _tokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURIextended;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "!exist");

        string memory _tokenURI = tokenURIs[tokenId];
        string memory base = _baseURI();

        // if there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }

        // if both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        // if there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function mint(
        address to,
        string memory uri
    ) external {
        _mint(to, tokenID);
        _setTokenURI(tokenID, uri);

        tokenID++;
    }

    function burn(uint256 tokenId) external {
      _burn(tokenId);
    }
}
