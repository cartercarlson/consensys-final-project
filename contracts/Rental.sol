pragma solidity ^0.4.20;

contract Rental {

    /* DECLARING VARIABLES */

    address public owner;
    address[] public sellers;
    address[] public renters;
    int public idCount;

    /* MAPPING */

    // map the rental ID to an Apartment
    mapping (uint => Apartment) public apartments;
    mapping (address => bool) public isRenter;

    /* EVENTS */

    event ForRent (uint id);
    event Deposited (uint id);
    event Rented (uint id);
    event Cancelled (uint id);
    event Refunded (address accountToRefund, uint id);
    event OffMarket (uint id);

    /* MODIFIERS */

    modifier forRent (uint _id) { require(apartments[_id].state == "ForRent"); _; };
    modifier deposited (uint _id) { require(apartments[_id].state == "Deposited"); _; };
    modifier rented (uint _id) { require(apartments[_id].state == "Rented"); _; };
    modifier cancelled (uint _id) { require(apartments[_id].state == "Cancelled"); _; };
    modifier refunded (uint _id) { require(apartments[_id].state == "Refunded"); _; };
    modifier offMarket (uint _id) { require(apartments[_id].state == "OffMarket"); _; };

    /* STRUCTS */

    struct Apartment {
        uint id;
        string location;
        uint price;
        uint deposit;
        uint state;
        address seller;
        address renter;
    }

    /* CONSTRUCTOR */

    // define contract owner
    constructor() public {
        owner = msg.sender;
        idCount = 0;
    }

    /* ENUMERATORS */

    enum State { ForRent, Deposited, Rented, Cancelled, Refunded, OffMarket }

    /* VIEWS */

    function getSeller(uint _id) public view returns (address) {
        return apartments[_id].seller;
    }

    function getSellers() public view returns (address[]) {
        return sellers;
    }

    function getRenter(uint _id) public view returns (address) {
        return apartments[_id].seller;
    }

    function getRenters() public view returns (address[]) {
        return renters;
    }

    function getDeposit(uint _id) public view returns (uint){
        return apartments[_id].deposit;
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
            price: _price,
            state: State.ForRent,
            seller: msg.sender,
            renter: 0
        });
        return true;
    }

    // enable seller to delete rental
    function removeApartment()
        public
        returns ()
    {
        // do something
    }

    // security deposit
    function securityDeposit()
        public
        payable
        returns (uint)
    {
        // do something
    }

    // confirm security deposit
    function confirmSecurityDeposit()
        public
    {
        // do something
    }

    // enable renter to buy apartment
    function rentApartment()
        public
        returns ()
    {
        // do something
    }

    // cancel apartment rental
    function cancelRental()
        public
        returns ()
    {
        // do something
    }

    // confirm cancellation
    function confirmCancelRental()
        public
    {
        // do something
    }

    // This function is for running tests
    function getApartment(uint _id)
        public
        view
        returns (uint id, string location, uint price, uint deposit, uint state,
                 address seller, address renter)
    {
        id = apartments[_id].id;
        location = apartments[_id].location;
        price = apartments[_id].price;
        deposit = apartments[_id].deposit;
        state = apartments[_id].state;
        seller = apartments[_id].seller;
        buyer = apartments[_id].buyer;
        return (id, location, price, deposit, state, seller, renter)
    }





}
