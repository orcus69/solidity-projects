//SPDX-License-Identifier: GPL-2.0-or-later
//especificar a versão do solidity
pragma solidity = 0.8.1;

//Start smartcontract
contract Trust{
    //variaveis
    //Mapping is like a map function in js
    // mapping( address => uint ) public amounts;
    // mapping( address => uint ) public maturities;
    // mapping( address => bool ) public paid;
    address public admin;

    //to improve our contract to be more efficiente and consume less gas tax
    //we gonna use a struct tipe, its like an object in poo lang
    struct Kid{
        uint amount;
        uint maturity;
        bool paid;
    }
    //so after that, we gonna do a mapping with this struct
    mapping( address => Kid ) public kids;

    constructor(){
        admin = msg.sender;
    }

    //
    function addKid( address kid, uint timeToMaturity ) external payable{
        require(msg.sender == admin, 'only admin');
        require(kids[msg.sender].amount == 0, 'kid already exist');
        kids[kid] = Kid(msg.value, block.timestamp + timeToMaturity, false);
        // amounts[kid] = msg.value;
        // maturities[kid] = block.timestamp + timeToMaturity;
    }

    //function
    function withdraw() external {
        Kid storage kid = kids[msg.sender];
        //with msg.sender you have garantier that the sender address cant be modified before
        require(kid.maturity <= block.timestamp, 'to early');
        //default value of uint = 0
        //it means that if that kid addres dont exists there are no kid
        require(kid.amount > 0, 'only kid can withdraw');
        require(kid.paid == false, 'paid already');
        kid.paid = true;
        
        //make the transfer
        //the keyword payable means that you'll need to pay some ETH for make the transation
        payable(msg.sender).transfer(kid.amount);
    }
}