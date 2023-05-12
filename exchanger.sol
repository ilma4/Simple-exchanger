// SPDX-License-Identifier: MIT

pragma solidity >=0.8 <0.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Exchanger is Ownable {
    using SafeERC20 for IERC20;

    IERC20 public token;
    uint256 private exchangeRate;
    bool private isAlive_v = true;


    constructor(uint256 _exchangeRate, address _token) {
        require(_exchangeRate >= 1);
        exchangeRate = _exchangeRate;
        token = IERC20(_token);
    }

    modifier isAlive() {
        require(isAlive_v, "Dead exchanger can't perform operations");
        _;
    }


    function purchase(uint256 amount) public payable isAlive {
        uint256 requiredWei = amount * exchangeRate;
        require(msg.value == requiredWei * 1 wei, "Not enought wei in customer transaction");

        token.safeTransfer(msg.sender, amount);
    }

    function sell(uint256 amount) isAlive public payable {
        uint256 requiredWei = amount * exchangeRate;   
        require(requiredWei <= address(this).balance, "Not enought wei in exchanger");  

        token.safeTransferFrom(msg.sender, address(this), amount);
        payable(msg.sender).transfer(amount * exchangeRate * 1 wei);
    }

    function sendWeiToOwner(uint256 amount)  onlyOwner isAlive public payable {
        require(address(this).balance >= amount * 1 wei, "Not enought wei in exchanger");
        payable(owner()).transfer(amount);
    }

    function fillWei() onlyOwner isAlive public payable {}

    function setExchangeRate(uint256 rate) onlyOwner isAlive public {
        require(rate >= 1);
        exchangeRate = rate;
    }

    function destroyExchanger() public onlyOwner isAlive {
        payable(owner()).transfer(address(this).balance);
        isAlive_v = false;
    }
}
