// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MemeCoin} from "../src/MemeCoin.sol";

contract MemeCoinTest is Test {
    MemeCoin internal coin;

    address internal deployer = address(this);
    address internal alice = makeAddr("alice");
    address internal bob = makeAddr("bob");

    function setUp() public {
        coin = new MemeCoin("ChestNutCoin", "CNUT");
    }

    function test_TotalSupplyIsOneMillion() public view {
        assertEq(coin.totalSupply(), 1_000_000 * 10**18);
        assertEq(coin.totalSupply(), coin.INITIAL_SUPPLY());
    }

    function test_DeployerHoldsFullSupply() public view {
        assertEq(coin.balanceOf(deployer), coin.INITIAL_SUPPLY());
        assertEq(coin.balanceOf(alice), 0);
    }

    function test_TransferMovesBalance() public {
        uint256 amount = 1_000 * 10**18;

        assertTrue(coin.transfer(alice, amount));

        assertEq(coin.balanceOf(alice), amount);
        assertEq(coin.balanceOf(deployer), coin.INITIAL_SUPPLY() - amount);
    }

    function test_TransferFromUsesAllowance() public {
        uint256 amount = 500 * 10**18;

        assertTrue(coin.approve(alice, amount));

        vm.prank(alice);
        assertTrue(coin.transferFrom(deployer, bob, amount));

        assertEq(coin.balanceOf(bob), amount);
        assertEq(coin.allowance(deployer, alice), 0);
    }

    function test_NameAndSymbol() public view {
        assertEq(coin.name(), "ChestNutCoin");
        assertEq(coin.symbol(), "CNUT");
        assertEq(coin.decimals(), 18);
    }
}
