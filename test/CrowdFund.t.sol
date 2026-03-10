// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CrowdFund.sol";

contract CrowdFundTest is Test {
    CrowdFund public crowdfund;
    address public user1 = address(1);
    address public owner = address(2);

    function setUp() public {
        crowdfund = new CrowdFund();
    }

    function testCreateCampaign() public {
        vm.prank(owner);
        crowdfund.create(10 ether, 1 days);
        
        (address _owner, uint256 _goal, , , , ) = crowdfund.campaigns(1);
        assertEq(_owner, owner);
        assertEq(_goal, 10 ether);
    }

    function testPledge() public {
        crowdfund.create(10 ether, 1 days);
        
        // Give user1 some money and pledge
        vm.deal(user1, 5 ether);
        vm.prank(user1);
        crowdfund.pledge{value: 5 ether}(1);

        (, , uint256 _pledged, , , ) = crowdfund.campaigns(1);
        assertEq(_pledged, 5 ether);
        assertEq(crowdfund.pledgedAmount(1, user1), 5 ether);
    }

    function testClaimSuccess() public {
        vm.prank(owner);
        crowdfund.create(1 ether, 1 days);

        vm.deal(user1, 2 ether);
        vm.prank(user1);
        crowdfund.pledge{value: 1.5 ether}(1);

        // Fast forward time so campaign ends
        skip(2 days);

        uint256 ownerBalanceBefore = owner.balance;
        vm.prank(owner);
        crowdfund.claim(1);

        assertEq(owner.balance, ownerBalanceBefore + 1.5 ether);
    }
}