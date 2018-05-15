pragma solidity ^0.4.23;
 
import "./BaseRabbit.sol"; 


/// @title Interface for contracts conforming to ERC-721: Non-Fungible Tokens
/// @author Dieter Shirley <dete@axiomzen.co> (https://github.com/dete)
contract ERC721 {
    // Required methods 
 

    function ownerOf(uint32 _tokenId) public view returns (address owner);
    function approve(address _to, uint32 _tokenId) external;
    function transfer(address _to, uint32 _tokenId) internal;
    function transferFrom(address _from, address _to, uint32 _tokenId) internal;
    function totalSupply() public view returns (uint32 total);
    function balanceOf(address _owner) public view returns (uint balance);

    // Events
    event Transfer(address from, address to, uint32 tokenId);
    event Approval(address owner, address approved, uint32 tokenId);
}

/// @title Interface new rabbits address
contract PrivateRabbitInterface {
    function getNewRabbit()  public view returns (uint);
    function mixDNK(uint dnkmother, uint dnksire)  public view returns (uint);
    function isUIntPrivate() public pure returns (bool);
    
  //  function mixGenesRabbits(uint256 genes1, uint256 genes2, uint256 targetBlock) public returns (uint256);
}




contract BodyRabbit is BaseRabbit, ERC721 {
     
    uint32 public totalBunny = 0;
    string public constant name = "CryptoRabbits";
    string public constant symbol = "CRB";


    PrivateRabbitInterface privateContract;

    /**
    * @dev setting up a new address for a private contract
    */
    function setPriv(address _privAddress) public returns(bool) {
        privAddress = _privAddress;
        privateContract = PrivateRabbitInterface(_privAddress);
    } 
    bool public fcontr = false;

    address public  myAddr_test = 0x2F2DD44C22747932A8741aFD53A852519c083FC7;
    constructor() public {

      // address myAddr = 0x82c2601dF5171c09979A26779018e029B0df5f45;
      //  setPriv(myAddr); 
        setPriv(myAddr_test);
        fcontr = true;
    }

    function isPriv() public view returns(bool) {
        return privateContract.isUIntPrivate();
    }

    modifier checkPrivate() {
        require(isPriv());
        _;
    }

       
 
    function ownerOf(uint32 _tokenId) public view returns (address owner) {
        return rabbitToOwner[_tokenId];
    }




    function approve(address _to, uint32 _tokenId) external { 
        _to;
        _tokenId;
    }


     
    function removeTokenList(address _owner, uint32 _tokenId) internal { 
        uint count = ownerBunnies[_owner].length;
        for (uint256 i = 0; i < count; i++) {
            if(ownerBunnies[_owner][i] == _tokenId)
            { 
                delete ownerBunnies[_owner][i];
                if(count > 0 && count != (i-1)){
                    ownerBunnies[_owner][i] = ownerBunnies[_owner][(count-1)];
                    delete ownerBunnies[_owner][(count-1)];
                } 
                ownerBunnies[_owner].length--;
                return;
            } 
        }
    }

 
    function addTokenList(address owner,  uint32 _tokenId) internal {
        ownerBunnies[owner].push( _tokenId);
        rabbitToOwner[_tokenId] = owner; 
    }
 

    function transfer(address _to, uint32 _tokenId) internal {

        address currentOwner = msg.sender;
        address oldOwner = rabbitToOwner[_tokenId];
        require(rabbitToOwner[_tokenId] == msg.sender);
       // require(currentOwner == ownerOf(_tokenId));
        require(currentOwner != _to);
        require(_to != address(0));
        
        removeTokenList(oldOwner, _tokenId);
        addTokenList(_to, _tokenId);
        
     //   rabbitToOwner[_tokenId] = _to; 
        emit Transfer(oldOwner, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint32 _tokenId) internal {

      //  address currentOwner = msg.sender;
        address oldOwner = rabbitToOwner[_tokenId];
        require(oldOwner == _from);
        require(oldOwner != _to);
        require(_to != address(0));
        removeTokenList(oldOwner, _tokenId);
        addTokenList(_to, _tokenId);
       // rabbitToOwner[_tokenId] = _to; 
        emit Transfer (oldOwner, _to, _tokenId);
    }  
    
    function setTimeRangeGen0(uint _sec) public onlyTech {
        timeRangeCreateGen0 = _sec;
    }


    function isPauseSave() public view returns(bool) {
        return !pauseSave;
    }

    function setPauseSave() public onlyOwner  returns(bool) {
        return pauseSave = !pauseSave;
    }
    /**
    * for check
    *
    */
    function isUIntPublic() public pure returns(bool) {
        return true;
    }


    function getTokenList(address owner) public view returns(uint32[]) {
        return ownerBunnies[owner];
    }

    
    function setRabbitMother(uint32 children, uint32 mother) internal { 
        
        if (rabbitMother[mother].length > 0) {
            rabbitMother[children] = rabbitMother[mother];
        }
        rabbitMother[children].push(mother);
    }
     
    function getRabbitDNK(uint32 bunnyid) public view returns(uint) { 
        return mapDNK[bunnyid];
    }
     
    function bytes32ToString(bytes32 x)internal pure returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
    
    function uintToBytes(uint v) internal pure returns (bytes32 ret) {
        if (v == 0) {
            ret = '0';
        } else {
        while (v > 0) {
                ret = bytes32(uint(ret) / (2 ** 8));
                ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
                v /= 10;
            }
        }
        return ret;
    }

    function totalSupply() public view returns (uint32 total) {
        return totalBunny;
    }

    function balanceOf(address _owner) public view returns (uint) {
      //  _owner;
        return ownerBunnies[_owner].length;
    }
 

    function sendMoney(address _to, uint256 _money) internal { 
        _to.transfer((_money/100)*95);
        ownerMoney.transfer((_money/100)*5); 
    }
}