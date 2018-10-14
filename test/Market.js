
// http://www.chaijs.com/api/assert/
 return; 

// kill
// fuser -k 8545/tcp
// fuser -k 3000/tcp
// import {assertRevert} from './assertRevert.js';
const expectRevert = require('./assertRevert');
var Web3 = require('web3');
//const web3 = require('web3');
// https://github.com/trufflesuite/truffle/issues/498
// https://rinkeby.etherscan.io/address/0x4a174BaF2E41f5B8A68fc79139C054a541402c79
//  geth --rinkeby --rpc --rpcapi db,eth,net,web3,personal --unlock 0  --light  console  --cache=1024 --maxpeers 128


// /home/koras/contracts/publicRabbit/priv
//const Priv_contract = artifacts.require("/home/koras/contracts/publicRabbit/priv/Migrations.sol");
const MetaCoin = artifacts.require("./BunnyGame.sol");

var GasCost = 470000;
var gasPrice_value = 200000000000; 
var bigPrice    = 100000000000000;

var costRabbit = 12000000000000000;

var priceBunny = 1;
var SireBunnyID = 6;
var MotherBunnyID = 5;
var newBunnyID = 8;
var arrayBunnyPrice = [];

//var priceChildren = 2;
var priceChildren = 12000000000000000;

var ownerMoney;

let private_accounts =  ["7df9a875a174b3bc565e6424a0050ebc1b2d1d82","f41c74c9ae680c1aa78f42e5647a62f353b7bdde"];

 
// use the given Provider, e.g in Mist, or instantiate a new websocket provider
var web3 = new Web3(Web3.givenProvider || 'http://127.0.0.1:8545');
// or
//var web3 = new Web3(Web3.givenProvider || new Web3.providers.WebsocketProvider('http://127.0.0.1:8545'));


 

