// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract OrcaCoin is ERC20, Ownable { 
    address stakingContract;
    constructor(address _stakingContract) ERC20("Orca", "ORC") Ownable(msg.sender) {
        stakingContract = _stakingContract;

    }
    function mint(address to, uint256 amount) public   {
        require(msg.sender == stakingContract, "Only staking contract can mint");
        _mint(to, amount);
    }
    function updateStakingContract(address _stakingContract) public onlyOwner  {
        stakingContract = _stakingContract;
    }

}
