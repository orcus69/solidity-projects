// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Dvideo{
    uint public videoCount = 0;
    string public name = "Dvideo";

    //1. Model the video
    struct Video{
        uint id;
        string hash;
        string title;
        string description;
        address author;
    }

    //Event
    event VideoUploaded(
        uint id,
        string hash,
        string title,
        string description,
        address author
    );

    //2. Store the video
    //3. List videos
    //mapping videos and store in blockchain
    mapping(uint => Video) public videos;

    //4. Upload the video
    function uploadVideo(string memory _videoHash, string memory, string memory _title, string memory _description) public {
        //Validations
        //TODO: change to modifier
        require(bytes(_videoHash).length > 0);
        require(bytes(_title).length > 0);
        require(msg.sender != address(0));
        
        //Increment ID
        videoCount++;
        //Add video to the contract
        videos[videoCount] = Video(videoCount, _videoHash, _title, _description, msg.sender);

        //Tigger event
        emit VideoUploaded(videoCount, _videoHash, _title, _description, msg.sender);
    }

}