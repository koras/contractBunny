pragma solidity ^0.4.23;
/**
 * Thanks! telegram: wexnzrus
 * 
 * 
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public ownerCEO;
    address ownerMoney; 
    address ownerTech;
    address ownerServer;
    address privAddress;
    /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender
    * account.
    */

    constructor() public {
       // address my = 0x1e4147cC0a8d70fa299868C4725201244F4aA818;
        address my =  msg.sender;
        ownerCEO = my;
        ownerTech = my;
        ownerServer = my;
        ownerMoney = my;
    }
 
  /**
   * @dev Throws if called by any account other than the owner.
   */
    modifier onlyOwner() {
        require(msg.sender == ownerCEO);
        _;
    }
  
    modifier onlyTech() {
        require(msg.sender == ownerTech || msg.sender == ownerCEO);
        _;
    }

  
    modifier onlyServer() {
        require(msg.sender == ownerServer || msg.sender == ownerCEO);
        _;
    }

    function transferOwnership(address add) public onlyOwner {
        if (add != address(0)) {
            ownerCEO = add;
        }
    }
 
    function transferOwnershipTechnical(address add) public onlyOwner {
        if (add != address(0)) {
            ownerTech = add;
        }
    } 

    function transferOwnershipServer(address add) public onlyOwner {
        if (add != address(0)) {
            ownerServer = add;
        }
    } 
     
    function transferOwnerMoney(address _ownerMoney) public  onlyOwner {
 
        ownerMoney = address(_ownerMoney);
    }





    
    function getOwnerMoney() public view onlyOwner returns(address) {
        return ownerMoney;
    }
    function getOwnerTech() public view onlyOwner returns(address) {
        return ownerTech;
    }
    function getOwnerServer() public view onlyOwner returns(address) {
        return ownerServer;
    }
    function getPrivAddress() public view onlyOwner returns(address) {
        return privAddress;
    }
}
