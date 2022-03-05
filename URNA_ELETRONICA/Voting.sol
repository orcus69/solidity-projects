//SPDX-License-Identifier: GPL-2.0-or-later

//especificar a versão do solidity
pragma solidity >= 0.8.1;

contract Voting{
    //public variables are visible for anyone out of the contract
    address public admin;
    string public pauta;

    //the options are enum like [ 0, 1, 2, 3, 4 ]
    enum Option{ Yes, No, Null, Abstention }

    //store an array of adress fo each one option
    mapping( Option => address[] ) vote;

    //map with users tha already voted
    mapping( address => bool ) user;

    //create the contrate with one pauta to be voting
    constructor( string memory _pauta ){
        admin = msg.sender;
        pauta = _pauta;
    }

    //Vote Function
    function votate ( Option _option ) public {
        //verify if user is in user object,
        //if its true show the message user alredy voted
        require( !user[msg.sender], "User alredy voted!" );

        //insert into vote object the address of who vote
        vote[_option].push(msg.sender);

        //add user addres into object user as true,
        //means that he fish his votation
        user[msg.sender] = true;
    }

    //View Result of Votation
    function viewResult ( Option _option ) public view returns( address[] memory ){
        return( vote[_option] );
    }

}

