// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library Message {
    /* all messaging topics */
    enum Title {
        /* subscription */
        SUBSCRIBE,
        UN_SUBSCRIBE,
        /* course */
        CREATE_COURSE,
        UPDATE_COURSE,
        /* user */
        CREATE_USER,
        UN_LOCK_CREATOR,
        LOCK_CREATOR,
        /* staking */
        STAKE,
        UN_STAKE,
        /* revenue */
        CLAIM_REVENUE,
        /* category */
        CREATE_CATEGORY
    }

    /* create a new message */
    function packMessage(Title _messageTitle, bytes memory _data)
        public
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(_messageTitle, _data);
    }

    /* reveal a message */
    function unPackMessage(bytes memory _data)
        public
        pure
        returns (Title, bytes memory)
    {
        (Title messageTitle, bytes memory data) = abi.decode(
            _data,
            (Title, bytes)
        );
        return (messageTitle, data);
    }
}
