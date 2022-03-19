// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SendEther {
    
    //Transfer ETH event
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    function transfer(address payable _to) public payable{
        uint amount = address(this).balance;
        //call the deposit funtion to stake token and send to other address
        (bool success,) =  address(_to).call{value: amount}("");

        emit Transfer(msg.sender, _to, amount);
        require(success);
    }

}
