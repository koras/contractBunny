pragma solidity ^0.4.23; 
import "./BodyRabbit.sol"; 
contract BunnyGame is BodyRabbit { 

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
        
        totalGen0++; 
        setRabbitMother(_bunnyid, _matron);

        if(_matron != 0){  
            emit Referral(msg.sender, _matron, _bunnyid, block.timestamp);
        }
        
        if (promo) { 
            TokenBunny.setGiffBlock(_bunnyid, true);
        }
        emit Transfer(this, msg.sender, _bunnyid);
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
    function createChildren(uint32 _matron, uint32 _sire) public  payable returns(uint32) {

        require(isPriv());
        require(isPauseSave());
        require(TokenBunny.ownerOf(_matron) == msg.sender);
        require(TokenBunny.getSex(_sire) == true);
        require(_matron != _sire);
        require(getBreed(_matron));
        require(msg.value >= getSirePrice(_sire));
        uint genome = getGenomeChildren(_matron, _sire);
        uint localdnk =  privateContract.mixDNK(TokenBunny.getDNK(_matron), TokenBunny.getDNK(_sire), genome);
 
        uint32 bunnyid = TokenBunny.setTokenBunny(_matron, _sire, block.number, 0, 0, genome, msg.sender, localdnk);
        uint _moneyMother = TokenBunny.getRabbitSirePrice(_sire).div(4);
        _transferMoneyMother(_matron, _moneyMother);

        TokenBunny.ownerOf(_sire).transfer( TokenBunny.getRabbitSirePrice(_sire) );
 
        uint system = TokenBunny.getRabbitSirePrice(_sire).div(100);

        system = system.mul(commission_system);
        ownerMoney.transfer(system);
        coolduwnUP(_matron); 
        setRabbitMother(bunnyid, _matron);
        emit Transfer(this, msg.sender, bunnyid);
        return bunnyid;
    } 
    function coolduwnUP(uint32 _mother) internal { 
        require(isPauseSave());
        uint coolduwn = TokenBunny.getBirthCount(_mother).add(1);
        TokenBunny.setBirthCount(_mother, coolduwn);
        TokenBunny.setBirthLastTime(_mother, now);
        emit CoolduwnMother(_mother, TokenBunny.getBirthCount(_mother));
    }
    function _transferMoneyMother(uint32 _mother, uint _valueMoney) internal {
        require(isPauseSave());
        require(_valueMoney > 0);
        if (getRabbitMotherSumm(_mother) > 0) {
            uint pastMoney = _valueMoney/getRabbitMotherSumm(_mother);
            
            for (uint i=0; i < getRabbitMotherSumm(_mother); i++) {

                if ( TokenBunny.getRabbitMother(_mother)[i] != 0) { 
                    uint32 _parrentMother = TokenBunny.getRabbitMother(_mother)[i];
                    address add = TokenBunny.ownerOf(_parrentMother);
                    TokenBunny.setMotherCount(_parrentMother, TokenBunny.getMotherCount(_parrentMother).add(1));
                    TokenBunny.setTotalSalaryBunny( _parrentMother, TokenBunny.getTotalSalaryBunny(_parrentMother).add(pastMoney));
                    emit SalaryBunny(_parrentMother, TokenBunny.getTotalSalaryBunny(_parrentMother));
                    add.transfer(pastMoney); // refund previous bidder
                }
            } 
        }
    }
    /*
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
        emit ChengeSex(_rabbitid, true, getSirePrice(_rabbitid));

    }
    function setSireStop(uint32 _rabbitid) public returns(bool) {
        require(isPauseSave());
        require(TokenBunny.getRabbitSirePrice(_rabbitid) !=0);

        require(TokenBunny.ownerOf(_rabbitid) == msg.sender);
     //   require(rabbits[(_rabbitid-1)].role == 0);
        TokenBunny.setRabbitSirePrice( _rabbitid, 0);
     //   deleteSire(_rabbitid);
        emit ChengeSex(_rabbitid, false, 0);
        return true;
    }*/
    function getMoney(uint _value) public onlyOwner {
        require(address(this).balance >= _value);
        ownerMoney.transfer(_value);
    }
} 