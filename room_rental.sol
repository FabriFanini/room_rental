// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract hotelRoom {
    //Struct
    struct Room {
        string name;
        string state;
        uint price;
    }

    //events
    event roomOccupied (string room, string stateRoom);
    event roomFreed(string roomName);

    //variables
    address payable private owner;
    uint price = 1 ether;

    string[2] states = ["free", "occupied"];
    Room [] rooms;
    mapping (string => uint) indexRoom;
    // string [5] rooms = ["Single room", "Double room", "Triple room", "Connecting room", "Suite"];

    //constructor
    constructor(){
        owner = payable(msg.sender);
        rooms.push(Room ("single room", states[0], price / 1 ether));
        indexRoom["Single room"] = 0;

        rooms.push(Room ("double room", states[0], price / 1 ether));
        indexRoom["Double room"] = 1;

        rooms.push(Room ("triple room", states[0], price / 1 ether));
        indexRoom["triple room"] = 2;

        rooms.push(Room ("connecting room", states[0], price / 1 ether));
        indexRoom["connecting room"] = 3;

        rooms.push(Room ("suite", states[0], price / 1 ether));
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
        
        require(msg.value >= rooms[i].price, "Insufficient funds");
        checkName(_roomName, i);
        require(compareStrings(rooms[i].state, states[0]), "Room is already occupied.");

        rooms[i].state = states[1];

        owner.transfer(msg.value);

        emit roomOccupied(rooms[i].name, rooms[i].state);
    }

    function setRoomToFree (string memory _roomName) external onlyOwner
    {
        uint i = indexRoom[_roomName];

        checkName(_roomName, i);

        rooms[i].state = states[0];

        emit roomFreed(_roomName);
    }

    function updatePrice (string memory _roomName, uint _price) external onlyOwner 
    {
        uint i = indexRoom[_roomName];
        checkName(_roomName, i);
        rooms[i].price = _price;
    }

    function checkName (string memory _roomName, uint i) internal view
    {
        require(compareStrings(_roomName,rooms[i].name), "The name doesn't exist.");
    }

    //modifier
    modifier onlyOwner 
    {
        require(owner == msg.sender, "Null operation, only the owner can do this.");
        _;
    }


}