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
 

contract BaseRabbit  is Whitelist {
    event EmotherCount(uint32 mother, uint summ);
    event NewBunny(uint32 bunnyId, uint dnk, uint256 blocknumber, uint breed, uint procentAdmixture, uint admixture);
    event ChengeSex(uint32 bunnyId, bool sex, uint256 price);
    event SalaryBunny(uint32 bunnyId, uint cost);
    event CreateChildren(uint32 matron, uint32 sire, uint32 child);
    event BunnyDescription(uint32 bunnyId, string name);
    event CoolduwnMother(uint32 bunnyId, uint num);
    event Referral(address from, uint32 matronID, uint32 childID, uint currentTime);
    event Approval(address owner, address approved, uint32 tokenId);
    event OwnerBunnies(address owner, uint32  tokenId);
    event Transfer(address from, address to, uint32 tokenId);

 

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

 // 
    // внешняя функция сколько заработала мамочка
    mapping(uint32 => uint) public totalSalaryBunny;
    // кто мамочка у ребёнка
    mapping(uint32 => uint32[5]) public rabbitMother;
    // сколько раз стала мамочка текущий кролик
    mapping(uint32 => uint) public motherCount;
    // сколько стоиот скрещивание у кролика
    mapping(uint32 => uint)  public rabbitSirePrice;
    // разрешено ли менять кролику пол
    mapping(uint32 => bool)  public allowedChangeSex;

    // сколько мужиков с текущим геном
   // mapping(uint => uint32[]) public sireGenom;
    mapping (uint32 => uint) mapDNK;
   
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
        // the current role of the rabbit
        uint role;
        //indexGenome   
        uint genome;

        uint procentAdmixture;
        uint admixture;
    }

 
    /**
    * Where we will store information about rabbits
    */
    Rabbit[]  public rabbits;
     
    /**
    * who owns the rabbit
    */
    mapping (uint32 => address) public rabbitToOwner; 
    mapping (address => uint32[]) public ownerBunnies;
    //mapping (address => uint) ownerRabbitCount; 
    //giff 
    mapping (uint32 => bool) giffblock; 
    mapping (address => bool) ownerGennezise;

}
