pragma solidity ^0.4.20;

contract Userbase {

    /* DECLARING VARIABLES */
    uint public idCount;

    /* MAPPING */

    mapping (uint => User) public users;

    /* EVENTS */

    event addUser (uint id);

    /* MODIFIERS */
    // modifier isUser (uint _id) { require() }

    /* ENUMERATORS */


    /* STRUCTS */

    struct User {
        uint id;
        uint balance;
        bool renting;
        bool selling;
        bool canRent;
        bool canSell;
        address userAddress;
    }


    /* CONSTRUCTOR */
    
    constructor() public {
        idCount = 0;
    }

    /* VIEWS */

    function getUser(uint _id) public view returns (address) {
        return users[_id].userAddress
    }

    function getUsers() public view returns (address[]) {
        return users;
    }

    function getSellers() public view returns (address[]) {
        // do something
    }

    function getBuyers() public view returns (address[]) {
        // do something
    }

    /* FUNCTIONS */

    function addUser()
        public
        returns (bool)
    {
        idCount = idCount + 1
        emit addUser(idCount)
        users[id] = User({
            id: idCount,
            balance: 0,
            renting: false,
            selling: false,
            canRent: false,
            canSell: false,
            userAddress: msg.sender
        });
        return true;
    }


}
