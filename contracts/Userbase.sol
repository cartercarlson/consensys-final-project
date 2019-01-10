pragma solidity ^0.4.20;

contract Userbase {

    /* DECLARING VARIABLES */

    uint public idCount;

    /* MAPPING */

    mapping (uint => User) public users;
    mapping (address => bool) public permissioned;
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
    event logEnableUserRent (uint id);
    event logEnableUserSell (uint id);


    /* MODIFIERS */


    modifier authorizedUser (uint _id) {
        require (permissioned[msg.sender] === true);
		require (users[_id].userAddress == msg.sender);
		_;
	};
	modifier canSell (uint _id) { require(users[_id].sell === true); _; };
	modifier canRent (uint _id) { require(users[_id].rent === true); _; };
	modifier isRenting (uint _id) { require(users[_id].isRenting === true); _; };
	modifier userExists(uint _id) { require _id > 0 && _id < idCount }

    /* ENUMERATORS */

    /* STRUCTS */

    // Note: we do not need to disable deposits if user is banned.  If they're
    // banned and try to do anything, prevent it
    struct User {
        uint id;
        address userAddress;
        bool rent;
        bool isRenting;
        bool sell;
        uint balance;
    }


    /* CONSTRUCTOR */

    constructor() public {
        idCount = 0;
    }

    /* VIEWS */

    function getUser(uint _id)
        public
        view
        returns (
            uint _id,
            address userAddress,
            bool rent,
            bool isRenting,
            bool sell,
            uint balance
        )
    {
        userExists(_id);
        User storage user = users[_id];

        address = user.userAddress;
        rent = user.rent;
        isRenting = user.isRenting;
        sell = user.sell;
        balance = user.balance;
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
            userAddress: msg.sender
            rent: false,
            sell: false,
            isRenting: false,
            balance: 0

        });
        return true;
    }

    function addToPermissioned (address _user)
        public
    {
        require (buyer != 0x0);
        permissioned[_user] = true;
    }

    function enableUserRent (uint _id)
        public
    {
        authorizedUser(msg.sender);
        emit logEnableUserRent(uint _id);
        users[_id].rent = true;
    }


    function enableUserSell (uint _id)
        public
    {
        authorizedUser(msg.sender);
        emit logEnableUserSell(uint _id);
        users[_id].sell = true;
    }

    function depositBalance(uint amount)
        public
        returns (uint)
    {
        authorizedUser(msg.sender);

        emit logDepositBalance(msg.sender);
        users[msg.sender] += msg.value;
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
