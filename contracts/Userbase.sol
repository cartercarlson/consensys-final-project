pragma solidity ^0.4.20;

contract Userbase {

    /* DECLARING VARIABLES */
    uint public idCount;

    /* MAPPING */

    mapping (uint => User) public users;
    mapping (uint => mapping (address => bool))

    /* EVENTS */

    event addUser (uint id);
    event logDepositBalance (uint id);
    event logWithdrawBalance (uint id);

    /* MODIFIERS */
    modifier isUser (uint _id) { require(users[_id].userAddress == msg.sender); _; };

    /* ENUMERATORS */


    /* STRUCTS */
    // Note: we do not need to disable deposits if user is banned.  If they're
    // banned and try to deposit, send funds to contract owner
    struct User {
        uint id;
        uint balance;
        bool renting;
        bool selling;
        bool canRent;
        bool canSell;
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
        returns (uint)
    {
        isUser(msg.sender);

        emit logDeposit(msg.sender);
        return users[msg.sender].balance;
    }

    function withdrawBalance(uint amount)
        public
        payable
        returns (uint)
    {
        isUser(msg.sender);

        emit logWithdrawBalance(msg.sender);
    }


}
