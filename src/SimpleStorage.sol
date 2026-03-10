// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SimpleStorage {
    uint256 private favoriteNumber;

    // Function to update our number
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // Function to read our number
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }
}