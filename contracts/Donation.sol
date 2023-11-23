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

    event Transfer(address indexed from, uint256 value);
   
    constructor() {
        owner = msg.sender;
    }

    function donate() external payable {
        if(msg.value <= 0) { 
            revert ZeroAmountError(msg.sender);
        }
        if(_donations[msg.sender] == 0){
            charityAddresses.push(msg.sender);
        }
        _donations[msg.sender] += msg.value;
        totalDonationsAmount += msg.value;
        emit Transfer(msg.sender, msg.value);        
    }

    function sendHelp(address payable to, uint256 amount) external {
        if (msg.sender != owner) {
            revert NotAnOwnerError(msg.sender);
        }
        if (amount > address(this).balance ){
            revert ZeroAmountError(msg.sender);
        }
        bool sent = to.send(amount);//2300 gas
        if(sent){
            emit Transfer(msg.sender, amount);
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
        emit Transfer(msg.sender, msg.value);
    }

}
