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

var GasCost = 4700000;
var gasPrice_value = 10000000000; 
var bigPrice    = 100000000000000;
                  
var priceBunny = 1;
var SireBunnyID = 6;
var MotherBunnyID = 5;
var newBunnyID = 15;
var priceChildren = 2;
 
let private_accounts =  ["7df9a875a174b3bc565e6424a0050ebc1b2d1d82","f41c74c9ae680c1aa78f42e5647a62f353b7bdde"];


 
// use the given Provider, e.g in Mist, or instantiate a new websocket provider
var web3 = new Web3(Web3.givenProvider || 'http://127.0.0.1:8545');
// or
//var web3 = new Web3(Web3.givenProvider || new Web3.providers.WebsocketProvider('http://127.0.0.1:8545'));




contract('Основной публичный контракт: ', ( accounts) => {

  let giffes = accounts[1];

  var oldBalance =[];

  // получаем балансы пользователей
 // return web3.eth.getBalance(accounts[0]) .then( (result ) => {
function callback(){}

     //oldBalance[0] = web3.eth.getBalance.call(accounts[0], 'latest', callback);

   //  oldBalance[1] = web3.eth.getBalance.call(accounts[1], 'latest', callback);
 

 // });
  // получаем балансы пользователей
 //   return web3.eth.getBalance(accounts[1]) .then( (result ) => {
  //   return  oldBalance[1] = result;
 // });


  var ItterTest = 1;
  var meta;


  // ItterTest++;
  // it(ItterTest + ") Получаем баланс пользователей" , function() { 
    
  //   return web3.eth.getBalance(accounts[0]) .then( (result0 ) => {
  //         oldBalance[0] =result0;  
  //        return web3.eth.getBalance(accounts[1]);
  //   }).then( (result1 ) => {
  //      //100000000000000000000
  //       oldBalance[1] =result1; 
  //    // assert.equal(oldBalance[0] , 0, ' Баланс : ' +  oldBalance[0]); 
  //   //  assert.equal(result1 , 0, ' Баланс : ' + result1); 
  //   });
  // }); 

  
// transferOwnerMoney( address _ownerMoney)

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

//getOwnerMoney()
 ItterTest++;
  it(ItterTest + ") Устанавливаем кошелёк для приёма общих средств по контракту "+accounts[5], function() {
    return meta.transferOwnerMoney(accounts[5], {from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value}).then(function(instance) {
        return web3.eth.getBalance(accounts[5]) 
     }).then( (result5 ) => {
        oldBalance[5] =result5;  
         return meta.getOwnerMoney(accounts[5]);
      }).then( (result ) => {
      
      assert.equal(result , 0, ' Загружаем контракт : ' + result); 
    });
  });


 
  ItterTest++;
  it(ItterTest + ") Создаём 13 кроликов"  , function() {
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
        return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value}).then(function(instance) {
      return meta.totalSupply.call();
    }).then( () => {
       assert.isTrue(true); 
    })
  }); 

  ItterTest++;
  it(ItterTest + ") Добавляем 14 кролика " , function() {
    meta.setMarket( 10, 1,{from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value}).then(function(instance) {
      return meta.totalSupply.call();
    }).then( (result ) => {
       assert.equal(result , 14 , ' Кролик не соответствует : ' + result +' address '+meta.address); 
    })
  }); 

 
  ItterTest++;
  it(ItterTest + ") Дарим 2,3,8,9,10 кролика", function() {


    meta.giff(2, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(8, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(9, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(10, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );

    return meta.giff(3, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {

    return meta.ownerOf.call(3);
    }).then( (result ) => {
        assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
    })
}); 
 
 

 

   var cost = 100000000000000;


   ItterTest++;
  it(ItterTest + ") Узнаём текущую стоимость кролика #10 ", () =>  { 
       
      return meta.currentPrice(10, {from: accounts[0]}).then( (result ) => {
        assert.equal(result , 100000000000000, 'Кролик стоит не ту щену которую устанавливали иначально '+result ); 
     })
   }); 


 
   ItterTest++;
   it(ItterTest + ") Покупаем кролика #10 ", () =>  { 
   return meta.buyBunny(10, {from: accounts[0], gas:GasCost, gasPrice:  gasPrice_value, value:cost}).then( (result ) => {
   return meta.ownerOf.call(10) ;
  }).then( (result ) => {
     assert.equal(result , accounts[0], ' 2Кролик не принадлежит купившему'+result ); 
  })
}); 
 

ItterTest++;
it(ItterTest + ") Получаем баланс пользователей после продажи кролика" , function() { 
  // 100000000000000000000
  // 100000000000000
  return web3.eth.getBalance(giffes) .then( (result ) => {
     assert.equal(result , 0, ' Баланс пользователя : ' + result);  
  }) 
}); 


ItterTest++;
it(ItterTest + ") Устанавливаем стоимость для кролика ("+SireBunnyID +") в размере "+priceChildren, function() {
   return meta.setRabbitSirePrice(SireBunnyID, priceChildren,  {from: accounts[0], gas : GasCost, gasPrice : gasPrice_value}).then(function(result) {  
    assert.isTrue(true); 
  })
}); 

 
 
    ItterTest++;
    it(ItterTest + ") Воспроизводим своего ребёнка смешивая гены с "+MotherBunnyID + ' и ' + SireBunnyID +' кроликами', function() {
        // сколько денег надо для нового кролика?
        // Для нового кролика надо + 25%   
        newprice = priceChildren*bigPrice+(priceChildren*bigPrice/4);
        return  meta.createChildren(MotherBunnyID, SireBunnyID, {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value, value:newprice}).then(function() {
          return meta.ownerOf.call(newBunnyID);
        }).then( (result ) => {
        assert.equal(result ,accounts[0], 'Ошибка проверки соответствия нового кролика и аккаунта : ' + result ); 
    })
  }); 

  ItterTest++;
  it(ItterTest + ") Проверяем сколько раз был оплодотворён кролик ("+MotherBunnyID+")", function() {
        return  meta.getcoolduwn(MotherBunnyID).then(function(result) {
          // 1,2,3,4,5,6,7,8,9,14,11,12: result[0] 
            assert.equal(result[1] ,1 , 'Ошибка количества оплодотворения '+result[1]  ); 
            assert.equal(result[2] ,120 , 'Ошибка количества оплодотворения '+result[2]  ); 
      })
    }); 
 
    ItterTest++;
    it(ItterTest + ") Пытаемся ещё раз родить, но с ошибкой  Кролики: "+MotherBunnyID + ' и ' + SireBunnyID , function() {
        // сколько денег надо для нового кролика?
        // Для нового кролика надо + 25%   
    //    newprice = priceChildren*bigPrice+(priceChildren*bigPrice/4);
    expectRevert(meta.createChildren(MotherBunnyID, SireBunnyID, {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value, value:newprice})); 
    //})
  }); 

  ItterTest++;
  it(ItterTest + ") Выставляем на продажу кролика("+newBunnyID+") и получаем стоимость сверяя её с " + (priceChildren*bigPrice), function() {
             return meta.setMarket(newBunnyID, priceChildren , {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
              return meta.currentPrice.call(newBunnyID);
            }).then( (result ) => {
               assert.equal(result ,(priceChildren*bigPrice) , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
        })
    }); 
 
    ItterTest++;
    it(ItterTest + ") Снимаем с продажи нашего кролика ("+newBunnyID+")"  , function() {
      return meta.stopMarket(newBunnyID, {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
          return meta.currentPrice.call(newBunnyID);
        }).then( (result ) => {
          assert.equal(result , 0 , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
      })
    }); 

    ItterTest++;
    it(ItterTest + ") Подарим нового кролика("+newBunnyID+") пользователю: " + giffes, function() {
      return meta.giff(newBunnyID, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
      return meta.ownerOf.call(newBunnyID);
      }).then( (result ) => {
         assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
      })
    }); 


    ItterTest++;
  it(ItterTest + ") Проверяем первую страницу с продажами кроликами, должен вернутся список из кроликов (1,2,3,4,5,6,7,8,9,14,11,12) ", function() {
        return  meta.getBids(1).then(function(result) {
            assert.equal(result[0][1] ,2 , 'Ошибка проверки соответствия кролика '  ); 
            assert.equal(result[0][2] ,3 , 'Ошибка проверки соответствия кролика '  ); 
      })
    }); 
  
    ItterTest++;
    it(ItterTest + ") Проверка на ошибку. Можно ли установить стоимость кролику который нам не принадлежит. Если хорошо, то нельзя"+ priceBunny, function() { 
        expectRevert(meta.setMarket(2, priceBunny , {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}));
      }); 

      ItterTest++;
      it(ItterTest + ") Проверка на ошибку.Покупаем кролика который не продаётся . Если хорошо, то нельзя", function() { 
        expectRevert(meta.buyBunny(10, {from: accounts[0], gas:GasCost, gasPrice:  gasPrice_value, value:cost})); 
      }); 

    
      var description = 'Мой первый любимый и самый лучший кролик на свете';
      ItterTest++;
      it(ItterTest + ") Дадим описание кролику: "+description, function() { 
        return meta.setDescriptionRabbit(1, description, {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
          return meta.getDescriptionRabbit.call(1);
          }).then( (result ) => {
             assert.equal(result , description, 'Описание кролика : ' + result); 
          })
      }); 
    
      var bunnyName = 'Первый кроль';
      ItterTest++;
      it(ItterTest + ") Назовём нашего кролика: "+bunnyName, function() { 
        return meta.setNameRabbit(1, bunnyName, {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
          return meta.getNameRabbit.call(1);
          }).then( (result ) => {
            return meta.getNameRabbit.call(1);
            }).then( (result ) => {
             assert.equal(result ,bunnyName, 'Название кролика не соответствует заданному'); 
          })
      }); 

    




      // setDescriptionRabbit(uint32 rabbitid, string description) 
      //setNameRabbit(uint32 rabbitid, string name)      

});