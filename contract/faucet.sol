// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./IERC20.sol";

contract faucet{

    uint256 public amountAllowed = 100;
    address public tokenContractAddress;
    mapping(address => bool) requestAddress;


    event SendToken(address indexed Receiver,uint256 indexed Amount);


    constructor(address _tokenContractAddress){
        tokenContractAddress = _tokenContractAddress;
    }

    function requestTokens() external  {
        require(requestAddress[msg.sender] == false,"only be claimed once");
        IERC20 token = IERC20(tokenContractAddress);
        require(token.balanceOf(address(this)) >= amountAllowed,"faucet empty !!!");

        token.transfer(msg.sender,amountAllowed);
        requestAddress[msg.sender] == true;

        emit SendToken(msg.sender,amountAllowed);

    }


}