// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//stake unstake claimreward getrewards
import "./OrcaCoin.sol";
contract Staking{
    mapping(address => uint256) public Balances;
    mapping(address => uint256) public unclaimedRewards;
    mapping(address => uint256) public lastStakedTime;

     OrcaCoin public orcaCoin;

      constructor(address _orcaCoinAddress) {
        orcaCoin = OrcaCoin(_orcaCoinAddress);
    }

    function stake() public payable{
        require(msg.value > 0, "Amount should be greater than 0");
        if (lastStakedTime[msg.sender] == 0) {
            lastStakedTime[msg.sender] = block.timestamp;
        }else{
            unclaimedRewards[msg.sender] += (block.timestamp - lastStakedTime[msg.sender]) * Balances[msg.sender];
            lastStakedTime[msg.sender] = block.timestamp;
        }
        Balances[msg.sender] += msg.value;
    }
    function unstake(uint _amount) public{
        require(Balances[msg.sender] >= _amount, "Insufficient balance");
        unclaimedRewards[msg.sender] += (block.timestamp - lastStakedTime[msg.sender]) * Balances[msg.sender];
        lastStakedTime[msg.sender] = block.timestamp;
        Balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function getRewards(address _address) public view returns(uint256){
        uint currentReward = unclaimedRewards[_address];
        uint lastUpdateTime = lastStakedTime[_address];
        uint newReward = (block.timestamp - lastUpdateTime) * Balances[_address];
        return currentReward + newReward;
    }

    function claimRewards() public{
        uint currentReward = unclaimedRewards[msg.sender];
        uint lastUpdateTime = lastStakedTime[msg.sender];
        uint newReward = (block.timestamp -lastUpdateTime) * Balances[msg.sender];
        unclaimedRewards[msg.sender] += newReward;
        lastStakedTime[msg.sender] = block.timestamp;
        uint totalRewards = unclaimedRewards[msg.sender];
        unclaimedRewards[msg.sender] = 0;
        lastStakedTime[msg.sender] = block.timestamp;

        orcaCoin.mint(msg.sender, totalRewards);

    }
    
}