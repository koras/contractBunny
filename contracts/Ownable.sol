pragma solidity ^0.4.23;



/*
  ▀█████████▄  ███    █▄  ███▄▄▄▄   ███▄▄▄▄   ▄██   ▄
    ███    ███ ███    ███ ███▀▀▀██▄ ███▀▀▀██▄ ███   ██▄
    ███    ███ ███    ███ ███   ███ ███   ███ ███▄▄▄███
   ▄███▄▄▄██▀  ███    ███ ███   ███ ███   ███ ▀▀▀▀▀▀███
  ▀▀███▀▀▀██▄  ███    ███ ███   ███ ███   ███ ▄██   ███
    ███    ██▄ ███    ███ ███   ███ ███   ███ ███   ███
    ███    ███ ███    ███ ███   ███ ███   ███ ███   ███
   ▄█████████▀  ████████▀   ▀█   █▀   ▀█   █▀   ▀█████▀ 

    ▄██████▄     ▄████████   ▄▄▄▄███▄▄▄▄      ▄████████
    ███    ███   ███    ███ ▄██▀▀▀███▀▀▀██▄   ███    ███
    ███    █▀    ███    ███ ███   ███   ███   ███    █▀
   ▄███          ███    ███ ███   ███   ███  ▄███▄▄▄ 
  ▀▀███ ████▄  ▀███████████ ███   ███   ███ ▀▀███▀▀▀  
    ███    ███   ███    ███ ███   ███   ███   ███    █▄ 
    ███    ███   ███    ███ ███   ███   ███   ███    ███ 
    ████████▀    ███    █▀   ▀█   ███   █▀    ██████████


* Author:  Konstantin G...
* Telegram: @bunnygame (en)
* email: info@bunnycoin.co
* site : http://bunnycoin.co 
*/

/**
* @title Ownable
* @dev The Ownable contract has an owner address, and provides basic authorization control
* functions, this simplifies the implementation of "user permissions".
*/
contract Ownable {
    
    address ownerCEO;
    address ownerMoney;  
     
    address privAddress; 
    address addressAdmixture;
    
    /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender
    * account.
    */
    constructor() public { 
        ownerCEO = msg.sender; 
        ownerMoney = msg.sender;
    }
 
  /**
   * @dev Throws if called by any account other than the owner.
   */
    modifier onlyOwner() {
        require(msg.sender == ownerCEO);
        _;
    }
   
    function transferOwnership(address add) public onlyOwner {
        if (add != address(0)) {
            ownerCEO = add;
        }
    }
 
    function transferOwnerMoney(address _ownerMoney) public  onlyOwner {
        if (_ownerMoney != address(0)) {
            ownerMoney = _ownerMoney;
        }
    }
 
    function getOwnerMoney() public view onlyOwner returns(address) {
        return ownerMoney;
    } 
    /**
    *  @dev private contract
     */
    function getPrivAddress() public view onlyOwner returns(address) {
        return privAddress;
    }
    function getAddressAdmixture() public view onlyOwner returns(address) {
        return addressAdmixture;
    }
} 
