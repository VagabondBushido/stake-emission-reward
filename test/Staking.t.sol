// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/Staking.sol";
import "src/OrcaCoin.sol";

contract StakingTest is Test {
    Staking s;
    OrcaCoin o;

    function setUp() public {
        o = new OrcaCoin(address(this)); // Deploy OrcaCoin contract
        s = new Staking(address(o)); // Deploy Staking contract with OrcaCoin address
        o.updateStakingContract(address(s)); // Update staking contract address in OrcaCoin
    }

    // Fallback function to accept ether
    receive() external payable {}

    function testBalance() public {
        assertEq(s.Balances(address(this)), 0); // Correct case for accessing the mapping
    }
    
    function testStakeBalance() public {
        s.stake{value: 100 ether}();
        s.unstake(50 ether);
        assertEq(s.Balances(address(this)), 50 ether); // Correct case for accessing the mapping
    }

    function testClaimRewards() public {
        s.stake{value: 100 ether}();
        s.claimRewards();
        assertEq(o.balanceOf(address(this)), 0); // Correct function name is balanceOf
    }
}