contract('Основной функционал контракта', ( accounts) => {

  let giffes = accounts[1];
  var oldBalance =[];
  var bunnySire =[20,21,23,25,26,27 ,28,30,16,17,18,19,31,32,33,34];
  var bunnySirePrice =[
                      120000000000000000,
                      52000000000000000,
                      27000000000000000,
                      72000000000000000,
                      66000000000000000,
                      37000000000000000,
                      37000000000000000,
                      28000000000000000,
                      30000000000000000,
                      52000000000000000,
                      27000000000000000,
                      72000000000000000,
                      66000000000000000,
                      37000000000000000,
                      37000000000000000,
                      28000000000000000,
                      30000000000000000,
                      52000000000000000,
                      27000000000000000,
                      72000000000000000,
                      66000000000000000,
                      37000000000000000,
                      37000000000000000,
                      28000000000000000,
                      30000000000000000
                    ];
  var bunnySireItter = 0; 
  var ItterTest = 0;
  var meta; 
  ownerMoney = accounts[5];

  function Gennezise() {
      meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
  }

  ItterTest++;
  it(ItterTest + ") Загружаем контракт "+accounts[0], function() {
    return MetaCoin.deployed().then(function(instance) {
              meta = instance; 
        return web3.eth.getBalance(accounts[0]) 
     }).then( (result0 ) => {
        oldBalance[0] =result0;  
         return web3.eth.getBalance(accounts[1]);
    }).then( (result1 ) => {
      oldBalance[1] =result1; 
      return meta.totalSupply.call();
    }).then( (result ) => {
      assert.equal(result , 0, ' Загружаем контракт : ' + result); 
    });
  });


  

 ItterTest++;
 it(ItterTest + ") Проверка доступности приватного контракта :", function() {
       return  meta.isPriv().then(function(result) { 
           assert.equal(result  ,true , 'Ошибка  '+result   );  
     })
   }); 
    
 
  ItterTest++;
  it(ItterTest + ") Создаём кроликов"  , function() {
        for(let i=0;i<12;i++){
            Gennezise();
        }
        return   meta.createGennezise({from: accounts[0], gas:  GasCost, gasPrice:gasPrice_value }).then(function(error,result) {
            return meta.totalSupply.call();
        }).then( (result) => {
       assert.equal(result  ,13 , 'Ошибка Добавления кроликов '+result  );  
  })
  }); 
  
 
ItterTest++;
it(ItterTest + ")  getTokenOwner :", function() {
      return  meta.getTokenOwner(accounts[0]).then(function(result) { 
          assert.equal(result[0]  ,13 , 'Ошибка проверки второй страницы с getTokenOwner '+result  );  
    })
  }); 
 
  


 
  ItterTest++;
  it(ItterTest + ") 2 Выставляем на продажу кролика(16,12) и получаем стоимость сверяя её с " + (priceChildren), function() {
        meta.startMarket( 2, (costRabbit),{from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 3, (costRabbit*18),{from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 4, (costRabbit*354),{from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 5, (costRabbit*354),{from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 7, (costRabbit*826),{from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 8, (costRabbit*201), {from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 11, (costRabbit*201), {from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 12, (costRabbit*201), {from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.startMarket( 10, (costRabbit), {from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        return meta.startMarket(9, priceChildren , {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
                return meta.currentPrice.call(16);
              }).then( (result ) => {
               assert.equal(result ,(priceChildren) , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
        })
    }); 

  ItterTest++;
  it(ItterTest + ") Дарим 2,3,8,9,10,16 кролика", function() {
    meta.giff(2, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
 //   meta.giff(8, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(3, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(4, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(5, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
    
    return meta.giff(8, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
    return meta.ownerOf.call(8);
    }).then( (result ) => {
        assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
    })
}); 
 

 
 

   ItterTest++;
  it(ItterTest + ") Узнаём текущую стоимость кролика #10 ", () =>  { 
      return meta.currentPrice(10, {from: accounts[0]}).then( (result ) => {
        assert.equal(result , costRabbit,  'Кролик стоит не ту щену которую устанавливали иначально '+result ); 
     })
   }); 
 


   ItterTest++;
   it(ItterTest + ") Покупаем кролика #10 ", () =>  { 
    return meta.buyBunny(2, {from: accounts[0], gas:GasCost, gasPrice:  gasPrice_value, value:costRabbit}).then( (result ) => {
    return meta.ownerOf.call(2) ;
    }).then( (result ) => {
      assert.equal(result , accounts[0], ' 2Кролик не принадлежит купившему'+result ); 
    })
  }); 
  

  

 


  
 
 ItterTest++;
 it(ItterTest + ") Проверка на ошибку: Покупаем кролика который принадлежит мне #35 ", () =>  { 
  expectRevert(meta.buyBunny(20, {from: accounts[0], gas:GasCost, gasPrice:  gasPrice_value, value:costRabbit}));
}); 




// ItterTest++;
// it(ItterTest + ") Получаем баланс пользователей после продажи кролика" , function() { 
//   // 100000000000000000000
//   // 100000000000000
//   // 100000000000000000000
//   // 100000000000000000000
//   return web3.eth.getBalance(giffes) .then( (result ) => {
//     var additionBalance  = result - oldBalance[1];
//     var plusBalance = costRabbit/100*95;
//     assert.isAbove(result, oldBalance[1], 'Баланс пользователя ');
//   //   assert.equal(result , 0, ' Баланс пользователя : ' + additionBalance +' plusBalance '+plusBalance );  
//   }) 
// }); 



 
 
    

  // ItterTest++;
  // it(ItterTest + ") 1 Выставляем на продажу кролика("+newBunnyID+") и получаем стоимость сверяя её с " + (priceChildren), function() {
  //            return meta.startMarket(newBunnyID, priceChildren , {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
  //             return meta.currentPrice.call(newBunnyID);
  //           }).then( (result ) => {
  //              assert.equal(result ,(priceChildren) , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
  //       })
  //   }); 
 
    ItterTest++;
    it(ItterTest + ") Снимаем с продажи нашего кролика (11)"  , function() {
      return meta.stopMarket(11, {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
          return meta.currentPrice.call(11);
        }).then( (result ) => {
          assert.equal(result , 0 , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
      })
    }); 
 


    ItterTest++;
    it(ItterTest + ") Снимаем с продажи нашего кролика (12)"  , function() {
      return meta.stopMarket(12, {from: accounts[0]}).then(function() {
          return meta.currentPrice.call(12);
        }).then( (result ) => {
          assert.equal(result , 0 , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
      })
    }); 

  
});