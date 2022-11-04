// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./../base/ERC4973.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract BdlCertificate is ERC4973 {
    address deployer;
    uint256 certificateID = 1;

    mapping(uint256 => string) private certificateURIs;

    constructor(string memory name, string memory symbol)
        ERC4973(name, symbol)
    {
        deployer = msg.sender;
    }

    function burn(uint256 certificateId) external override onlyOwner {
        _burn(certificateId);

        emit Revoke(address(0), certificateId);
    }

    function issue(address learner, string calldata uri) external {
        _mint(learner, certificateID, uri);
        certificateURIs[certificateID] = uri;

        emit Attest(learner, certificateID, uri);
        certificateID++;
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "!authorized");
        _;
    }
}
