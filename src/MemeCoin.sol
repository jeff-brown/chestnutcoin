// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title MemeCoin
 * @notice A simple ERC-20 token with a fixed supply minted to the deployer.
 * @dev Built on OpenZeppelin's audited ERC-20 implementation.
 *      No mint, burn, pause, or owner powers after deployment —
 *      supply is fixed forever once the constructor runs.
 */
contract MemeCoin is ERC20 {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 * 10**18;

    constructor(string memory name_, string memory symbol_)
        ERC20(name_, symbol_)
    {
        _mint(msg.sender, INITIAL_SUPPLY);
    }
}
