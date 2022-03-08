//SPDX-License-Identifier: GPL-2.0-or-later
//especificar a versão do solidity
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//the keywork 'is' is used to reffer a herance
contract MyToken is ERC20{

    constructor( uint initialSupply ) ERC20( "MyToken", "MYT" ){
        //Register my token in blockchain
        _mint(msg.sender, initialSupply);
    }

}