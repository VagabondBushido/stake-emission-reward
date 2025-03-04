// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/OrcaCoin.sol";

contract OrcaCoinTest is Test {
    OrcaCoin orcaCoin;

    function setUp() public {
        orcaCoin = new OrcaCoin(address(this)); 
    }
    function testInitialSupply() public {
        assertEq(orcaCoin.totalSupply(), 0);
    }

    function testMint() public {
        orcaCoin.mint(address(this), 100);
        assertEq(orcaCoin.totalSupply(), 100);
    }
    

}
