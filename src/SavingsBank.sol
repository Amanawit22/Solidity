// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SavingsBank {
    mapping(address => uint256) private balances;
    uint256 public constant MIN_DEPOSIT = 0.01 ether;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    error InsufficientBalance();
    error BelowMinimumDeposit();

    function deposit() public payable {
        if (msg.value < MIN_DEPOSIT) revert BelowMinimumDeposit();
        
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        if (_amount > balances[msg.sender]) revert InsufficientBalance();

        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        
        emit Withdrawn(msg.sender, _amount);
    }

    function getBalance(address _user) public view returns (uint256) {
        return balances[_user];
    }

    function getTotalContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}