// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SavingsBank.sol";

contract SavingsBankTest is Test {
    SavingsBank public bank;
    // Use addresses that look more like real wallets
address user1 = makeAddr("user1"); 
address user2 = makeAddr("user2");

    function setUp() public {
        bank = new SavingsBank();
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    function testDeposit() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        assertEq(bank.getBalance(user1), 1 ether);
        assertEq(bank.getTotalContractBalance(), 1 ether);
    }

    function test_WithdrawMoreThanBalance_ShouldRevert() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        
        // This tells Foundry: "I expect the very next line to fail"
        vm.expectRevert(); 
        
        vm.prank(user1);
        bank.withdraw(2 ether); 
    }

    function testWithdrawalUpdatesBalance() public {
        // Record the balance BEFORE we start this specific test
        uint256 startingTotal = bank.getTotalContractBalance();

        vm.startPrank(user1);
        bank.deposit{value: 0.1 ether}(); // Use a larger amount to stay safe from MIN_DEPOSIT
        bank.withdraw(0.02 ether);
        vm.stopPrank();

        assertEq(bank.getBalance(user1), 0.08 ether);
        // The total should be what it was before, plus the 0.08 net gain
        assertEq(bank.getTotalContractBalance(), startingTotal + 0.08 ether);
    }

    function testMultipleUsers() public {
        vm.prank(user1);
        bank.deposit{value: 0.01 ether}();
        
        vm.prank(user2);
        bank.deposit{value: 0.015 ether}();

        assertEq(bank.getTotalContractBalance(), 0.025 ether);
    }
}