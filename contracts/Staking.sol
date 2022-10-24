// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {Models} from "./base/Models.sol";

contract Staking {
    address _stakeAddress;
    mapping(address => Models.Stake) public stakes;

    constructor(address stakeAddress) {
        _stakeAddress = stakeAddress;
    }

    function stake(
        address from,
        uint256 amount,
        uint duration,
        uint96 rewardFlowRate
    ) external {
        require(amount > 0, "!stake_zero_tokens");

        stakes[from] = Models.Stake(
            amount,
            block.timestamp,
            duration,
            rewardFlowRate
        );

        emit StakingStaked(from, amount);
    }

    function claim(address from) external {
        Models.Stake memory _stake = stakes[from];
        require(_stake.amount != 0, "!exists");

        uint unlockTime = (_stake.time + _stake.duration);
        require(block.timestamp >= unlockTime, "tooeary");

        delete stakes[from];

        emit StakingUnStaked(from);
    }

    // == events == //
    event StakingStaked(address from, uint256 amount);
    event StakingUnStaked(address from);
}
