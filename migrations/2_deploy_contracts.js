var Medical = artifacts.require("./Records.sol");

module.exports = function(deployer) {
  deployer.deploy(Medical);
};      