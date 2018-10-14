pragma solidity ^0.4.23;

import "./Ownable.sol";


/**
 * @title Whitelist
 * @dev The Whitelist contract has a whitelist of addresses, and provides basic authorization control functions.
 * @dev This simplifies the implementation of "user permissions".
 */
contract Whitelist is Ownable {
    mapping(address => bool) public whitelist;

    mapping(uint  => address)   whitelistCheck;
    uint public countAddress = 0;

    event WhitelistedAddressAdded(address addr);
    event WhitelistedAddressRemoved(address addr);
 
  /**
   * @dev Throws if called by any account that's not whitelisted.
   */
    modifier onlyWhitelisted() {
        require(whitelist[msg.sender]);
        _;
    }

    constructor() public {
            whitelist[msg.sender] = true;  
    }

  /**
   * @dev add an address to the whitelist
   * @param addr address
   * @return true if the address was added to the whitelist, false if the address was already in the whitelist
   */
    function addAddressToWhitelist(address addr) onlyWhitelisted public returns(bool success) {
        if (!whitelist[addr]) {
            whitelist[addr] = true;

            countAddress = countAddress + 1;
            whitelistCheck[countAddress] = addr;

            emit WhitelistedAddressAdded(addr);
            success = true;
        }
    }

    function getWhitelistCheck(uint key) onlyWhitelisted view public returns(address) {
        return whitelistCheck[key];
    }


    function getInWhitelist(address addr) public view returns(bool) {
        return whitelist[addr];
    }
    function getOwnerCEO() public onlyWhitelisted view returns(address) {
        return ownerCEO;
    }
 
    /**
    * @dev add addresses to the whitelist
    * @param addrs addresses
    * @return true if at least one address was added to the whitelist,
    * false if all addresses were already in the whitelist
    */
    function addAddressesToWhitelist(address[] addrs) onlyOwner public returns(bool success) {
        for (uint256 i = 0; i < addrs.length; i++) {
            if (addAddressToWhitelist(addrs[i])) {
                success = true;
            }
        }
    }

    /**
    * @dev remove an address from the whitelist
    * @param addr address
    * @return true if the address was removed from the whitelist,
    * false if the address wasn't in the whitelist in the first place
    */
    function removeAddressFromWhitelist(address addr) onlyOwner public returns(bool success) {
        if (whitelist[addr]) {
            whitelist[addr] = false;
            emit WhitelistedAddressRemoved(addr);
            success = true;
        }
    }

    /**
    * @dev remove addresses from the whitelist
    * @param addrs addresses
    * @return true if at least one address was removed from the whitelist,
    * false if all addresses weren't in the whitelist in the first place
    */
    function removeAddressesFromWhitelist(address[] addrs) onlyOwner public returns(bool success) {
        for (uint256 i = 0; i < addrs.length; i++) {
            if (removeAddressFromWhitelist(addrs[i])) {
                success = true;
            }
        }
    }
}