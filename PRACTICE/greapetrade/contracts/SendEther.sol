// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SendEther {
    
    //Deposit ether into the contract
    function deposit() internal {}

    function transfer(address payable _to) public payable{
        //call the deposit funtion to stake token and send to other address
         (bool success,) =  address(_to).call{value: address(this).balance}("deposit()");
        require(success);
    }

}
