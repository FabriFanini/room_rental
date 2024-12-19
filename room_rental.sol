// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract hotelRoom {
    //events
    event roomOccupied (string stateRoom);

    //variables
    address payable private owner;
    string stateRoom;
    uint price = 1 ether;

    string[2] states = ["free", "occupied"];

    //constructor
    constructor(){
        owner = payable(msg.sender);
        stateRoom = states[0];
    }

    //Functions
    function compareStrings (string memory a, string memory b) internal pure returns (bool)
    {
        return (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b)));
    }

    function occupyAndPayRoom() external payable 
    {
        require(compareStrings(stateRoom, states[0]), "The room is occuppied");
        require(msg.value >= price, "Insufficient funds");

        owner.transfer(msg.value);

        stateRoom = states[1];

        emit roomOccupied(stateRoom);
    }

    function setRoomToFree () external
    {
        stateRoom = states[0];
    }

    //modifier
    modifier onlyOwner 
    {
        require(owner == msg.sender, "Null operation, only the owner can do this.");
        _;
    }


}