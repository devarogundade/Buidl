// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./base/ERC4973.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BdlCertificate is ERC4973, Ownable {
    address deployer;
    uint256 certificateID = 1;

    mapping(uint256 => string) private tokenURIs;
    string private baseURIextended;

    constructor(string memory name, string memory symbol)
        ERC4973(name, symbol)
    {
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

        // if there is a baseURI but no tokenURI, concatenate the certificateID to the baseURI.
        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function burn(uint256 certificateId) external override onlyOwner {
        _burn(certificateId);

        emit Revoke(address(0), certificateId);
    }

    function issue(address student, string calldata uri) external {
        _mint(student, certificateID, uri);

        emit Attest(student, certificateID);
        certificateID++;
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "!authorized");
        _;
    }
}
