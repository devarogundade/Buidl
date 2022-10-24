// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {BdlNft} from "./BdlNft.sol";
import {BdlCertificate} from "./BdlCertificate.sol";
import {Models} from "./base/Models.sol";
import {PaymentFlow} from "./PaymentFlow.sol";
import {BdlToken} from "./BdlToken.sol";
import {BdlCourse} from "./BdlCourse.sol";

contract Buidl {
    address private immutable deployer;

    BdlNft private _bdlNft; // nft reward (coupon) contract
    BdlToken private _bdlToken; // erc20(streamable token) contract
    BdlCertificate private _bdlCertificate; // erc4973 certificate contract
    BdlCourse private _bdlCourse; // course contract
    PaymentFlow private _paymentFlow; // flow (erc20 streaming) contract

    // creators requirement
    // these requirement helps us to filter fuds
    // and abuse of the ecosystem
    uint256 private creatorStakingFee = 2000 * 10**18;
    uint256 private creatorStakingDuration = 365 * 0;

    // ecosystem users
    mapping(address => Models.User) public users;

    // contructor
    constructor(
        address bdlToken,
        address bdlNft,
        address bdlCertificate,
        address bdlCourse,
        address paymentFlow
    ) {
        deployer = msg.sender;

        _bdlNft = BdlNft(bdlNft);
        _bdlToken = BdlToken(bdlToken);
        _bdlCertificate = BdlCertificate(bdlCertificate);
        _bdlCourse = BdlCourse(bdlCourse);
        _paymentFlow = PaymentFlow(paymentFlow);
    }

    // bdlCourse
    function createCourse(uint id, uint256 price) public onlyVerified {
        _bdlCourse.createCourse(id, price, msg.sender);
    }

    modifier onlyVerified() {
        require(users[msg.sender].verified, "!authorized");
        _;
    }
}
