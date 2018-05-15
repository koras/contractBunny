pragma solidity ^0.4.23;
import "./BodyRabbit.sol"; 

/**
* sale and bye Rabbits
*/
contract RabbitMarket is BodyRabbit {

    event SendBunny(address newOwnerBunny, uint32 bunnyId);

 // Long time
    uint stepMoney = 2*60*60;
           
    function setStepMoney(uint money) public onlyTech {
        stepMoney = money;
    }
    /**
    * @dev number of rabbits participating in the auction
    */
    uint marketCount = 1;
    
    mapping(uint32 => uint) public rabbitSirePrice;

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


    // number of seals currently on sale
  //  uint public bidCount = 0;

     
    /**
    * @param  money;
    * @param  timeStart; 
    * @param  timeFinish; 
    */
    struct BidClosed {
        uint money;
        uint timeRange;  
    }
    /**
    * @param  BidClosed 
    */
    mapping(uint=>BidClosed) sellerOfRabbit;
 
    //how many closed auctions
    uint public totalClosedBID = 0;
     
     
     
    /**
    * @param  _rabbitID;
    * @param  _rabbitSeller;
    * @param  startMoney;
    */
    struct Bids {
        uint32 rabbitID; 
        uint  startMoney;
        uint  timeStart;
    }
    mapping(uint=>Bids) public bidsArray;

    mapping(uint32 => uint) bidsIndex;
 
   // mapping (address => uint) sellerOfRabbit;
     
     /*** 
    */
    function setMarket( uint32 _bunnyid, uint _money) public  {
        require(isPauseSave());
        require(rabbitToOwner[_bunnyid] == msg.sender);
        _money = bigPrice*_money;
        Bids memory bid = Bids(_bunnyid, _money, now);
        bidsArray[marketCount] = bid;
        bidsIndex[_bunnyid] = marketCount;
        marketCount++; 
    }

 
    

        /**
    * @dev get rabbit price
    */
    function currentPrice(uint32 bunnyid) public view returns(uint) {
        uint index = bidsIndex[bunnyid];

        uint timeStart = bidsArray[index].timeStart;
        uint startMoney = bidsArray[index].startMoney;

        uint resMoney = 0;
        uint rangeTime = now - timeStart;
        if(stepMoney != 0) { 
            uint iter = rangeTime / stepMoney;
            if(iter != 0 && startMoney != 0) {
                uint range = startMoney / 1000;
                resMoney = startMoney - range*10;
             }else{
                 resMoney = startMoney;
             }
        }
        return resMoney;
    }
    

    function buyBunny(uint32 _bunnyid) public payable {

        require(isPauseSave());
        require(rabbitToOwner[_bunnyid] != msg.sender);
        uint price = currentPrice(_bunnyid);
      //  require(0 != price);
        require(msg.value >= price && 0 != price);
        
        // останавливаем торги по текущему кролику
        stopMarket(_bunnyid); 
        totalClosedBID++;

        // пересылается новому хозяину купившиму кролика
        transferFrom( rabbitToOwner[_bunnyid], msg.sender, _bunnyid);
        sendMoney(rabbitToOwner[_bunnyid], msg.value);
   
        sellerOfRabbit[totalClosedBID] = BidClosed(price, (now - bidsArray[bidsIndex[_bunnyid]].timeStart ));
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

    function giff(uint32 bunnyid, address add) public  {
        require(rabbitToOwner[bunnyid] == msg.sender);
        transferFrom(msg.sender, add, bunnyid);
    }
    
    
    /**
    * @dev Get the cost of the zeroth gene necessary to add to the store
    */

    function getpricegen0() internal returns(uint _money) {
        if (totalGen0 <= promoGen0) { 
           return _money = promoMoney;
        }
        uint _time = 0;
        uint lostmoney = 0;
        uint losttime = 0;
        uint losttimerange = 0;
        if ((totalClosedBID-middlelast) > 0) {
            for (uint32 i = uint32(totalClosedBID-middlelast); i > totalClosedBID; i++) {

                lostmoney = sellerOfRabbit[i].money + lostmoney;
                losttimerange = sellerOfRabbit[i].timeRange;
                losttime = losttime + losttimerange;
            }
            _money = lostmoney / middlelast;
            _time = losttime / middlelast;
             
            if (middleSaleTime >= _time) {
                _money = _money + (_money / 3);
            } else {
                _money = _money - (_money / 3);
            }
            middleSaleTime = _time;
        }
        return  _money;
    } 



    // https://ethereum.stackexchange.com/questions/1527/how-to-delete-an-element-at-a-certain-index-in-an-array
    function getBids(uint page) 
            public view returns(
                uint32[12] rabbitID, 
                address[12]rabbitSeller, 
                uint[12]startMoneyBids, 
                uint[12]timeStartBids, 
                uint[12]currentPriceBids,
                uint elementEnd,
                uint elementTotal
                ) {
                
                uint32 bunnyID = 0;
                uint pagecount = 12;
                uint start = 0;

                if (page < 1) {
                    page = 1;
                }
                
                elementEnd = page * pagecount;
                if (elementEnd > marketCount) {
                    elementEnd = marketCount;
                }
                elementTotal = marketCount;
                uint startArray = (((page-1)*pagecount)+1);

                for (uint i = startArray; i < (elementEnd+1); i++) {

                    bunnyID = uint32(bidsArray[i].rabbitID);
                    rabbitID[start] = uint32(bidsArray[i].rabbitID);

                    rabbitSeller[start] = rabbitToOwner[bunnyID]; 

                    startMoneyBids[start] = bidsArray[i].startMoney; 
                    timeStartBids[start] = bidsArray[i].timeStart;
                    currentPriceBids[start] = currentPrice(bunnyID);
                    start++;
                }
            }

     // https://ethereum.stackexchange.com/questions/1527/how-to-delete-an-element-at-a-certain-index-in-an-array
    function stopMarket(uint32 _bunnyID) public returns(uint) {
        require(isPauseSave());
        // require(rabbitToOwner[_bunnyID] == msg.sender); //dev
        for (uint i = 0; i <= marketCount; i++) {
            if (bidsArray[i].rabbitID == _bunnyID) {
                delete bidsArray[i];
                if (marketCount > 0 && i > 0 && marketCount != (i-1)) {
                    bidsArray[i] = bidsArray[(marketCount-1)];
                delete  bidsArray[(marketCount-1)];
                }
                return marketCount--;
            }
        }
        return marketCount;
    }
    

    function getMarketCount() public view returns(uint) {
        return marketCount;
    }
}
