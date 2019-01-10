pragma solidity ^0.4.20;

import "Userbase.sol";

contract Rental {

    /* DECLARING VARIABLES */

    address public owner;
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
    modifier canCancel (uint _id) { require(apartments[_id].seller == msg.sender || apartments[_id].renter == msg.sender); _; };
    modifier offMarket (uint _id) { require(apartments[_id].state == "OffMarket"); _; };
	modifier apartmentExists(uint _id) { require _id > 0 && _id <= idCount }

    /* ENUMERATORS */

    enum State { OffMarket, OnMarket, ForRent, Deposited, Rented, Ended }

    /* STRUCTS */

    struct Apartment {
        uint id;
		string location;
        uint state;
        uint term;
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

	function getApartment(uint _id)
		public
		view
		returns (
			uint _id,
			string location,
			uint state, // NOTE: is this correct?
			uint term,
			uint deposit,
			uint price,
			address seller,
			address renter
		)
	{
		apartmentExists(_id);
		Apartment storage apartment = apartments[_id];
		location = apartment.location;
		state = apartment.state;
		deposit = apartment.deposit;
		price = apartment.price;
		seller = apartment.seller;
		renter = apartment.renter;
	}

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
    function addApartment(string _location, string _term, string _deposit, string _price)
        public
        returns (bool)
    {
        authorizedUser(msg.sender);
        idCount = idCount + 1;
        emit ForRent(idCount);
        apartments[id] = Apartment({
            id: idCount,
			location: _location,
            state: State.OffMarket,
            term: _term,
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
