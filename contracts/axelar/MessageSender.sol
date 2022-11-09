// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {AxelarExecutable} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/executables/AxelarExecutable.sol";
import {IAxelarGateway} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol";
import {IAxelarGasService} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGasService.sol";

import {Message} from "./Message.sol";

// message receiver @Buidl.sol

contract MessageSender is AxelarExecutable {
    /* axelar */
    IAxelarGasService public immutable gasReceiver;

    /* destination */
    string private destinationChain;
    string private destinationAddress;

    constructor(
        address gateway_,
        address gasReceiver_,
        string memory destinationChain_,
        string memory destinationAddress_
    ) AxelarExecutable(gateway_) {
        gasReceiver = IAxelarGasService(gasReceiver_);

        destinationChain = destinationChain_;
        destinationAddress = destinationAddress_;
    }

    /* @param id == the course id on bsc testnet */
    function subscribe(uint id, uint256 nftId) public payable {
        bytes memory message = abi.encode(id, nftId, msg.sender);
        bytes memory payload = Message.packMessage(Message.SUBSCRIBE, message);

        if (msg.value > 0) {
            gasReceiver.payNativeGasForContractCall{value: msg.value}(
                address(this),
                destinationChain,
                destinationAddress,
                payload,
                msg.sender
            );
        }

        gateway.callContract(destinationChain, destinationAddress, payload);
    }
}
