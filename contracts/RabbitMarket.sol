pragma solidity ^0.4.23;
import "./BodyRabbit.sol"; 

/**
* sale and bye Rabbits
*/
contract RabbitMarket is BodyRabbit {

    event SendBunny(address newOwnerBunny, uint32 bunnyId);
    event StopMarket(uint32 bunnyId);
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
  
    function startMarket(uint32 _bunnyid, uint _money) public returns (uint) {
        require(isPauseSave());
        require(_money >= bigPrice);
        require(rabbitToOwner[_bunnyid] ==  msg.sender);
       // _money =  _money;
        stopMarket(_bunnyid); 
        Bids memory bid = Bids(_bunnyid, _money, now);
      
        bidsArray[marketCount] = bid;
        bidsIndex[_bunnyid] = marketCount;
           marketCount++;
        return marketCount; 
    }

    /**
    * @dev get rabbit price
    */
    function currentPrice(uint32 _bunnyid) public view returns(uint) {
        uint index = bidsIndex[_bunnyid];
        if (index == 0) {
            return 0;
        }
        uint Money = bidsArray[index].startMoney;
        if (Money > 0) {
            uint moneyComs = Money.div(100);
            moneyComs = moneyComs.mul(5);
            return Money.add(moneyComs);
        }
    }



    /**
    * @dev get rabbit price
    */
    function currentPrices(uint32 _bunnyid) public view returns( uint index, uint Money, uint32 bunny ) { //test
        
        if (_bunnyid == 0) {
            return;
        }

         index = bidsIndex[_bunnyid];
         Money = bidsArray[index].startMoney;
         bunny = bidsArray[index].rabbitID;
        if (Money > 0) {
            uint moneyComs = Money.div(100);
            moneyComs = moneyComs.mul(5);
           Money =  Money.add(moneyComs);
        }
    }

    // https://ethereum.stackexchange.com/questions/1527/how-to-delete-an-element-at-a-certain-index-in-an-array
    function stopMarket(uint32 _bunnyid) public returns(uint) {
        require(isPauseSave());
        require(rabbitToOwner[_bunnyid] == msg.sender);  
            uint i = bidsIndex[_bunnyid];
            if (bidsArray[i].rabbitID == _bunnyid) {
                uint indexOld = bidsIndex[_bunnyid];
                delete bidsIndex[_bunnyid];
                delete bidsArray[i];
                if (marketCount > 0 && i > 0 && marketCount != (i-1)) {
                    bidsArray[i] = bidsArray[(marketCount-1)];
                    uint32 b = bidsArray[i].rabbitID;
                    bidsIndex[b] = indexOld;
                    emit StopMarket(_bunnyid);
                delete  bidsArray[(marketCount-1)];
                }
                return marketCount--;
            }
        return marketCount;
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
                _money = _money.add(_money.div(3));
            } else {
                _money = _money.sub(_money.div(3));
            }
            middleSaleTime = _time;
        }
        return  _money;
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
