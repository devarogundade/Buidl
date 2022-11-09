// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./../base/ERC4973.sol";

contract BdlCertificate is ERC4973 {
    address private deployer;
    uint private certificateID = 1;

    mapping(uint256 => string) public certificateURIs;

    constructor(string memory name, string memory symbol)
        ERC4973(name, symbol)
    {
        deployer = msg.sender;
    }

    function burn(uint256 certificateId) external override onlyDeployer {
        _burn(certificateId);

        emit Revoke(address(0), certificateId);
    }

    function issue(address learner, string calldata uri) external {
        _mint(learner, certificateID, uri);
        certificateURIs[certificateID] = uri;

        emit Attest(learner, certificateID);
        emit Issued(certificateID, learner, uri);
        certificateID++;
    }

    modifier onlyDeployer() {
        require(msg.sender == deployer, "!authorized");
        _;
    }

    event Issued(uint id, address owner, string uri);
}
