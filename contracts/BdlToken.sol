// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BdlToken is ERC20 {

    address deployer;
    uint256 public mintAllocation = 200 * 10 ** decimals();

    mapping(address => uint256) public mints;

    constructor() ERC20("Buidl Token", "BDL") {
        deployer = msg.sender;
        _mint(msg.sender, 10000000000 * 10 ** decimals()); // ten billion
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

    function increaseAllowance(address owner, address spender, uint256 amount) public virtual returns (bool) {
        _approve(owner, spender, allowance(owner, spender) + amount);
        return true;
    }

    event Minted(address, uint256);
    event Charged(address, uint256);

}
