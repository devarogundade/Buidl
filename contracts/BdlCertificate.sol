// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ERC4973.sol";

contract BdlCertificate is ERC4973 {
    address public deployer;
    uint256 public certificatesCount = 0;

    constructor() ERC4973("Buidl Certificate", "BCTK") {
        deployer = msg.sender;
    }

    function burn(uint256 certificateId) external override {
        require(ownerOf(certificateId) == msg.sender || msg.sender == deployer, "You can't revoke this certificate");
        _burn(certificateId);
    }

    function issue(address student, string calldata uri) external {
        _mint(student, certificatesCount, uri);
        certificatesCount += 1;
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "!authorized");
        _;
    }
}
