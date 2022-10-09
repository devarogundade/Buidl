// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Models.sol";

contract Talent {

    uint256 public talentIDtrack = 1;

    address deployer;
    mapping(uint => Models.Talent) public talents;

    constructor() {
        deployer = msg.sender;

        // this talents are added by default to saves time
        addTalent("Voice Over", "A simple desc");
        addTalent("Animator", "A simple desc");
        addTalent("Blockchain Developer", "A simple desc");
        addTalent("UI Designer", "A simple desc");
        addTalent("Web Developer", "A simple desc");
        addTalent("Video Editing", "A simple desc");
        addTalent("Crypto Advisor", "A simple desc");
        addTalent("Data Scientist", "A simple desc");
        addTalent("Mobile Developer", "A simple desc");
        addTalent("Translation", "A simple desc");
        addTalent("Email Marketing", "A simple desc");
        addTalent("Metaverse Expert", "A simple desc");
        addTalent("Illustrating", "A simple desc");
        addTalent("NFT Artist", "A simple desc");
        addTalent("HR Consulting", "A simple desc");
    }

    function addTalent(string memory name, string memory description) public {
        require(msg.sender == deployer, "You have the rights");

        talents[talentIDtrack] = Models.Talent(
            talentIDtrack,
            name,
            description
        );

        talentIDtrack++;
    }

}