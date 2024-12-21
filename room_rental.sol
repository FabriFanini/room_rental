// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract hotelRoom {
    //Struct
    struct Room {
        string name;
        string state;
    }

    //events
    event roomOccupied (string stateRoom);
    event roomFreed(string roomName);

    //variables
    address payable private owner;
    uint price = 1 ether;

    string[2] states = ["free", "occupied"];
    Room [] rooms;
    mapping (string => uint) indexRoom;

    //constructor
    constructor(){
        owner = payable(msg.sender);
        rooms.push(Room ("single room", states[0]));
        indexRoom["Single room"] = 0;

        rooms.push(Room ("double room", states[0]));
        indexRoom["Double room"] = 1;

        rooms.push(Room ("triple room", states[0]));
        indexRoom["triple room"] = 2;

        rooms.push(Room ("connecting room", states[0]));
        indexRoom["connecting room"] = 3;

        rooms.push(Room ("suite", states[0]));
        indexRoom["suite room"] = 4;
    }

    //Functions
    function Rooms () external view returns (Room [] memory) 
    {
        return rooms;
    }

    function compareStrings (string memory a, string memory b) internal pure returns (bool)
    {
        return (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b)));
    }

    function getARoom (string memory _roomName) external payable 
    {
        uint i= indexRoom[_roomName];
        
        require(msg.value >= price, "Insufficient funds");
        require(compareStrings(_roomName, rooms[i].name), "The name doesn't exist.");
        require(compareStrings(rooms[i].state, states[0]), "Room is already occupied.");

        rooms[i].state = states[1];

        owner.transfer(msg.value);

        emit roomOccupied(rooms[i].state);
    }

    function setRoomToFree (string memory _roomName) external onlyOwner
    {
        uint i = indexRoom[_roomName];

        require(compareStrings(_roomName,rooms[i].name), "The name doesn't exist.");
        
        rooms[i].state = states[0];

        emit roomFreed(_roomName);
    }

    //modifier
    modifier onlyOwner 
    {
        require(owner == msg.sender, "Null operation, only the owner can do this.");
        _;
    }


}
