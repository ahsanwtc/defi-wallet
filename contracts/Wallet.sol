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

  function withdraw(address _cTokenAddress, uint _underlyingAmount, address _recipient) onlyAdmin external {
    require(getUnderlyingBalance(_cTokenAddress) >= _underlyingAmount, 'balance too low');
    claimComp();
    redeem(_cTokenAddress, _underlyingAmount);
    address underlyingTokenAddress = getUnderlyingAddress(_cTokenAddress);
    IERC20(underlyingTokenAddress).transfer(_recipient, _underlyingAmount);

    address compTokenAddress = getCompAddress();
    IERC20 compToken = IERC20(compTokenAddress);
    uint compTokenBalance = compToken.balanceOf(address(this));
    compToken.transfer(_recipient, compTokenBalance);
  }

  receive() payable external {
    supplyEth(msg.value);
  }

  modifier onlyAdmin() {
    require(msg.sender == admin, 'only admin');
    _;
  }
}
