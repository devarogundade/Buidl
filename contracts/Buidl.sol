// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {BdlNft} from "./BdlNft.sol";
import {BdlCertificate} from "./BdlCertificate.sol";
import {Models} from "./base/Models.sol";
import {BdlToken} from "./BdlToken.sol";
import {BdlCourse} from "./BdlCourse.sol";
import {Staking} from "./Staking.sol";

contract Buidl {
    address private immutable deployer;

    /* fee charged on every succesful subscription made */
    uint256 private subscriptionFee = 10; // percentage rate

    BdlNft private _bdlNft; // nft reward (coupon) contract
    BdlToken private _bdlToken; // erc20(streamable token) contract
    BdlCertificate private _bdlCertificate; // erc4973 certificate contract
    BdlCourse private _bdlCourse; // course contract
    Staking private _staking; // staking contract

    // creators requirement
    // these requirement helps us to filter fuds
    // and abuse of the ecosystem
    uint256 private creatorStakingFee = 2000 * 10**18;
    uint256 private creatorStakingDuration = 365 * 0;

    // ecosystem users
    mapping(address => Models.User) public users;
    mapping(address => Models.Revenue) public revenues;

    // contructor
    constructor(
        address bdlToken,
        address bdlNft,
        address bdlCertificate,
        address bdlCourse,
        address staking
    ) {
        deployer = msg.sender;

        _bdlNft = BdlNft(bdlNft);
        _bdlToken = BdlToken(bdlToken);
        _bdlCertificate = BdlCertificate(bdlCertificate);
        _bdlCourse = BdlCourse(bdlCourse);
        _staking = Staking(staking);
    }

    /* creates user metadata */
    function setAccount(string memory name, string memory photo) public {
        emit User(msg.sender, name, photo, users[msg.sender].verified);
    }

    /* stake in the smart contract */
    function stake(uint256 amount) public {
        _bdlToken.approve(msg.sender, address(this), amount);
        _bdlToken.transferFrom(msg.sender, address(this), amount);
        _staking.stake(msg.sender, amount, creatorStakingDuration, 0);
    }

    /* unlock creator */
    function unlockCreator() public notVerified {
        // check if user has staked min requirement
        require(
            _staking.hasStaked(creatorStakingFee, msg.sender),
            "!stake_requirement_first"
        );

        users[msg.sender].verified = true;
        emit Creator(msg.sender, true);
    }

    /* remove creator */
    function removeCreator() public onlyVerified {
        users[msg.sender].verified = false;
        emit Creator(msg.sender, false);
    }

    /* subscribe to a course */
    /* params course id */
    function subscribe(uint id) public {
        (uint256 price, address creator) = _bdlCourse.subscribe(id, msg.sender);

        /* payment are locked in the smart contract */
        /* the course creator will be able to claim it after two weeks */
        /* if the course wasn't refunded by the subscriber */

        /* increase creator's unclaimed revenue */
        revenues[creator].unclaimed += price;

        _bdlToken.approve(msg.sender, address(this), price);
        _bdlToken.transferFrom(msg.sender, address(this), price);
    }

    /* subscribe to a course */
    /* params course id */
    function unSubscribe(uint id) public {
        (
            uint256 payableAmount,
            uint256 earnings,
            address creator,
            uint256 price
        ) = _bdlCourse.unSubscribe(id, msg.sender);

        _bdlToken.approve(msg.sender, address(this), payableAmount);
        _bdlToken.transferFrom(msg.sender, address(this), payableAmount);
        revenues[creator].unclaimed -= price;
        revenues[creator].claimable += earnings;
    }

    modifier onlyVerified() {
        /* only account that has staked atleast 2000 BDL token */
        require(users[msg.sender].verified, "!authorized");
        _;
    }

    modifier notVerified() {
        /* only account that hasn't staked atleast 2000 BDL token */
        require(!users[msg.sender].verified, "!authorized");
        _;
    }

    // == events == //
    event User(address owner, string name, string photo, bool verified);
    event Creator(address owner, bool verified);
}
