// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MemeCoin} from "../src/MemeCoin.sol";

/**
 * @title Deploy
 * @notice Deploys MemeCoin. Reads TOKEN_NAME, TOKEN_SYMBOL, and PRIVATE_KEY from env.
 *
 * Usage:
 *   forge script script/Deploy.s.sol:Deploy \
 *     --rpc-url base_sepolia \
 *     --broadcast \
 *     --verify
 */
contract Deploy is Script {
    function run() external returns (MemeCoin coin) {
        string memory name = vm.envString("TOKEN_NAME");
        string memory symbol = vm.envString("TOKEN_SYMBOL");
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        coin = new MemeCoin(name, symbol);
        vm.stopBroadcast();

        console.log("MemeCoin deployed at:", address(coin));
        console.log("Name:               ", name);
        console.log("Symbol:             ", symbol);
        console.log("Total supply:       ", coin.totalSupply());
        console.log("Deployer balance:   ", coin.balanceOf(vm.addr(deployerKey)));
    }
}
