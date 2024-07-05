// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract MyToken {
    // public variables here
    string public tokenfirstName = "V";
    string public tokenlastname = "C";
    uint public totalSupply = 10;
    
    // Owner address
    address public owner;

    //mapping variables here
    mapping (address => uint) public balances;

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }
    
    // Modifier that only allows the owner to perform the action
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    //mint function code here increases balances
    function minttoken(address _address, uint _value) public onlyOwner {
        totalSupply += _value;
        balances[_address] += _value;
    }

    //burn function code here opposite of mint function
    function burntoken(address _address, uint _value) public onlyOwner {
        require(balances[_address] >= _value, "you  do not have sufficient balance");

        totalSupply -= _value;
        balances[_address] -= _value;
    }

    function transfertoken(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "you dont have sufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
