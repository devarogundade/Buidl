// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {ISuperfluid, ISuperToken, ISuperApp, ISuperAgreement, SuperAppDefinitions} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {CFAv1Library} from "@superfluid-finance/ethereum-contracts/contracts/apps/CFAv1Library.sol";
import {IConstantFlowAgreementV1} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import {SuperAppBase} from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperAppBase.sol";
import {BdlToken} from "./BdlToken.sol";

contract PaymentFlow is SuperAppBase {
    using CFAv1Library for CFAv1Library.InitData;

    CFAv1Library.InitData public cfaV1Lib;
    bytes32 public constant CFA_ID =
        keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1");

    address public _deployer;

    BdlToken private _token;
    ISuperfluid private _superFluid;
    IConstantFlowAgreementV1 private _agreement;

    address private host = 0xEB796bdb90fFA0f28255275e16936D25d3418603;
    address private cfa = 0x49e565Ed1bdc17F3d220f72DF0857C26FA83F873;

    constructor(address token) {
        _deployer = msg.sender;
        _token = BdlToken(token);
        _superFluid = ISuperfluid(host);
        _agreement = IConstantFlowAgreementV1(cfa);

        cfaV1Lib = CFAv1Library.InitData(_superFluid, _agreement);

        uint256 configWord = SuperAppDefinitions.APP_LEVEL_FINAL |
            SuperAppDefinitions.BEFORE_AGREEMENT_CREATED_NOOP |
            SuperAppDefinitions.BEFORE_AGREEMENT_UPDATED_NOOP |
            SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP;

        _superFluid.registerApp(configWord);
    }

    function startStreaming(address receiver, int96 flowRate) public {
        cfaV1Lib.createFlow(receiver, _token, flowRate);
    }

    function stopStreaming(address receiver) public {
        cfaV1Lib.deleteFlow(_deployer, receiver, _token);
    }

    function _isSameToken(ISuperToken superToken) private view returns (bool) {
        return address(superToken) == address(_token);
    }

    function _isCFAv1(address agreementClass) private view returns (bool) {
        return ISuperAgreement(agreementClass).agreementType() == CFA_ID;
    }

    modifier onlyHost() {
        require(
            msg.sender == address(cfaV1Lib.host),
            "RedirectAll: support only one host"
        );
        _;
    }

    modifier onlyExpected(ISuperToken superToken, address agreementClass) {
        require(_isSameToken(superToken), "RedirectAll: not accepted token");
        require(_isCFAv1(agreementClass), "RedirectAll: only CFAv1 supported");
        _;
    }
}
