// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20.sol";

contract BdlToken is ERC20 {

    address deployer;
    uint256 public mintAllocation = 200 * 10 ** decimals();

    mapping(address => uint256) public mints;

    constructor() ERC20("Buidl Token", "BDL") {
        deployer = msg.sender;
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function mint(address _address) public {
        require((mints[_address] < mintAllocation), "You can't mint more tokens");
        _transfer(deployer, _address, mintAllocation);
        mints[_address] = mintAllocation;
        emit Minted(_address, mintAllocation);
    }

    // deducts token from user for a particular service
    function charge(address from, uint256 amount) public {
        _transfer(from, deployer, amount);
        emit Charged(from, amount);
    }

    event Minted(address, uint256);
    event Charged(address, uint256);

}
