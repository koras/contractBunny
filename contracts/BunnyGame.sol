pragma solidity ^0.4.23; 
import "./BodyRabbit.sol"; 
/**
* Basic actions for the transfer of rights of rabbits
*/ 
 
contract BunnyGame is BodyRabbit {    
  
    event CreateChildren(uint32 matron, uint32 sire, uint32 child);

   // function transferNewBunny(address _to, uint32 _bunnyid, uint localdnk, uint breed, uint32 matron, uint32 sire) internal {
   //     emit NewBunny(_bunnyid, localdnk, block.number, breed, 0, 0);
    //    emit CreateChildren(matron, sire, _bunnyid);
     //   addTokenList(_to, _bunnyid);

      //  totalSalaryBunny[_bunnyid] = 0;
       // motherCount[_bunnyid] = 0;
    //    TokenBunny.setMotherCount(_bunnyid,0);
      //  allowedChangeSex[_bunnyid] = true;

      //  totalBunny++;
   // }

         
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
                require(!TokenBunny.getOwnerGennezise(msg.sender));
                TokenBunny.setOwnerGennezise(msg.sender, true);
                promo = true;
        }
        uint  localdnk = privateContract.getNewRabbit(msg.sender);
        uint32 _bunnyid = TokenBunny.setTokenBunny(0, 0, block.number, 0, 0, 0, msg.sender, localdnk);
   
      //  transferNewBunny(msg.sender, _bunnyid, localdnk, 0, 0, 0);  
        
      //  totalGen0++; 
        setRabbitMother(_bunnyid, _matron);
        emit Referral(msg.sender, _matron, _bunnyid, block.timestamp);
        if (promo) { 
            TokenBunny.setGiffBlock(_bunnyid, true);
        }
    }

 



    function getGenomeChildren(uint32 _matron, uint32 _sire) internal view returns(uint) {
        uint genome;
        if (TokenBunny.getGenome(_matron) >= TokenBunny.getGenome(_sire)) {
            genome = TokenBunny.getGenome(_matron);
        } else {
            genome = TokenBunny.getGenome(_sire);
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
        require(TokenBunny.ownerOf(_matron) == msg.sender);
        // Checking for the role
        require(TokenBunny.getSex(_sire) == true);
        require(_matron != _sire);

        require(getBreed(_matron));
        // Checking the money 
        
        require(msg.value >= getSirePrice(_sire));
        
        uint genome = getGenomeChildren(_matron, _sire);

        uint localdnk =  privateContract.mixDNK(TokenBunny.getDNK(_matron), TokenBunny.getDNK(_sire), genome);
 
        uint32 bunnyid = TokenBunny.setTokenBunny(_matron, _sire, block.number, 0, 0, genome, msg.sender, localdnk);
 
 
        uint _moneyMother = TokenBunny.getRabbitSirePrice(_sire).div(4);

        _transferMoneyMother(_matron, _moneyMother);

        TokenBunny.ownerOf(_sire).transfer( TokenBunny.getRabbitSirePrice(_sire) );
 
        uint system = TokenBunny.getRabbitSirePrice(_sire).div(100);

        system = system.mul(commission_system);
        ownerMoney.transfer(system); // refund previous bidder
  
        coolduwnUP(_matron); 
        setRabbitMother(bunnyid, _matron);
        return bunnyid;
    } 
  
    /**
     *  Set the cooldown for childbirth
     * @param _mother - mother for which cooldown
     */
    function coolduwnUP(uint32 _mother) internal { 
        require(isPauseSave());

        uint coolduwn = TokenBunny.getBirthCount(_mother).add(1);
        TokenBunny.setBirthCount(_mother, coolduwn);
        TokenBunny.setBirthLastTime(_mother, now);
        emit CoolduwnMother(_mother, TokenBunny.getBirthCount(_mother));
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

                if ( TokenBunny.getRabbitMother(_mother)[i] != 0) { 
                    uint32 _parrentMother = TokenBunny.getRabbitMother(_mother)[i];
                    address add = TokenBunny.ownerOf(_parrentMother);
                    // pay salaries 

                    TokenBunny.setMotherCount(_parrentMother, TokenBunny.getMotherCount(_parrentMother).add(1));
                    TokenBunny.setTotalSalaryBunny( _parrentMother, TokenBunny.getTotalSalaryBunny(_parrentMother).add(pastMoney));
                    emit SalaryBunny(_parrentMother, TokenBunny.getTotalSalaryBunny(_parrentMother));
                    add.transfer(pastMoney); // refund previous bidder
                }
            } 
        }
    }
    
    /**
    * @dev We set the cost of renting our genes
    * @param price rent price
     */
    function setRabbitSirePrice(uint32 _rabbitid, uint price) public {
        require(isPauseSave());
        require(TokenBunny.ownerOf(_rabbitid) == msg.sender);
        require(price > bigPrice);
 
        require(TokenBunny.getAllowedChangeSex(_rabbitid));
        require(TokenBunny.getRabbitSirePrice(_rabbitid) != price);

        uint lastTime;
        (lastTime,,) = getcoolduwn(_rabbitid);
        require(now >= lastTime);

        TokenBunny.setRabbitSirePrice(_rabbitid, price);
        
      //  uint gen = rabbits[(_rabbitid-1)].genome;
       // sireGenom[gen].push(_rabbitid);
        emit ChengeSex(_rabbitid, true, getSirePrice(_rabbitid));

    }
 
    /**
    * @dev We set the cost of renting our genes
     */
    function setSireStop(uint32 _rabbitid) public returns(bool) {
        require(isPauseSave());
        require(TokenBunny.getRabbitSirePrice(_rabbitid) !=0);

        require(TokenBunny.ownerOf(_rabbitid) == msg.sender);
     //   require(rabbits[(_rabbitid-1)].role == 0);
        TokenBunny.setRabbitSirePrice( _rabbitid, 0);
     //   deleteSire(_rabbitid);
        emit ChengeSex(_rabbitid, false, 0);
        return true;
    }
    
 

    function getMoney(uint _value) public onlyOwner {
        require(address(this).balance >= _value);
        ownerMoney.transfer(_value);
    }

    /**
    * @dev give a rabbit to a specific user
    * @param add new address owner rabbits
    */
    function gift(uint32 bunnyid, address add) public {
        
        require(TokenBunny.ownerOf(bunnyid) == msg.sender);
        // a rabbit taken for free can not be given
        require(!TokenBunny.getGiffBlock(bunnyid));
        // TokenBunny.ownerOf(
        transferFrom(msg.sender, add, bunnyid);
        TokenBunny.setAllowedChangeSex(bunnyid, true);
    }
} 