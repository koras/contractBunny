pragma solidity ^0.4.23;
import "./Whitelist.sol";



/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
  
}
 
/// @title Interface new rabbits address
contract PrivateRabbitInterface {
    function getNewRabbit(address from)  public view returns (uint);
    function mixDNK(uint dnkmother, uint dnksire, uint genome)  public view returns (uint);
    function isUIntPrivate() public pure returns (bool);
}

contract TokenBunnyInterface { 
    
    function isPromoPause() public view returns(bool);
    function setTokenBunny(uint32 mother, uint32  sire, uint birthblock, uint birthCount, uint birthLastTime, uint genome, address _owner, uint DNK) external returns(uint32);
    function publicSetTokenBunnyTest(uint32 mother, uint32  sire, uint birthblock, uint birthCount, uint birthLastTime, uint genome, address _owner, uint DNK) public; 
    function setMotherCount( uint32 _bunny, uint count) external;
    function setRabbitSirePrice( uint32 _bunny, uint count) external;
    function setAllowedChangeSex( uint32 _bunny, bool canBunny) public;
    function setTotalSalaryBunny( uint32 _bunny, uint count) external;
    function setRabbitMother(uint32 children, uint32[5] _m) external; 
    function setDNK( uint32 _bunny, uint dnk) external;
    function setGiffBlock(uint32 _bunny, bool blocked) external;
    function transferFrom(address _from, address _to, uint32 _tokenId) public returns(bool);
    function setOwnerGennezise(address _to, bool canYou) external;
    function setBirthCount(uint32 _bunny, uint birthCount) external;
    function setBirthblock(uint32 _bunny, uint birthblock) external; 
    function setBirthLastTime(uint32 _bunny, uint birthLastTime) external;
    ////// getters
 
    function getOwnerGennezise(address _to) public view returns(bool);
    function getAllowedChangeSex(uint32 _bunny) public view returns(bool);
    function getRabbitSirePrice(uint32 _bunny) public view returns(uint);
    function getTokenOwner(address owner) public view returns(uint total, uint32[] list); 
    function getMotherCount(uint32 _mother) public view returns(uint);
    function getTotalSalaryBunny(uint32 _bunny) public view returns(uint);
    function getRabbitMother( uint32 mother) public view returns(uint32[5]);
    function getRabbitMotherSumm(uint32 mother) public view returns(uint count);
    function getDNK(uint32 bunnyid) public view returns(uint);
    function getSex(uint32 _bunny) public view returns(bool);
    function isUIntPublic() public view returns(bool);
    function balanceOf(address _owner) public view returns (uint);
    function totalSupply() public view returns (uint total); 
    function ownerOf(uint32 _tokenId) public view returns (address owner);
    function getBunnyInfo(uint32 _bunny) external view returns( uint32 mother, uint32 sire, uint birthblock, uint birthCount, uint birthLastTime, bool role, uint genome, bool interbreed, uint leftTime, uint lastTime, uint price, uint motherSumm);
    function getTokenBunny(uint32 _bunny) public view returns(uint32 mother, uint32 sire, uint birthblock, uint birthCount, uint birthLastTime, uint genome);
    function getGiffBlock(uint32 _bunny) public view returns(bool);

    function getGenome(uint32 _bunny) public view returns( uint);
    function getParent(uint32 _bunny) public view returns(uint32 mother, uint32 sire);
    function getBirthLastTime(uint32 _bunny) public view returns(uint);
    function getBirthCount(uint32 _bunny) public view returns(uint);
    function getBirthblock(uint32 _bunny) public view returns(uint);
        
}

contract BaseRabbit  is Whitelist {
    event EmotherCount(uint32 mother, uint summ); 
    event ChengeSex(uint32 bunnyId, bool sex, uint256 price);
    event SalaryBunny(uint32 bunnyId, uint cost); 
    event BunnyDescription(uint32 bunnyId, string name);
    event CoolduwnMother(uint32 bunnyId, uint num);
    event Referral(address from, uint32 matronID, uint32 childID, uint currentTime);
    event Approval(address owner, address approved, uint32 tokenId);
    event OwnerBunnies(address owner, uint32  tokenId);
    event Transfer(address from, address to, uint32 tokenId);

 
    TokenBunnyInterface TokenBunny;
    PrivateRabbitInterface privateContract; 

    /**
    * @dev setting up a new address for a private contract
    */
    function setToken(address _addressTokenBunny ) public returns(bool) {
        addressTokenBunny = _addressTokenBunny;
        TokenBunny = TokenBunnyInterface(_addressTokenBunny);
    } 
    /**
    * @dev setting up a new address for a private contract
    */
    function setPriv(address _privAddress) public returns(bool) {
        privAddress = _privAddress;
        privateContract = PrivateRabbitInterface(_privAddress);
    } 
    function isPriv() public view returns(bool) {
        return privateContract.isUIntPrivate();
    }

    modifier checkPrivate() {
        require(isPriv());
        _;
    }


    using SafeMath for uint256;
    bool pauseSave = false;
    uint256 bigPrice = 0.005 ether;
    uint public commission_system = 5;
     
    // ID the last seal
    
    uint public totalGen0 = 0;
    
    // ID the last seal
  //  uint public timeRangeCreateGen0 = 1800; 

    uint public promoGen0 = 15000; 
    bool public promoPause = false;


    function setPromoGen0(uint _promoGen0) public onlyWhitelisted() {
        promoGen0 = _promoGen0;
    }

    function setPromoPause() public onlyWhitelisted() {
        promoPause = !promoPause;
    }

    function setBigPrice(uint _bigPrice) public onlyWhitelisted() {
        bigPrice = _bigPrice;
    }
     
    uint32[12] public cooldowns = [
        uint32(1 minutes),
        uint32(2 minutes),
        uint32(4 minutes),
        uint32(8 minutes),
        uint32(16 minutes),
        uint32(32 minutes),
        uint32(1 hours),
        uint32(2 hours),
        uint32(4 hours),
        uint32(8 hours),
        uint32(16 hours),
        uint32(1 days)
    ];

    struct Rabbit { 
         // parents
        uint32 mother;
        uint32 sire; 
        // block in which a rabbit was born
        uint birthblock;
         // number of births or how many times were offspring
        uint birthCount;
         // The time when Rabbit last gave birth
        uint birthLastTime;
        //indexGenome   
        uint genome; 
    }
}