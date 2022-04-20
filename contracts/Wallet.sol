// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './Compound.sol';

contract Wallet is Compound {
  address public admin;

  constructor(address _comptroller, address _cEthAddress) Compound(_comptroller, _cEthAddress) public {
    admin = msg.sender;
  }
}
