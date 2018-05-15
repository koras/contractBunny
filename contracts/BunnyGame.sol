pragma solidity ^0.4.23;

import "./RabbitMarket.sol";

/**
* 
*/
contract BunnyGame is RabbitMarket {    
 
    event NewBunny(uint32 bunnyid, uint dnk, uint256 blocknumber );
        /***
        * @dev create a new gene and put it up for sale, this operation takes place on the server
         */


    function transferNewBunny(address _to, uint32 _bunnyid, uint localdnk) internal {
        emit NewBunny(_bunnyid, localdnk, block.number);
        //rabbitToOwner[_bunnyid] = _to; 
        addTokenList(_to, _bunnyid);
        totalSalaryBunny[_bunnyid] = 0;
        totalBunny++;
    }
    
    
    function createGennezise() public  onlyServer returns(uint32) {
        require(isPriv());
        require(isPauseSave());
        uint  localdnk = privateContract.getNewRabbit();
        Rabbit memory _Rabbit =  Rabbit(0, 0, block.number, 0, 0);
        uint32 bunnyid =  uint32(rabbits.push(_Rabbit));
        mapDNK[bunnyid] = localdnk;
        
        transferNewBunny(ownerMoney, bunnyid, localdnk);   

        uint _money = getpricegen0();

        setMarket(bunnyid, _money);
          
        lastTimeGen0 = now;
        lastIdGen0 = bunnyid; 
        totalGen0++;
        return bunnyid;
    }
   
   
  
   
    /**
    * @dev create new children
    */
    function createChildren(uint32 _matron, uint32 _sire) public  payable returns(uint32) {

        require(isPriv());
        require(isPauseSave());
        require(rabbitToOwner[_matron] == msg.sender);
        // Checking for the role
        require(rabbitRole[_sire] == 1);
        require(_matron != _sire);

        uint lastTime;
        (lastTime,) = getcoolduwn(_matron);
        require(now >= lastTime);

        // Checking the money
        uint _sirePrice = rabbitSirePrice[_sire];
        uint _moneyMother = _sirePrice/4;
        uint _finalCost = _moneyMother + _sirePrice;
        require(msg.value >= _finalCost);
          
        // create 
        uint elementmatron = mapDNK[_matron];
        uint elementsire = mapDNK[_sire];
        
        uint localdnk =  privateContract.mixDNK(elementmatron, elementsire);
        Rabbit memory rabbit =  Rabbit(_matron, _sire, block.number, 0, 0);
        
        uint32 bunnyid =  uint32(rabbits.push(rabbit));
        mapDNK[bunnyid] = localdnk;
        _transferMoneyMother(_matron, _moneyMother);

        rabbitToOwner[_sire].transfer(_sirePrice);
        
        coolduwnUP(_matron);
        // передаём кролика новому обладателю
        transferNewBunny(rabbitToOwner[_matron], bunnyid, localdnk);   
          
        // we establish parents for the child
        setRabbitMother(bunnyid, _matron);
         
        return bunnyid;
    }
    


    /**
     *  получаем cooldown
     */
    function getcoolduwn(uint32 _mother) public view returns(uint lastTime, uint cd, uint lefttime) {
        cd = rabbits[(_mother-1)].birthCount;
        if(cd > 14) {
            cd = 14;
        }
        // время когда я могу рожать
        lastTime = (cooldowns[cd] + rabbits[(_mother-1)].birthLastTime);
        if(lastTime > now)
        {
            // не могу рожать, осталось до родов 
            lefttime = lastTime - now;
        }
    }


    /**
     *  Устанавливаем кулдаун на роды
     */
    function coolduwnUP(uint32 _mother) internal { 
        require(isPauseSave());
        rabbits[(_mother-1)].birthCount++;
        rabbits[(_mother-1)].birthLastTime = now;
    }


    /**
     * @param _mother - matron send money for parrent
     * @param _valueMoney - current sale
     */
    function _transferMoneyMother(uint32 _mother, uint _valueMoney) internal {
        require(isPauseSave());
        if (rabbitMother[_mother].length > 0) {
            uint pastMoney = _valueMoney/uint(rabbitMother[_mother].length);
            for (uint i=0; i < rabbitMother[_mother].length; i++) {


                uint32 _parrentMother = rabbitMother[_mother][i];
                address add = rabbitToOwner[_parrentMother];
                // платим зарплату
                totalSalaryBunny[_parrentMother] += pastMoney;
                add.transfer(pastMoney); // refund previous bidder
            }
            ownerMoney.transfer(_valueMoney); // refund previous bidder
        }
    }
    
    
    /**
    * @dev We set the cost of renting our genes
    * @param price rent price
     */
    function setRabbitSirePrice(uint32 _rabbitid, uint price) public returns(bool) {
        require(isPauseSave());
        require(rabbitToOwner[_rabbitid] == msg.sender);
        rabbitRole[_rabbitid] = 1;
        rabbitSirePrice[_rabbitid] = (price * bigPrice);
        return true;
    }
 
    
    /**
    *  @dev give the name and description for the rabbit
    * @param description new description rabbits
    */
    function setDescriptionRabbit(uint32 rabbitid, string description) public {
        require(isPauseSave());
        require(rabbitToOwner[rabbitid] == msg.sender);
        if (bytes(description).length < 256 && bytes(description).length > 0) {
            rabbitDescription[rabbitid] = description;
        }
    } 
     
    function getDescriptionRabbit(uint32 _rabbitid) public view returns(string) {
        return rabbitDescription[_rabbitid];
    } 
    
    /**
    *  @dev give the name and description for the rabbit
    * @param name new name rabbits
    */
    function setNameRabbit(uint32 rabbitid, string name) public {
        require(isPauseSave());
        require(rabbitToOwner[rabbitid] == msg.sender);
        if (bytes(name).length < 256 && bytes(name).length > 0) {
            rabbitName[rabbitid] = name;
        }
    } 
    function getNameRabbit(uint32 rabbitid) public view returns(string) {
        return rabbitName[rabbitid];
    } 

    function getMoney(uint _value) public onlyOwner {
        require(address(this).balance >= _value);
        ownerMoney.transfer(_value);
    }











//////////////////////////////////////////////////////

    function wStartTest() public onlyOwner {
        createGennezise();//1
        createGennezise();//2
        createGennezise();//3
        createGennezise();//4
        createGennezise();//5
        createGennezise();//6
        createGennezise();//7
        createGennezise();//8
        createGennezise();//9
        createGennezise();//10
        createGennezise();//11
        createGennezise();//12
        createGennezise();//13
        createGennezise();//14
         
    }
    function wGiffTest() public onlyOwner {
       giff(uint32(2) ,0x82c2601dF5171c09979A26779018e029B0df5f45);
       giff(uint32(3) ,0x82c2601dF5171c09979A26779018e029B0df5f45);
    }



     
}


     