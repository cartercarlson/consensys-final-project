pragma solidity ^0.4.20;

contract Userbase {

    /* DECLARING VARIABLES */

    uint public idCount;

    /* MAPPING */

    mapping (uint => User) public users;
    mapping (address => bool) public isRenting;
	// mapping (uint => mapping (address => bool)) renters;
    // mapping (uint => mapping (address => bool)) sellers;

    /* EVENTS */

    event addUser (uint id);
    event removeUser (uint id);
	event bannedUser (uint id);
    event logSelling (uint id);
    event logRenting (uint id);
    event logDepositBalance (uint id);
    event logWithdrawBalance (uint id);


    /* MODIFIERS */


    modifier authorizedUser (uint _id) {
		require(users[_id].banned === false);
		require(users[_id].userAddress == msg.sender);
		_;
	};
	modifier canSell (uint _id) { require(users[_id].sell === true); _; };
	modifier canRent (uint _id) { require(users[_id].rent === true); _; };
	modifier isRenting (uint _id) { require(users[_id].isRenting === true); _; };


    /* ENUMERATORS */

    /* STRUCTS */

    // Note: we do not need to disable deposits if user is banned.  If they're
    // banned and try to do anything, prevent it
    struct User {
        uint id;
        uint balance;
        bool rent;
        bool isRenting;
        bool sell;
        bool banned;
        address userAddress;
    }


    /* CONSTRUCTOR */

    constructor() public {
        idCount = 0;
    }

    /* VIEWS */

    function getUser(uint _id) public view returns (address) {
        return users[_id].userAddress;
    }

    function getUsers() public view returns (address[]) {
        return users;
    }

    /* FUNCTIONS */

    function addUser()
        public
        returns (bool)
    {
        idCount = idCount + 1
        emit addUser(idCount);
        users[id] = User({
            id: idCount,
            balance: 0,
            renting: false,
            selling: false,
            canRent: false,
            canSell: false,
            banned: false,
            userAddress: msg.sender
        });
        return true;
    }

    function depositBalance(uint amount)
        public
        payable
        returns (uint)
    {
        authorizedUser(msg.sender);

        emit logDepositBalance(msg.sender);
        return users[msg.sender].balance;
    }


    function withdrawBalance(uint amount)
        public
        payable
        returns (uint)
    {
		authorizedUser(msg.sender);
        emit logWithdrawBalance(msg.sender);
    }


}
