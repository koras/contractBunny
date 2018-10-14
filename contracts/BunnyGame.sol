pragma solidity ^0.4.23; 
import "./BodyRabbit.sol"; 
/**
* Basic actions for the transfer of rights of rabbits
*/ 
 
contract BunnyGame is BodyRabbit{    
  
    function transferNewBunny(address _to, uint32 _bunnyid, uint localdnk, uint breed, uint32 matron, uint32 sire, uint procentAdmixture, uint admixture) internal {
        emit NewBunny(_bunnyid, localdnk, block.number, breed, procentAdmixture, admixture);
        emit CreateChildren(matron, sire, _bunnyid);
        addTokenList(_to, _bunnyid);
        totalSalaryBunny[_bunnyid] = 0;
        motherCount[_bunnyid] = 0;
        allowedChangeSex[_bunnyid] = true;
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
            require(getInWhitelist(msg.sender));
        } else if (!(getInWhitelist(msg.sender))) {
            // promo action
                require(!ownerGennezise[msg.sender]);
                ownerGennezise[msg.sender] = true;
                promo = true;
        }
        
        uint  localdnk = privateContract.getNewRabbit(msg.sender);
        Rabbit memory _Rabbit =  Rabbit( 0, 0, block.number, 0, 0, 0, 0, 0, 0);
        uint32 _bunnyid =  uint32(rabbits.push(_Rabbit));
        mapDNK[_bunnyid] = localdnk;
       
        transferNewBunny(msg.sender, _bunnyid, localdnk, 0, 0, 0, 4, 0);  
        
        
        totalGen0++; 

        setRabbitMother(_bunnyid, _matron);

        emit Referral(msg.sender, _matron, _bunnyid, block.timestamp);

        if (promo) {
            giffblock[_bunnyid] = true;
        }
    }

    function getGenomeChildren(uint32 _matron, uint32 _sire) internal view returns(uint) {
        uint genome;
        if (rabbits[(_matron-1)].genome >= rabbits[(_sire-1)].genome) {
            genome = rabbits[(_matron-1)].genome;
        } else {
            genome = rabbits[(_sire-1)].genome;
        }
        return genome.add(1);
    }
    
    /**
    * create a new rabbit, according to the cooldown
    * @param _matron - mother who takes into account the cooldown
    * @param _sire - the father who is rewarded for mating for the fusion of genes
     */
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

        uint procentAdm; 
        uint admixture;
        (procentAdm, admixture) = AdmixtureContract.getAdmixture(rabbits[(_sire-1)].procentAdmixture, rabbits[(_matron-1)].procentAdmixture);
        Rabbit memory rabbit =  Rabbit(_matron, _sire, block.number, 0, 0, 0, genome, procentAdm, admixture);

        uint32 bunnyid =  uint32(rabbits.push(rabbit));
        mapDNK[bunnyid] = localdnk;

        uint _moneyMother = rabbitSirePrice[_sire].div(4);

        _transferMoneyMother(_matron, _moneyMother);

        rabbitToOwner[_sire].transfer(rabbitSirePrice[_sire]);

        uint system = rabbitSirePrice[_sire].div(100);
        system = system.mul(commission_system);
        ownerMoney.transfer(system); // refund previous bidder
  
        coolduwnUP(_matron);
        // we transfer the rabbit to the new owner
        transferNewBunny(rabbitToOwner[_matron], bunnyid, localdnk, genome, _matron, _sire, procentAdm, admixture );   
        // we establish parents for the child
        setRabbitMother(bunnyid, _matron);
        return bunnyid;
    } 
  
    /**
     *  Set the cooldown for childbirth
     * @param _mother - mother for which cooldown
     */
    function coolduwnUP(uint32 _mother) internal { 
        require(isPauseSave());
        rabbits[(_mother-1)].birthCount = rabbits[(_mother-1)].birthCount.add(1);
        rabbits[(_mother-1)].birthLastTime = now;
        emit CoolduwnMother(_mother, rabbits[(_mother-1)].birthCount);
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
                    // pay salaries
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
        require(allowedChangeSex[_rabbitid]);

        uint lastTime;
        (lastTime,,) = getcoolduwn(_rabbitid);
        require(now >= lastTime);

        if (rabbits[(_rabbitid-1)].role == 1 && rabbitSirePrice[_rabbitid] == price) {
            return false;
        }

        rabbits[(_rabbitid-1)].role = 1;
        rabbitSirePrice[_rabbitid] = price;
      //  uint gen = rabbits[(_rabbitid-1)].genome;
       // sireGenom[gen].push(_rabbitid);
        emit ChengeSex(_rabbitid, true, getSirePrice(_rabbitid));
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
     //   deleteSire(_rabbitid);
        emit ChengeSex(_rabbitid, false, 0);
        return true;
    }
    
   //   function deleteSire(uint32 _tokenId) internal { 
      //  uint gen = rabbits[(_tokenId-1)].genome;

       // uint count = sireGenom[gen].length;
      //  for (uint i = 0; i < count; i++) {
         //   if(sireGenom[gen][i] == _tokenId)
            //{ 
              //  delete sireGenom[gen][i];
              //  if(count > 0 && count != (i-1)){
               //     sireGenom[gen][i] = sireGenom[gen][(count-1)];
               //     delete sireGenom[gen][(count-1)];
              //  } 
              //  sireGenom[gen].length--;
             //   emit ChengeSex(_tokenId, false, 0);
            //    return;
          //  } 
       // }
   // } 

    function getMoney(uint _value) public onlyOwner {
        require(address(this).balance >= _value);
        ownerMoney.transfer(_value);
    }

    /**
    * @dev give a rabbit to a specific user
    * @param add new address owner rabbits
    */
    function gift(uint32 bunnyid, address add) public {
        require(rabbitToOwner[bunnyid] == msg.sender);
        // a rabbit taken for free can not be given
        require(!(giffblock[bunnyid]));
        
        transferFrom(msg.sender, add, bunnyid);
        allowedChangeSex[bunnyid] = false;
    }
} 