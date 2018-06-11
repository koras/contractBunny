// personal.unlockAccount(eth.accounts[0], "");
// truffle develop console


var BunnyGame = artifacts.require("./BunnyPages.sol");
 
  
module.exports = function(deployer) {
  deployer.deploy(BunnyGame); 
  
};
