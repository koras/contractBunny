pragma solidity ^0.4.23;

import "./BunnyGame.sol";

/**
* 
*/

contract BunnyPages is BunnyGame {
    function getTokenList(uint page, address owner) public view returns(
                uint32[12] bunnys, 
                uint[12] bunnyBreed, 
                uint[12] bunnyRole, 
                uint[12] bunnyMarketPrice,
                uint[12] sirePrices, 
                uint elementEnd,
                uint elementTotal,
                uint startArray
                ) {

                uint32 _bunnyID = 0;
                //uint pagecount = 12;
                uint start = 0;

                if (page < 1) {
                    page = 1;
                }
                
                elementTotal = ownerBunnies[owner].length;
                elementEnd = page.mul(12);

                if (elementEnd > elementTotal) {
                    elementEnd = elementTotal;
                }
 
                startArray = (((page-1)*12)+1);

                if(ownerBunnies[owner].length == 0) {
                    return;
                }
                for (uint i = startArray; i < (elementEnd+1); ++i) {

                    _bunnyID = ownerBunnies[owner][(i-1)];

                    if(_bunnyID != 0) {  
                        bunnys[start] = _bunnyID; 
                        bunnyBreed[start] = rabbits[(_bunnyID-1)].genome; 
                        bunnyRole[start] = rabbits[(_bunnyID-1)].role;
                        sirePrices[start] = getSirePrice(_bunnyID); 
                        bunnyMarketPrice[start] = currentPrice(_bunnyID);
     
                    }
                    start++;
                }

    }

    // uint32[12] rabbitID, 
    //             address[12]rabbitSeller, 
    //             uint[12]role, 
    //             uint[12]currentPriceBids,
    //          //   uint[12]bunnyBreed,
    //             uint elementEnd,
    //             uint elementTotal

    // https://ethereum.stackexchange.com/questions/1527/how-to-delete-an-element-at-a-certain-index-in-an-array
    function getBids(uint page) 
            public view returns(
                uint32[12] rabbitID, 
                uint[12]genome,
                uint[12]role, 
                address[12]rabbitSeller,  
                uint[12]currentPriceBids, 
                uint[12]rabbitMotherCounts,
                uint elementEnd,
                uint elementTotal
                ) {

              //  uint32 bunnyID = 0;
              //  uint pagecount = 12;
                uint start = 0;

                if (page < 1) {
                    page = 1;
                }
                
                elementEnd = page.mul(12);

                if (elementEnd > (marketCount-1)) {
                    elementEnd = (marketCount-1);
                }

                elementTotal = (marketCount-1);

              //  uint startArray = (((page-1)*12)+1);
                for (uint i = (((page-1)*12)+1); i < (elementEnd+1); i++) {
                    
                  //  bunnyID = uint32(bidsArray[i].rabbitID);
                    rabbitID[start] = uint32(bidsArray[i].rabbitID);
                    rabbitSeller[start] = rabbitToOwner[uint32(bidsArray[i].rabbitID)]; 
                    
                    role[start] = rabbits[(uint32(bidsArray[i].rabbitID)-1)].role;
                    
                    genome[start] = rabbits[(uint32(bidsArray[i].rabbitID)-1)].genome; 
                    
                 //   bunnyBreed[start] = rabbits[(bunnyID-1)].birthblock;
                    // totalSalaryBunnys[start] = totalSalaryBunny[(uint32(bidsArray[i].rabbitID))];
                    rabbitMotherCounts[start] = rabbitMotherCount[(uint32(bidsArray[i].rabbitID))];

                    currentPriceBids[start] = currentPrice(uint32(bidsArray[i].rabbitID));
                    start++;
                }
            }

            
    function getSireList(uint page, uint indexBunny) 
            public view returns(
                uint32[12] rabbitID, 
            //    address[12]rabbitSeller, 
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

                if (sireGenom[indexBunny].length == 0) {
                    return;
                }

                elementEnd = page.mul(pagecount);

                if (elementEnd > sireGenom[indexBunny].length) {
                    elementEnd = sireGenom[indexBunny].length;
                }

                elementTotal = sireGenom[indexBunny].length;
          

                for (uint i = (((page-1)*pagecount)); i < (elementEnd); i++) {

                   bunnyID = uint32(sireGenom[indexBunny][i]);
                    rabbitID[start] = bunnyID;
                  //  rabbitSeller[start] = rabbitToOwner[bunnyID]; 
                    currentPriceBids[start] = getSirePrice(bunnyID);
                    start++;
                }
            }

}
