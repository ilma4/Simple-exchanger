// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {
    constructor(uint256 initialAmount) ERC20 ("Test token", unicode"TTK") {
        _mint(msg.sender, initialAmount);
    }
}
