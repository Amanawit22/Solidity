// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage public simpleStorage;

    // This runs before every single test
    function setUp() public {
        simpleStorage = new SimpleStorage();
    }

    function test_InitialValueIsZero() public {
        assertEq(simpleStorage.retrieve(), 0);
    }

    function test_StoreValue() public {
        simpleStorage.store(42);
        assertEq(simpleStorage.retrieve(), 42);
    }
}