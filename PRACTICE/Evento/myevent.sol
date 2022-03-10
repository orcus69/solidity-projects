// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MyEvent {

    event Deposit(

        address user,
        uint etherAmount,
        uint time
    );

    function deposit() public payable {
        
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }
    
}