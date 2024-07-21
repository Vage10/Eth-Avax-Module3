# Create and Mint Token
Writing a smart contract to create our own token and deploy it using HardHat 

## Description
MyToken is a simple ERC20-like token implementation on the Ethereum blockchain. This smart contract allows the owner to mint and burn tokens and enables token holders to transfer tokens to other addresses. The contract also tracks the balances of each address holding the token.


## Getting Started

### Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Create_token.sol). Copy and paste the following code into the file:

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

## Usage

### Minting Tokens
Only the contract owner can mint new tokens. To mint tokens, call the minttoken function:
  ```
function minttoken(address _address, uint _value) public onlyOwner
```
Example:
```
npx hardhat console --network localhost
const MyToken = await ethers.getContractFactory("MyToken")
const myToken = await MyToken.deploy()
await myToken.deployed()
await myToken.minttoken("0xYourAddress", 100)
```
### Burning Tokens
Only the contract owner can burn tokens. To burn tokens, call the burntoken function:
```
function burntoken(address _address, uint _value) public onlyOwner
```
Example:
```
npx hardhat console --network localhost
await myToken.burntoken("0xYourAddress", 50)
```
### Transferring Tokens
Token holders can transfer their tokens to other addresses by calling the transfertoken function:
```
function transfertoken(address to, uint256 amount) public
```
Example:
```
npx hardhat console --network localhost
await myToken.transfertoken("0xRecipientAddress", 10)
```
### Checking Balances
To check the balance of any address, simply access the balances mapping:
```
mapping (address => uint) public balances
```
Example:
```
npx hardhat console --network localhost
const balance = await myToken.balances("0xYourAddress")
console.log(balance.toString())
```

## Author
Vageshwari Chaudhary

## License
This project is licensed under the MIT License - see the LICENSE file for details.
