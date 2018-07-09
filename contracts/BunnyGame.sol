pragma solidity ^0.4.23;

import "./RabbitMarket.sol";

/**
* 
*/
contract BunnyGame is RabbitMarket {    
  
   



    function transferNewBunny(address _to, uint32 _bunnyid, uint localdnk, uint breed, uint32 matron, uint32 sire) internal {
        emit NewBunny(_bunnyid, localdnk, block.number, breed);
        emit CreateChildren(matron, sire, _bunnyid);
        //rabbitToOwner[_bunnyid] = _to; 
        addTokenList(_to, _bunnyid);
        totalSalaryBunny[_bunnyid] = 0;
        motherCount[_bunnyid] = 0;
        totalBunny++;
    }

    /***
    * @dev create a new gene and put it up for sale, this operation takes place on the server
    */
    function createGennezise(uint32 _matron) public {
         
        bool promo = false;
        require(isPriv());
        require(isPauseSave());
        require(isPromoPause());
 
        if (totalGen0 > promoGen0) { 
            require(msg.sender == ownerServer || msg.sender == ownerCEO);
        } else if (!(msg.sender == ownerServer || msg.sender == ownerCEO)) {
            // promo action
                require(!ownerGennezise[msg.sender]);
                ownerGennezise[msg.sender] = true;
                promo = true;
        }
        
        uint  localdnk = privateContract.getNewRabbit();
        Rabbit memory _Rabbit =  Rabbit( 0, 0, block.number, 0, 0, 0, 0);
        uint32 _bunnyid =  uint32(rabbits.push(_Rabbit));
        mapDNK[_bunnyid] = localdnk;
       
        transferNewBunny(msg.sender, _bunnyid, localdnk, 0, 0, 0);  
        
        lastTimeGen0 = now;
        lastIdGen0 = _bunnyid; 
        totalGen0++; 

        setRabbitMother(_bunnyid, _matron);

        if (promo) {
            giffblock[_bunnyid] = true;
        }
    }




    function getGenomeChildren(uint32 _matron, uint32 _sire) public view returns(uint) {
        uint genome;
        if (rabbits[(_matron-1)].genome >= rabbits[(_sire-1)].genome) {
            genome = rabbits[(_matron-1)].genome;
        } else {
            genome = rabbits[(_sire-1)].genome;
        }
        return genome.add(1);
    }
    
    function createChildren(uint32 _matron, uint32 _sire) public  payable returns(uint32) {

        require(isPriv());
        require(isPauseSave());
        require(rabbitToOwner[_matron] == msg.sender);
        // Checking for the role
        require(rabbits[(_sire-1)].role == 1);
        require(_matron != _sire);

        require(getBreed(_matron));
        // Checking the money 
        
        require(msg.value >= getSirePrice(_sire));
        
        uint genome = getGenomeChildren(_matron, _sire);

        uint localdnk =  privateContract.mixDNK(mapDNK[_matron], mapDNK[_sire], genome);
        Rabbit memory rabbit =  Rabbit(_matron, _sire, block.number, 0, 0, 0, genome);

        uint32 bunnyid =  uint32(rabbits.push(rabbit));
        mapDNK[bunnyid] = localdnk;


        uint _moneyMother = rabbitSirePrice[_sire].div(4);

        _transferMoneyMother(_matron, _moneyMother);

        rabbitToOwner[_sire].transfer(rabbitSirePrice[_sire]);

        uint system = rabbitSirePrice[_sire].div(100);
        system = system.mul(commission_system);
        ownerMoney.transfer(system); // refund previous bidder
  
        coolduwnUP(_matron);
        // передаём кролика новому обладателю
        transferNewBunny(rabbitToOwner[_matron], bunnyid, localdnk, genome, _matron, _sire);   
        // we establish parents for the child
        setRabbitMother(bunnyid, _matron);
        return bunnyid;
    } 
  


  
    /**
     *  Устанавливаем кулдаун на роды
     */
    function coolduwnUP(uint32 _mother) internal { 
        require(isPauseSave());
        rabbits[(_mother-1)].birthCount = rabbits[(_mother-1)].birthCount.add(1);
        rabbits[(_mother-1)].birthLastTime = now;
    }


    /**
     * @param _mother - matron send money for parrent
     * @param _valueMoney - current sale
     */
    function _transferMoneyMother(uint32 _mother, uint _valueMoney) internal {
        require(isPauseSave());
        require(_valueMoney > 0);
        if (getRabbitMotherSumm(_mother) > 0) {
            uint pastMoney = _valueMoney/getRabbitMotherSumm(_mother);
            for (uint i=0; i < getRabbitMotherSumm(_mother); i++) {
                if (rabbitMother[_mother][i] != 0) { 
                    uint32 _parrentMother = rabbitMother[_mother][i];
                    address add = rabbitToOwner[_parrentMother];
                    // платим зарплату
                    setMotherCount(_parrentMother);
                    totalSalaryBunny[_parrentMother] += pastMoney;

                    emit SalaryBunny(_parrentMother, totalSalaryBunny[_parrentMother]);

                    add.transfer(pastMoney); // refund previous bidder
                }
            } 
        }
    }
    
    /**
    * @dev We set the cost of renting our genes
    * @param price rent price
     */
    function setRabbitSirePrice(uint32 _rabbitid, uint price) public returns(bool) {
        require(isPauseSave());
        require(rabbitToOwner[_rabbitid] == msg.sender);
        require(price > bigPrice);

        uint lastTime;
        (lastTime,,) = getcoolduwn(_rabbitid);
        require(now >= lastTime);

        if (rabbits[(_rabbitid-1)].role == 1 && rabbitSirePrice[_rabbitid] == price) {
            return false;
        }

        rabbits[(_rabbitid-1)].role = 1;
        rabbitSirePrice[_rabbitid] = price;
        uint gen = rabbits[(_rabbitid-1)].genome;
        sireGenom[gen].push(_rabbitid);
        emit ChengeSex(_rabbitid, true);
        return true;
    }
 
    /**
    * @dev We set the cost of renting our genes
     */
    function setSireStop(uint32 _rabbitid) public returns(bool) {
        require(isPauseSave());
        require(rabbitToOwner[_rabbitid] == msg.sender);
     //   require(rabbits[(_rabbitid-1)].role == 0);

        rabbits[(_rabbitid-1)].role = 0;
        rabbitSirePrice[_rabbitid] = 0;
        deleteSire(_rabbitid);
        return true;
    }
    
      function deleteSire(uint32 _tokenId) internal { 
        uint gen = rabbits[(_tokenId-1)].genome;

        uint count = sireGenom[gen].length;
     //   if(0 == count) {
      //      return;
      //  }
        for (uint i = 0; i < count; i++) {
            if(sireGenom[gen][i] == _tokenId)
            { 
                delete sireGenom[gen][i];
                if(count > 0 && count != (i-1)){
                    sireGenom[gen][i] = sireGenom[gen][(count-1)];
                    delete sireGenom[gen][(count-1)];
                } 
                sireGenom[gen].length--;
                emit ChengeSex(_tokenId, false);
                return;
            } 
        }
    }
    
    /**
    *  @dev give the name and description for the rabbit
    * @param description new description rabbits
    */
    function setDescriptionRabbit(uint32 rabbitid, string description) public {
        require(isPauseSave());
        require(rabbitToOwner[rabbitid] == msg.sender);
        emit BunnyDescription(rabbitid, description);
        if (bytes(description).length < 256 && bytes(description).length > 0) {
            rabbitDescription[rabbitid] = description;
        }
    } 
     
    function getDescriptionRabbit(uint32 _rabbitid) public view returns(string) {
        return rabbitDescription[_rabbitid];
    } 
    
//    event BunnyName(uint32 bunnyId, string name);
  //  event BunnyDescription(uint32 bunnyId, string name);
    /**
    *  @dev give the name and description for the rabbit
    * @param name new name rabbits
    */
    function setNameRabbit(uint32 _rabbitid, string name) public {
        require(isPauseSave());
        require(rabbitToOwner[_rabbitid] == msg.sender);
        emit BunnyName(_rabbitid, name);
        if (bytes(name).length < 256 && bytes(name).length > 0) {
            rabbitName[_rabbitid] = name;
        }
    } 
    function getNameRabbit(uint32 _rabbitid) public view returns(string) {
        return rabbitName[_rabbitid];
    } 

    function getMoney(uint _value) public onlyOwner {
        require(address(this).balance >= _value);
        ownerMoney.transfer(_value);
    }
}