// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {BaseSuperToken} from "./BaseSuperToken.sol";
import {ISuperfluid} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";


contract BdlToken is BaseSuperToken {
    address private deployer;

    string private tokenName = "Bdl Token";
    string private tokenSymbol = "BDL";
    uint256 private tokenTotalSupply = 10000000000000000000000000000000;

    constructor(ISuperfluid host) BaseSuperToken(host, tokenName, tokenSymbol, tokenTotalSupply) {}

    function mint(address owner, uint256 amount) public returns (bool) {
        return _transferFrom(deployer, deployer, owner, amount);
    }

    function increaseAllowance(
        address owner,
        address spender,
        uint256 addedValue
    ) public returns (bool) {
        _approve(msg.sender, spender, _allowances[owner][spender] + addedValue);
        return true;
    }
}
