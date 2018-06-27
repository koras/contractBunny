pragma solidity ^0.4.23;
import "./BodyRabbit.sol"; 

/**
* sale and bye Rabbits
*/
contract RabbitMarket is BodyRabbit {

    event SendBunny(address newOwnerBunny, uint32 bunnyId);
    event StopMarket(uint32 bunnyId);
    event StartMarket(uint32 bunnyId, uint money);
    event BunnyBuy(uint32 bunnyId, uint money);
 

 // Long time
    uint stepMoney = 2*60*60;
           
    function setStepMoney(uint money) public onlyTech {
        stepMoney = money;
    }
    /**
    * @dev number of rabbits participating in the auction
    */
    uint marketCount = 0; 

    uint daysperiod = 1;
    uint sec = 1;
    // какое количество последний продаж учитывать в контракте перед формировании цены
    uint8 middlelast = 20;
    
    /***
    * @param period за какой периуд идёт снижение цены
    */
    function setDayPeriod(uint period) public onlyTech returns(uint256) {
        daysperiod = period;
        sec = daysperiod * 24*60*60;
        return  sec;
    }
     
     
    // те кто на текущий момент учавствует в продаже
    mapping(uint32 => uint256[]) internal marketRabbits;
    // закрытые на текущий момент торги
    
    /**
    */
    struct Clisedbid {
        uint32 rabbitID;
        address rabbitSeller;
        uint64 timeBid; 
    }
    
    Clisedbid[] clisedbidRabbits;
     
    
    // средняя стоимость  котика
    uint256 middlePriceMoney = 1;
    // среднее время продаж
    uint256 middleSaleTime = 0; 
    // на сколько определить стоимость продукта
    uint moneyRange;

    /**
    * @param _money промежёток стоимости
     */
    function setMoneyRange(uint _money) public onlyTech {
        moneyRange = _money;
    }
     
    // the last cost of a sold seal
    uint lastmoney = 0;  
    // the time which was spent on the sale of the cat
    uint lastTimeGen0;

 
    /**
    * @param  money;
    * @param  timeStart; 
    * @param  timeFinish; 
    */
  //  struct BidClosed {
     //   uint money;
     //   uint timeRange;  
  //  }
    /**
    * @param  BidClosed 
    */
   // mapping(uint=>BidClosed) sellerOfRabbit;
 
    //how many closed auctions
    uint public totalClosedBID = 0;
     
    mapping (uint32 => uint) bunnyCost; 
    mapping(uint32 => uint) bidsIndex;
 

    /**
    * @dev get rabbit price
    */
    function currentPrice(uint32 _bunnyid) public view returns(uint) {

        uint money = bunnyCost[_bunnyid];
        if (money > 0) {
            uint moneyComs = money.div(100);
            moneyComs = moneyComs.mul(5);
            return money.add(moneyComs);
        }
    }



  function startMarket(uint32 _bunnyid, uint _money) public returns (uint) {
        require(isPauseSave());
        require(_money >= bigPrice);
        require(rabbitToOwner[_bunnyid] ==  msg.sender);
        bunnyCost[_bunnyid] = _money;
        emit StartMarket(_bunnyid, _money);
        return marketCount++;
    }






    // https://ethereum.stackexchange.com/questions/1527/how-to-delete-an-element-at-a-certain-index-in-an-array
    function stopMarket(uint32 _bunnyid) public returns(uint) {
        require(isPauseSave());
        require(rabbitToOwner[_bunnyid] == msg.sender);  
        bunnyCost[_bunnyid] = 0;
        emit StopMarket(_bunnyid);
        return marketCount--;
    }
 
 

    /**
    * @dev Acquisition of a rabbit from another user
    * @param _bunnyid  Bunny
     */
    function buyBunny(uint32 _bunnyid) public payable {
        require(isPauseSave());
        require(rabbitToOwner[_bunnyid] != msg.sender);
        uint price = currentPrice(_bunnyid);

        require(msg.value >= price && 0 != price);

        // stop trading on the current rabbit
        totalClosedBID++;
        // Sending money to the old user
        sendMoney(rabbitToOwner[_bunnyid], msg.value);
        // is sent to the new owner of the bought rabbit
        transferFrom(rabbitToOwner[_bunnyid], msg.sender, _bunnyid); 
        stopMarket(_bunnyid); 

        emit BunnyBuy(_bunnyid, price);
        emit SendBunny (msg.sender, _bunnyid);
    }
 
 

    /**
    * @dev removal from the market rabbit
    */
    function deleteRabbitMarket(uint rabbitid) public pure { 
        rabbitid; 
    } 

    /**
    * @param rabbitid rabbit in relation to whom reduce the cost
    */
    function bidMarket(uint32 rabbitid, uint step) public view { 
        require(isPauseSave());
        rabbitid;
        step;
    }

    
    /**
    * @dev give a rabbit to a specific user
    * @param add new address owner rabbits
    */
    function giff(uint32 bunnyid, address add) public {
        require(rabbitToOwner[bunnyid] == msg.sender);
        // a rabbit taken for free can not be given
        require(!(giffblock[bunnyid]));
        transferFrom(msg.sender, add, bunnyid);
    }

    function getMarketCount() public view returns(uint) {
        return marketCount;
    }
}
