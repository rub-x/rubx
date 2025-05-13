require('hardhat-deploy');
require("@nomiclabs/hardhat-waffle");
require('@openzeppelin/hardhat-upgrades');
const dotenv = require('dotenv/config');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
};
