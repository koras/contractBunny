pragma solidity ^0.4.23;

import "./Ownable.sol";



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
 

contract BaseRabbit  is Ownable {
       
    using SafeMath for uint256;
    bool pauseSave = false;
    uint256 bigPrice = 0.0001 ether;
    
    uint public commission_system = 5;
     
    // ID the last seal
    uint32 public lastIdGen0;
    uint public totalGen0 = 0;
    // ID the last seal
    uint public lastTimeGen0;
    
    // ID the last seal
  //  uint public timeRangeCreateGen0 = 1800;
    uint public timeRangeCreateGen0 = 1;

    uint public promoGen0 = 2500;
    uint public promoMoney = 1*bigPrice;
    bool public promoPause = false;


    function setPromoGen0(uint _promoGen0) public onlyOwner {
        promoGen0 = _promoGen0;
    }

    function setPromoPause() public onlyOwner {
        promoPause = !promoPause;
    }



    function setPromoMoney(uint _promoMoney) public onlyOwner {
        promoMoney = _promoMoney;
    }
    modifier timeRange() {
        require((lastTimeGen0+timeRangeCreateGen0) < now);
        _;
    } 

    mapping(uint32 => uint) public totalSalaryBunny;
    mapping(uint32 => uint32[10]) public rabbitMother;
    
    mapping(uint32 => uint) public rabbitMotherCount;
    
    // how many times did the rabbit cross
    mapping(uint32 => uint) public rabbitBreedCount;

    mapping(uint32 => uint)  public rabbitSirePrice;
    mapping(uint => uint32[]) public sireGenom;
    mapping (uint32 => uint) mapDNK;
   
    uint32[15] public cooldowns = [
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
        uint32(1 days),
        uint32(2 days),
        uint32(4 days),
        uint32(7 days)
    ];


    struct Rabbit { 
         // родители
        uint32 mother;
        uint32 sire; 
        // блок в котором родился кролик
        uint birthblock;
         // количество родов или сколько раз было потомство
        uint birthCount;
         // Время когда последний раз рожал Кролик
        uint birthLastTime;
        // текущая роль кролика
        uint role;
        //indexGenome   
        uint genome;
    }
    /**
    * Там где будем хранить информацию о кроликах
    */
    Rabbit[]  public rabbits;
     
    /**
    * кому принадлежит кролик
    */
    mapping (uint32 => address) public rabbitToOwner; 
    mapping(address => uint32[]) public ownerBunnies;
    //mapping (address => uint) ownerRabbitCount;
    mapping (uint32 => string) rabbitDescription;
    mapping (uint32 => string) rabbitName; 

    //giff 
    mapping (uint32 => bool) giffblock; 
    mapping (address => bool) ownerGennezise;

}
