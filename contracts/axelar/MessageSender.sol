// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {IAxelarGateway} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol";
import {IAxelarGasService} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGasService.sol";

import {Message} from "./Message.sol";

contract MessageSender {
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

        if (msg.value > 0) {
            gasReceiver.payNativeGasForContractCall{value: msg.value}(
                address(this),
                destinationChain,
                destinationAddress,
                payload,
                msg.sender
            );

            call(payload);
        }
    }

    /* sends message */
    function call(bytes memory payload) private {
        gateway.callContract(destinationChain, destinationAddress, payload);
    }
}
