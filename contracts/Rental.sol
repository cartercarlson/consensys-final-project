pragma solidity ^0.4.20;

contract Rental {

    /* DECLARING VARIABLES */

    address public owner;
    address[] public sellers;
    address[] public renters;
    int public idCount;

    /* MAPPING */

    mapping (uint => Apartment) public apartments;
    mapping (address => bool) public isRenter;
    mapping (address => uint) internal balances;

    /* EVENTS */

    event apartmentAdded (uint id);
    event ForRent (uint id);
    event Deposited (uint id);
    event Rented (uint id);
    event Cancelled (uint id);
    event Refunded (address accountToRefund, uint id);
    event OffMarket (uint id);

    /* MODIFIERS */

    modifier forRent (uint _id) { require(apartments[_id].state == "ForRent"); _; };
    modifier canDeposit (uint _id) { require(balances[msg.sender] >= msg.value); _; };
    modifier depositedEnough (uint _id) { require(apartments[_id].deposit <= msg.value); _; };
    modifier deposited (uint _id) { require(apartments[_id].state == "Deposited"); _; };
    modifier rented (uint _id) { require(apartments[_id].state == "Rented"); _; };
    modifier cancelled (uint _id) { require(apartments[_id].state == "Cancelled"); _; };
    modifier canCancel (uint _id) { require(apartments[_id].seller == msg.sender || apartments[_id].buyer == msg.sender); _; };
    modifier refunded (uint _id) { require(apartments[_id].state == "Refunded"); _; };
    modifier offMarket (uint _id) { require(apartments[_id].state == "OffMarket"); _; };

    /* ENUMERATORS */

    enum State { OffMarket, OnMarket, ForRent, Deposited, Rented, Cancelled, Refunded }

    /* STRUCTS */

    struct Apartment {
        string location;
        uint id;
        uint state;
        uint deposit;
        uint price;
        address seller;
        address renter;
    }

    /* CONSTRUCTOR */

    // define contract owner
    constructor() public {
        owner = msg.sender;
        idCount = 0;
    }

    /* VIEWS */

    function getSellers() public view returns (address[]) {
        return sellers;
    }

    function getSeller(uint _id) public view returns (address) {
        return apartments[_id].seller;
    }

    function getDeposit(uint _id) public view returns (uint) {
        return apartments[_id].deposit;
    }

    function getPrice(uint _id) public view returns (uint) {
        return apartments[_id].price;
    }


    /* FUNCTIONS */

    // enable seller to post rental
    function addApartment(string _location, string _price, string _deposit)
        public
        returns (bool)
    {
        idCount = idCount + 1;
        emit ForRent(idCount);
        apartments[id] = Apartment({
            location: _location,
            id: idCount,
            state: State.OffMarket,
            deposit: _deposit,
            price: _price,
            seller: msg.sender,
            renter: 0
        });
        return true;
    }

    // enable seller to delete rental
    function removeApartment(uint _id)
        public
        returns ()
    {
        // do something
    }

    // security deposit
    function securityDeposit(uint _id)
        public
        returns (uint)
    {
        forRent(_id);
        canDeposit(msg.sender);
        depositedEnough(msg.sender);
        _securityDeposit(uint _id);
    }

    function _securityDeposit(uint _id)
        internal
        payable
        returns (uint)
    {
        emit Deposited(uint _id);
    }


    // enable renter to buy apartment
    function rentApartment(uint _id)
        public
        returns (bool)
    {
        // do something
    }

    // cancel apartment rental
    function cancelRental(uint _id)
        public
        payable
        returns (bool)
    {
        emit Cancelled(_id);
        canCancel(_id);
    }


    // confirm cancellation
    function confirmCancelRental()
        public
    {
        // do something
    }







}
