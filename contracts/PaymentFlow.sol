// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {ISuperfluid} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {CFAv1Library} from "@superfluid-finance/ethereum-contracts/contracts/apps/CFAv1Library.sol";
import {IConstantFlowAgreementV1} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import {BdlToken} from "./BdlToken.sol";
import {Models} from "./base/Models.sol";

contract PaymentFlow {
    using CFAv1Library for CFAv1Library.InitData;

    CFAv1Library.InitData private cfaV1Lib;

    BdlToken private _token;
    ISuperfluid private _superFluid;
    IConstantFlowAgreementV1 private _agreement;

    address private host = 0xEB796bdb90fFA0f28255275e16936D25d3418603; // superfluid host address
    address private cfa = 0x49e565Ed1bdc17F3d220f72DF0857C26FA83F873; // superfluid cfa address

    constructor(address token) {
        _token = BdlToken(token);
        _superFluid = ISuperfluid(host);
        _agreement = IConstantFlowAgreementV1(cfa);

        cfaV1Lib = CFAv1Library.InitData(_superFluid, _agreement);
    }

    function createFlow(address receiver, int96 flowRate) public {
        cfaV1Lib.createFlow(receiver, _token, flowRate);
    }

    function updateFlow(address receiver, int96 flowRate) public {
        cfaV1Lib.updateFlow(receiver, _token, flowRate);
    }

    function deleteFlow(address receiver) public {
        cfaV1Lib.deleteFlow(address(this), receiver, _token);
    }
}
