//SPDX-License-Identifier: GPL-2.0-or-later
//especificar a versão do solidity
pragma solidity ^0.8.0;

contract Crud{
    struct User {
        uint id;
        string name;
        uint age;
    }

    //array of users
    User[] users;
    uint nextId = 1;

    function create(string memory name, uint age) public{
        //Insert user into the users' array
        users.push(User(nextId, name, age));
        nextId++;
    }

    function read(uint id) view public returns(uint, string memory, uint){
        uint i = find(id);
        
        return(users[i].id, users[i].name, users[i].age);
    }

    function update(uint id, string memory name, uint age) public {
        uint i = find(id);

        users[i].name = name;
        users[i].age = age;
            
    }

    function destruct(uint id) public {
        uint i = find(id);

        delete users[i];
    }

    //the internal keyword means that this function only will be visible inside the smart contract
    function find(uint id) view internal returns(uint){
        //check all ids in the users' array
        for(uint i = 0; i < users.length; i++){
            if(users[i].id == id){
               return i;
            }
        }

        //Return an error if the id is not found
        revert('User not found');
    }
}