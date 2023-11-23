// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Donation {

    uint256 totalDonationsAmount;
    address _contract;
    address owner;
    address[] charityAddresses;
    
    mapping(address => uint256) private _donations;

    error ZeroAmountError(address caller);
    error NotAnOwnerError(address caller);

    event Transfer(address indexed from, address indexed to, uint256 value);
   
    constructor() {
        owner = msg.sender;
        totalDonationsAmount = 0;
    }

    function donate() external payable {
        uint256 funds = msg.value;
        if(funds <= 0) { 
            revert ZeroAmountError(msg.sender);
        }

        charityAddresses.push(msg.sender);
        _donations[msg.sender] += funds;
        totalDonationsAmount += funds;
        emit Transfer(msg.sender,address(0),funds);        
    }

    function sendHelp(address payable to, uint256 amount) external payable  {
        if (msg.sender != owner) {
            revert NotAnOwnerError(msg.sender);
        }
        if (amount <= 0 ){
            revert ZeroAmountError(msg.sender);
        }
        if (amount > totalDonationsAmount ){
            revert ZeroAmountError(msg.sender);
        }
        bool sent = to.send(amount);//2300 gas
        if(sent){
            emit Transfer(msg.sender, to, amount);
            totalDonationsAmount -= amount;
        }else {
            revert();
        }
        
    }
    
    function getDonators() external view returns(address[] memory){
        return charityAddresses;
    }
    function getSumOfDonations() external view returns(uint256){
        return totalDonationsAmount;
    }

    receive() external payable {
        emit Transfer(msg.sender, address(0), msg.value);
    }

}
