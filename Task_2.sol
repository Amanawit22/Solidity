// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/*
contract SimpleStorage{
  /*  //bool,unit, int,address,bytes
    bool hasFavNum = true;
    uint256 favnum= 29;
    address aman  = 0x67e8491E4170b8A3eE06B6b994Ec6B1F35BE94DD;


uint public FavNum;
function store( uint256 _FavNum)   (uint256){
return  11;

}

}*/


contract Task2 {

    // --------------------------------------------------------
    // VARIABLES
    // --------------------------------------------------------

    uint public number;
    string private message = "Hello GDG AASTU!";
    bool public isActive = true;


    // --------------------------------------------------------
    // FUNCTIONS
    // --------------------------------------------------------

    // Updates the public variable "number"
    function setNumber(uint newNumber) public {
        number = newNumber;
    }

    // Returns the private message (VIEW FUNCTION)
    function getMessage() public view returns (string memory) {
        return message;
    }


    // Returns sum of two numbers (PURE FUNCTION)
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }


    // Toggles the boolean isActive state
    function toggleActive() public {
        isActive = !isActive;
    }


    // Returns true only if number > 10 (VIEW FUNCTION)
    function isNumberBig() public view returns (bool) {
        return number > 10;
    }

}
