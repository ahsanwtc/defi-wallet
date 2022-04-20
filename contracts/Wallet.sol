// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './Compound.sol';

contract Wallet is Compound {
  address public admin;

  constructor(address _comptroller, address _cEthAddress) Compound(_comptroller, _cEthAddress) {
    admin = msg.sender;
  }

  function deposit(address _cTokenAddress, uint _underlyingAmount) external {
    address underlyingTokenAddress = getUnderlyingAddress(_cTokenAddress);
    IERC20(underlyingTokenAddress).transferFrom(msg.sender, address(this), _underlyingAmount);
    supply(_cTokenAddress, _underlyingAmount);
  }

  receive() payable external {
    supplyEth(msg.value);
  }
}
