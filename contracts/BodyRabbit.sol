pragma solidity ^0.4.23;
import "./BaseRabbit.sol"; 

contract BodyRabbit is BaseRabbit {
    uint public totalBunny = 0;
    string public constant name = "CryptoRabbits";
    string public constant symbol = "CRB";

    constructor() public { 
        setPriv(privAddress); 
        setToken(addressTokenBunny ); 
    }
    function ownerOf(uint32 _tokenId) public view returns (address owner) {
        return TokenBunny.ownerOf(_tokenId);
    }
    function balanceOf(address _owner) public view returns (uint balance) {
        return TokenBunny.balanceOf(_owner);
    }
    function transfer(address _to, uint32 _tokenId) public {
     _to;_tokenId;
    }
  function approve(address _to, uint32 _tokenId) public returns (bool success) {
     _to;_tokenId;
      return false;
  }
  
 
    function getSirePrice(uint32 _tokenId) public view returns(uint) {
        if(TokenBunny.getRabbitSirePrice(_tokenId) != 0){
            uint procent = (TokenBunny.getRabbitSirePrice(_tokenId) / 100);
            uint res = procent.mul(25);
            uint system  = procent.mul(commission_system);
            res = res.add( TokenBunny.getRabbitSirePrice(_tokenId));
            return res.add(system); 
        } else {
            return 0;
        }

    }

    function transferFrom(address _from, address _to, uint32 _tokenId) public onlyWhitelisted() returns(bool) {
        if(TokenBunny.transferFrom(_from, _to, _tokenId)){ 
            emit Transfer(_from, _to, _tokenId);
            return true;
        }
        return false;
    }  

    function isPauseSave() public view returns(bool) {
        return !pauseSave;
    }
    
    function isPromoPause() public view returns(bool) {
        if (getInWhitelist(msg.sender)) {
            return true;
        } else {
            return !promoPause;
        } 
    }

    function setPauseSave() public onlyWhitelisted()  returns(bool) {
        return pauseSave = !pauseSave;
    }
 

    function getTokenOwner(address owner) public view returns(uint total, uint32[] list) {
        (total, list) = TokenBunny.getTokenOwner(owner);
    } 


    function setRabbitMother(uint32 children, uint32 mother) internal { 
        require(children != mother);
        uint32[11] memory pullMother;
        uint32[5] memory rabbitMother = TokenBunny.getRabbitMother(mother);
        uint32[5] memory arrayChildren;
        uint start = 0;
        for (uint i = 0; i < 5; i++) {
            if (rabbitMother[i] != 0) {
              pullMother[start] = uint32(rabbitMother[i]);
              start++;
            } 
        }
        pullMother[start] = mother;
        start++;
        for (uint m = 0; m < 5; m++) {
             if(start >  5){
                    arrayChildren[m] = pullMother[(m+1)];
             }else{
                    arrayChildren[m] = pullMother[m];
             }
        }
        TokenBunny.setRabbitMother(children, arrayChildren);
        uint c = TokenBunny.getMotherCount(mother);
        TokenBunny.setMotherCount( mother, c.add(1));
    }

    // function uintToBytes(uint v) internal pure returns (bytes32 ret) {
    //     if (v == 0) {
    //         ret = '0';
    //     } else {
    //     while (v > 0) {
    //             ret = bytes32(uint(ret) / (2 ** 8));
    //             ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
    //             v /= 10;
    //         }
    //     }
    //     return ret;
    // }

    function sendMoney(address _to, uint256 _money) internal { 
        _to.transfer((_money/100)*95);
        ownerMoney.transfer((_money/100)*5); 
    }

    function getOwnerGennezise(address _to) public view returns(bool) { 
        return TokenBunny.getOwnerGennezise(_to);
    }

    function totalSupply() public view returns (uint total){ 
        return TokenBunny.totalSupply();
    }
    
    function getBreed(uint32 _bunny) public view returns(bool interbreed)
        {
            uint birtTime = 0;
            uint birthCount = 0;
            (, , , birthCount, birtTime, ) = TokenBunny.getTokenBunny(_bunny);

            uint  lastTime = uint(cooldowns[birthCount]);
            lastTime = lastTime.add(birtTime);
 
            if(lastTime <= now && TokenBunny.getSex(_bunny) == false) {
                interbreed = true;
            }
    }
    function getcoolduwn(uint32 _mother) public view returns(uint lastTime, uint cd, uint lefttime) {
        uint birthLastTime;
         (, , , cd, birthLastTime, ) = TokenBunny.getTokenBunny(_mother);

        if(cd > 11) {
            cd = 11;
        }
        lastTime = (cooldowns[cd] + birthLastTime);
        if(lastTime > now) {
            // I can not give birth, it remains until delivery
            lefttime = lastTime.sub(now);
        }
    }
     function getMotherCount(uint32 _mother) public view returns(uint) { //internal
        return TokenBunny.getMotherCount(_mother);
    }
     function getTotalSalaryBunny(uint32 _bunny) public view returns(uint) { //internal
        return TokenBunny.getTotalSalaryBunny(_bunny);
    }
    function getRabbitMother( uint32 mother) public view returns(uint32[5]) {
        return TokenBunny.getRabbitMother(mother);
    }
     function getRabbitMotherSumm(uint32 mother) public view returns(uint count) { //internal
        uint32[5] memory rabbitMother = TokenBunny.getRabbitMother(mother);
        for (uint m = 0; m < 5 ; m++) {
            if(rabbitMother[m] != 0 ) { 
                count++;
            }
        }
    }
    function getRabbitDNK(uint32 bunnyid) public view returns(uint) { 
        return TokenBunny.getDNK(bunnyid);
    }
    function isUIntPublic() public view returns(bool) {
        require(isPauseSave());
        return true;
    }
}