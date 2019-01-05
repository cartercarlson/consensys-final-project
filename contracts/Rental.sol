pragma solidity ^0.4.20;

contract Rental {

    // define owner

    // define sellers
    address[50] public sellers;
    function getSellers()
        public
        view
        returns(address[50])
    {
        return sellers;
    }

    // define buyers?
    address[50] public renters;
    function getRenters()
        public
        view
        returns(address[50])
    {
        return renters;
    }

    // enable seller to post rental

    // allow buyer to choose rental


}
