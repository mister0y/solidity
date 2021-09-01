// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "./ItemManager.sol";

contract Item {
    uint priceInWei;
    uint pricePaid;
    uint index;
    
    ItemManager parentContract;
    
    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }
    
    receive() external payable {
        require(pricePaid == 0, "The item has been paid already");
        require(priceInWei == msg.value, "Only full payments");
        pricePaid += msg.value;
        (bool success, ) = address(parentContract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "The transaction wasn't successful");
    }
    
    fallback() external{}
}