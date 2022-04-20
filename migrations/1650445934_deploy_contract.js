const Wallet = artifacts.require('Wallet');

const comptrollerMainnetAddress = '0x3d9819210a31b4961b30ef54be2aed79b9c9cd3b';
const cEthMainnetAddress = '0x4ddc2d193948926d02f9b1fe9e1daa0718270ed5';

module.exports = function (deployer) {
  deployer.deploy(Wallet, comptrollerMainnetAddress, cEthMainnetAddress);
};
