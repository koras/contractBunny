pragma solidity ^0.4.23;
 
import "./BaseRabbit.sol"; 


/// @title Interface for contracts conforming to ERC-721: Non-Fungible Tokens
/// @author Dieter Shirley <dete@axiomzen.co> (https://github.com/dete)
contract ERC721 {
    // Required methods 
 

    function ownerOf(uint32 _tokenId) public view returns (address owner);
    function approve(address _to, uint32 _tokenId) external;
    function transfer(address _to, uint32 _tokenId) internal;
    function transferFrom(address _from, address _to, uint32 _tokenId) internal;
    function totalSupply() public view returns (uint32 total);
    function balanceOf(address _owner) public view returns (uint balance);

    // Events
    event Transfer(address from, address to, uint32 tokenId);
    event Approval(address owner, address approved, uint32 tokenId);
}

/// @title Interface new rabbits address
contract PrivateRabbitInterface {
    function getNewRabbit()  public view returns (uint);
    function mixDNK(uint dnkmother, uint dnksire)  public view returns (uint);
    function isUIntPrivate() public pure returns (bool);
    
  //  function mixGenesRabbits(uint256 genes1, uint256 genes2, uint256 targetBlock) public returns (uint256);
}




contract BodyRabbit is BaseRabbit, ERC721 {
     
    uint32 public totalBunny = 0;
    string public constant name = "CryptoRabbits";
    string public constant symbol = "CRB";


    PrivateRabbitInterface privateContract;

    /**
    * @dev setting up a new address for a private contract
    */
    function setPriv(address _privAddress) public returns(bool) {
        privAddress = _privAddress;
        privateContract = PrivateRabbitInterface(_privAddress);
    } 
    bool public fcontr = false;

    address public  myAddr_test = 0xde1Ab40a02a65531802Dad2146eBa04654Eb58a8;
    
    constructor() public { 
        setPriv(myAddr_test);
        fcontr = true;
    }

    function isPriv() public view returns(bool) {
        return privateContract.isUIntPrivate();
    }

    modifier checkPrivate() {
        require(isPriv());
        _;
    }

       
 
    function ownerOf(uint32 _tokenId) public view returns (address owner) {
        return rabbitToOwner[_tokenId];
    }




    function approve(address _to, uint32 _tokenId) external { 
        _to;
        _tokenId;
    }


     
    function removeTokenList(address _owner, uint32 _tokenId) internal { 
        uint count = ownerBunnies[_owner].length;
        for (uint256 i = 0; i < count; i++) {
            if(ownerBunnies[_owner][i] == _tokenId)
            { 
                delete ownerBunnies[_owner][i];
                if(count > 0 && count != (i-1)){
                    ownerBunnies[_owner][i] = ownerBunnies[_owner][(count-1)];
                    delete ownerBunnies[_owner][(count-1)];
                } 
                ownerBunnies[_owner].length--;
                return;
            } 
        }
    }


 

    function getSirePrice(uint32 _tokenId) public view returns(uint) {
        if(rabbits[(_tokenId-1)].role == 1){
            uint procent = (rabbitSirePrice[_tokenId] / 100);
            uint res = procent.mul(25);
            uint system  = procent.mul(commission_system);

            res = res.add(rabbitSirePrice[_tokenId]);
            return res.add(system); 
        } else {
            return 0;
        }
    }

 
    function addTokenList(address owner,  uint32 _tokenId) internal {
        ownerBunnies[owner].push( _tokenId);
        rabbitToOwner[_tokenId] = owner; 
    }
 

    function transfer(address _to, uint32 _tokenId) internal {
        address currentOwner = msg.sender;
        address oldOwner = rabbitToOwner[_tokenId];
        require(rabbitToOwner[_tokenId] == msg.sender);
        require(currentOwner != _to);
        require(_to != address(0));
        removeTokenList(oldOwner, _tokenId);
        addTokenList(_to, _tokenId);
        emit Transfer(oldOwner, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint32 _tokenId) internal {
        address oldOwner = rabbitToOwner[_tokenId];
        require(oldOwner == _from);
        require(oldOwner != _to);
        require(_to != address(0));
        removeTokenList(oldOwner, _tokenId);
        addTokenList(_to, _tokenId); 
        emit Transfer (oldOwner, _to, _tokenId);
    }  
    
    function setTimeRangeGen0(uint _sec) public onlyTech {
        timeRangeCreateGen0 = _sec;
    }


    function isPauseSave() public view returns(bool) {
        return !pauseSave;
    }
    function isPromoPause() public view returns(bool) {
        if(msg.sender == ownerServer || msg.sender == ownerCEO){
            return true;
        }else{
            return !promoPause;
        } 
    }

    function setPauseSave() public onlyOwner  returns(bool) {
        return pauseSave = !pauseSave;
    }

    /**
    * for check
    *
    */
    function isUIntPublic() public pure returns(bool) {
        return true;
    }


    function getTokenOwner(address owner) public view returns(uint total, uint32[] list) {
        total = ownerBunnies[owner].length;
        list = ownerBunnies[owner];
    } 

    function setRabbitMother(uint32 children, uint32 mother) internal returns( uint start ){ 
        uint32[11] memory ar;
       // uint start = 0;
        for (uint i = 0; i < 10; i++) {
            if (rabbitMother[mother][i] != 0) {
              ar[start] = uint32(rabbitMother[mother][i]);
              rabbitMother[mother][i] = 0;
              start++;
            } 
        }
        ar[start] = children;
        start++;
        for (uint m = 0; m < 10; m++) {
             if(start >  10){
                    rabbitMother[mother][m] = ar[(m+1)];
             }else{
                    rabbitMother[mother][m] = ar[m];
             }
        }
        rabbitMotherCount[mother].add(1);
    }




    function getRabbitMother( uint32 mother) public view returns(uint32[10]){
        return rabbitMother[mother];
    }

     function getRabbitMotherCount(uint32 mother) public view returns(uint count) { //internal
        for (uint m = 0; m < 10 ; m++) {
            if(rabbitMother[mother][m] != 0 ) { 
                count++;
            }
        }
    }



    function getRabbitDNK(uint32 bunnyid) public view returns(uint) { 
        return mapDNK[bunnyid];
    }
     
    function bytes32ToString(bytes32 x)internal pure returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
    
    function uintToBytes(uint v) internal pure returns (bytes32 ret) {
        if (v == 0) {
            ret = '0';
        } else {
        while (v > 0) {
                ret = bytes32(uint(ret) / (2 ** 8));
                ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
                v /= 10;
            }
        }
        return ret;
    }

    function totalSupply() public view returns (uint32 total) {
        return totalBunny;
    }

    function balanceOf(address _owner) public view returns (uint) {
      //  _owner;
        return ownerBunnies[_owner].length;
    }

    function sendMoney(address _to, uint256 _money) internal { 
        _to.transfer((_money/100)*95);
        ownerMoney.transfer((_money/100)*5); 
    }

    function getGiffBlock(uint32 _bunnyid) public view returns(bool) { 
        return !giffblock[_bunnyid];
    }

    function getOwnerGennezise(address _to) public view returns(bool) { 
        return ownerGennezise[_to];
    }
    

    function getBunny(uint32 _bunny) public view returns(
        uint32 mother,
        uint32 sire,
        uint birthblock,
        uint birthCount,
        uint birthLastTime,
        uint role, 
        uint genome,
        bool interbreed,
        uint leftTime,
        uint lastTime,
        uint price
        )
        {
            price = getSirePrice(_bunny);
            _bunny = _bunny - 1;

            mother = rabbits[_bunny].mother;
            sire = rabbits[_bunny].sire;
            birthblock = rabbits[_bunny].birthblock;
            birthCount = rabbits[_bunny].birthCount;
            birthLastTime = rabbits[_bunny].birthLastTime;
            role = rabbits[_bunny].role;
            genome = rabbits[_bunny].genome;
                     
            if(birthCount > 14) {
                birthCount = 14;
            }
            lastTime = uint(cooldowns[birthCount]);
            lastTime = lastTime.add(birthLastTime);
            if(lastTime <= now) {
                interbreed = true;
            } else {
                leftTime = lastTime.sub(now);
            }
    }


    function getBreed(uint32 _bunny) public view returns(
        bool interbreed
        )
        {
        _bunny = _bunny - 1;
        if(_bunny == 0) {
            return;
        }
        uint birtTime = rabbits[_bunny].birthLastTime;
        uint birthCount = rabbits[_bunny].birthCount;

        uint  lastTime = uint(cooldowns[birthCount]);
        lastTime = lastTime.add(birtTime);

        if(lastTime <= now && rabbits[_bunny].role == 0 ) {
            interbreed = true;
        } 
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
        if(lastTime > now) {
            // не могу рожать, осталось до родов 
            lefttime = lastTime.sub(now);
        }
    }

}