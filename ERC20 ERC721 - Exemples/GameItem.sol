//SPDX-License-Identifier: GPL-2.0-or-later
//especificar a versão do solidity
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

//the keywork 'is' is used to reffer a herance
contract GameItem is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721( "GameItem", "GMT" ){}

    //emit the tokenized item
    function awardItem( address _player, string memory tokenURI) public returns( uint ){
        _tokenIds.increment();

        uint newItemId = _tokenIds.current();

        //mint item in association with player
        _mint( _player, newItemId );
        _setTokenURI( newItemId, tokenURI );

        return newItemId;
    }
}