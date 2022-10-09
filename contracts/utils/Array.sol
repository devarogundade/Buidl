// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array {

    function uintExists(uint[] memory array, uint id) public pure returns (bool){
        for (uint i; i < array.length; i++){
            if (array[i] == id)
            return true;
        }
        return false;
    }

}