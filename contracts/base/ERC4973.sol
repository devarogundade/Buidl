// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {IERC4973Metadata} from "./IERC4973Metadata.sol";
import {IERC4973} from "./IERC4973.sol";

abstract contract ERC4973 is ERC165, IERC4973Metadata, IERC4973 {
    string private _name;
    string private _symbol;

    mapping(uint256 => address) private owners;
    mapping(uint256 => string) private tokenURIs;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC4973Metadata).interfaceId ||
            interfaceId == type(IERC4973).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "tokenURI: token doesn't exist");
        return tokenURIs[tokenId];
    }

    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return owners[tokenId] != address(0);
    }

    function ownerOf(uint256 tokenId)
        public
        view
        virtual
        override
        returns (address)
    {
        address owner = owners[tokenId];
        require(owner != address(0), "ownerOf: token doesn't exist");
        return owner;
    }

    function _mint(
        address to,
        uint256 tokenId,
        string calldata uri
    ) internal virtual returns (uint256) {
        require(!_exists(tokenId), "mint: tokenID exists");
        owners[tokenId] = to;
        tokenURIs[tokenId] = uri;
        emit Attest(to, tokenId, uri);
        return tokenId;
    }

    function _burn(uint256 tokenId) internal virtual {
        address owner = ownerOf(tokenId);

        delete owners[tokenId];
        delete tokenURIs[tokenId];

        emit Revoke(owner, tokenId);
    }
}
