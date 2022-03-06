//SPDX-License-Identifier: GPL-2.0-or-later
//especificar a versão do solidity
pragma solidity = 0.8.1;

contract Voting{
 //public variables are visible for anyone out of the contract
    
    struct Pauta {
        string pauta;
        bool voted;
    }

    address admin;

    mapping (address => Pauta) pauta;

    enum Option{ Yes, No, Null, Abstention }
    //store an array of adress fo each one option
    mapping( Option => address[] ) vote;

    //create the contrate with one pauta to be voting
    constructor( string memory _pauta ){
        admin = msg.sender;
        pauta[msg.sender].pauta = _pauta;
    }

    //Vote Function
    function votate ( Option _option ) public {
        //verify if user is in user object,
        //if its true show the message user alredy voted
        require( !pauta[msg.sender].voted, "User alredy voted!" );

        //insert into vote object the address of who vote
        vote[_option].push(msg.sender);

        //add user addres into object user as true,
        //means that he fish his votation
        pauta[msg.sender].voted = true;
    }

    //View Result of Votation
    function viewResult ( Option _option ) public view returns( address[] memory ){
        return( vote[_option] );
    }

    //return admin
    function getAdmin() public view returns(address){
        return(admin);
    }
    
    //return agenda
    function getAgenda() public view returns(string memory){
        return(pauta[admin].pauta);
    }

}
