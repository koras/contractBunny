pragma solidity ^0.4.23;

/*
______ _   _ _   _  _   ___   __
| ___ \ | | | \ | || \ | \ \ / /
| |_/ / | | |  \| ||  \| |\ V / 
| ___ \ | | | . ` || . ` | \ /  
| |_/ / |_| | |\  || |\  | | |  
\____/ \___/\_| \_/\_| \_/ \_/   
 _____   ___  ___  ___ _____    
|  __ \ / _ \ |  \/  ||  ___|   
| |  \// /_\ \| .  . || |__     
| | __ |  _  || |\/| ||  __|    
| |_\ \| | | || |  | || |___    
 \____/\_| |_/\_|  |_/\____/ 
*
* Author:  Konstantin G...
* Telegram: @bunnygame (en)
* talk : https://bitcointalk.org/index.php?topic=5025885.0
* discord : https://discordapp.com/invite/G2jt4Fw
* email: info@bunnycoin.co
* site : http://bunnycoin.co 
*/
 
contract Ownable {
    
    address ownerCEO;
    address ownerMoney;  
    address privAddress = 0x23a9C3452F3f8FF71c7729624f4beCEd4A24fa55; 
    address public addressTokenBunny = 0x2Ed020b084F7a58Ce7AC5d86496dC4ef48413a24;
    
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

} 
