// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {IAxelarGateway} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol";
import {IAxelarGasService} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGasService.sol";
import {StringToAddress, AddressToString} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/StringAddressUtils.sol";

import {Message} from "./Message.sol";

// message receiver @Buidl.sol

contract MessageSender {
    using StringToAddress for string;
    using AddressToString for address;
    /* axelar */
    IAxelarGasService gasReceiver;
    IAxelarGateway gateway;

    /* destination */
    string destinationChain;
    string destinationAddress;

    constructor(
        address gateway_,
        address gasReceiver_,
        string memory destinationChain_,
        string memory destinationAddress_
    ) {
        gateway = IAxelarGateway(gateway_);
        gasReceiver = IAxelarGasService(gasReceiver_);
        destinationChain = destinationChain_;
        destinationAddress = destinationAddress_;
    }

    function subscribe(uint id) public payable {
        bytes memory message = abi.encode(id, msg.sender);
        bytes memory payload = Message.packMessage(
            Message.Title.SUBSCRIBE,
            message
        );

        gasReceiver.payNativeGasForContractCall{value: msg.value}(
            address(this),
            destinationChain,
            destinationAddress,
            payload,
            msg.sender
        );

        gateway.callContract(destinationChain, destinationAddress, payload);
    }
}
