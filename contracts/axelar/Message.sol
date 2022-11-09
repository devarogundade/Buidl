// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library Message {
    /* all messaging topics */
    // ==== //
    /* subscription */
    uint constant SUBSCRIBE = 1;
    uint constant UN_SUBSCRIBE = 2;
    /* course */
    uint constant CREATE_COURSE = 3;
    uint constant UPDATE_COURSE = 4;
    /* user */
    uint constant CREATE_USER = 5;
    uint constant UN_LOCK_CREATOR = 6;
    uint constant LOCK_CREATOR = 7;
    /* staking */
    uint constant STAKE = 8;
    uint constant UN_STAKE = 9;
    /* revenue */
    uint constant CLAIM_REVENUE = 10;
    /* category */
    uint constant CREATE_CATEGORY = 11;

    /* create a new message */
    function packMessage(uint _topic, bytes memory _data)
        public
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(_topic, _data);
    }

    /* reveal a message */
    function unPackMessage(bytes memory _data)
        public
        pure
        returns (uint, bytes memory)
    {
        (uint topic, bytes memory data) = abi.decode(_data, (uint, bytes));
        return (topic, data);
    }
}
