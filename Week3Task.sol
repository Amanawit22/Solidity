// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

contract Week3Task {

    struct Person {
        string name;
        uint256 favoriteNumber;
    }

    Person[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;

    function addPersonToArray(string memory _name, uint256 _favoriteNumber) public {
        // Creates a new Person and stores it in the array
        people.push(Person(_name, _favoriteNumber));
    }

    function saveToMapping(string memory _name, uint256 _favoriteNumber) public {
        // In 0.5.11 'public' functions require 'memory' for strings
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    function updateName(uint256 index, string memory newName) public {
        require(index < people.length, "Index out of bounds");
        
        // Use STORAGE to modify the original struct inside the array
        Person storage person = people[index];
        person.name = newName;
    }

    function getPerson(uint256 index) public view returns (Person memory) {
        require(index < people.length, "Index out of bounds");
        return people[index];
    }

    function nameExists(string memory _name) public view returns (bool) {
        // Returns true if the favorite number is not 0
        return nameToFavoriteNumber[_name] != 0;
    }
}