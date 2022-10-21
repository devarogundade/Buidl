// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ERC4973.sol";

contract BdlCertificate is ERC4973 {
    address deployer;
    uint256 certificatesCount = 1;

    constructor() ERC4973("Buidl Certificate", "BCTK") {
        deployer = msg.sender;
    }

    function burn(uint256 certificateId) external override onlyOwner {
        _burn(certificateId);

        emit Revoke(address(0), certificateId);
    }

    function issue(address student, string calldata uri) external {
        _mint(student, certificatesCount, uri);

        emit Attest(student, certificatesCount);
        certificatesCount++;
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "!authorized");
        _;
    }
}
