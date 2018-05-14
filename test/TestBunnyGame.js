// import {assertRevert} from './assertRevert.js';
//const expectRevert = require('./assertRevert');
// https://github.com/trufflesuite/truffle/issues/498
// https://rinkeby.etherscan.io/address/0x4a174BaF2E41f5B8A68fc79139C054a541402c79
//  geth --rinkeby --rpc --rpcapi db,eth,net,web3,personal --unlock 0  --light  console  --cache=1024 --maxpeers 128


// /home/koras/contracts/publicRabbit/priv
//const Priv_contract = artifacts.require("/home/koras/contracts/publicRabbit/priv/Migrations.sol");
const MetaCoin = artifacts.require("./BunnyGame.sol");

 


var GasCost = 3300000;
var gasPrice_value = 10000000000; 
var bigPrice    = 100000000000000;
                  
var priceBunny = 1;
var SireBunnyID = 6;
var MotherBunnyID = 5;
var newBunnyID = 15;
var priceChildren = 1;

let giffes = '0xeddb036a52a6d2c375e501be7c8c8cd45d07e796';
let private_accounts =  ["7df9a875a174b3bc565e6424a0050ebc1b2d1d82","f41c74c9ae680c1aa78f42e5647a62f353b7bdde"];

contract('Основной публичный контракт: ', ( accounts) => {

  var meta;
  it("Загружаем контракт "+accounts[0], function() {
    return MetaCoin.deployed().then(function(instance) {
              meta = instance;
        return meta.totalSupply.call();
    }).then( (result ) => {
     // assert.equal(result , 0, ' Загружаем контракт : ' + result); 
  //  }).then(function(result) {

 // });
 var rabbit = 0

 rabbit++;
//  it("Создаём "+rabbit+" кроликов"  ,   function() { 
    return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
  // }).then(function(result) {
  //     rabbit++;
  //     return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
  //   }).then(function(result) {
  //     rabbit++;
  //     return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
  //   }).then(function(result) {
  //     rabbit++;
  //     return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
  //   }).then(function(result) {
  //     rabbit++;
  //     return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
  //   }).then(function(result) {
  //     rabbit++;
  //     return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      return   meta.totalSupply.call()
    }).then(function(result) {
   //   assert.equal(result , rabbit, ' Кролик не соответствует : ' + result ); 
      assert.equal(result , 16, ' Кролик не соответствует : ' + result ); 
    })
  });  

/* 
 
  rabbit++;
  it("Создаём "+rabbit+" кроликов"  , async   function() { 
    return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value}).then(function(instance) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      return   meta.totalSupply.call()
    }).then(function(result) {
   //   assert.equal(result , rabbit, ' Кролик не соответствует : ' + result ); 
      assert.equal(result , 12, ' Кролик не соответствует : ' + result ); 
    })
  });  
  rabbit++;
  it("Создаём "+rabbit+" кроликов 1"  , async  function() { 
    return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value}).then(function(instance) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      rabbit++;
      return   meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
    }).then(function(result) {
      return   meta.totalSupply.call()
    }).then(function(result) {
   //   assert.equal(result , rabbit, ' Кролик не соответствует : ' + result ); 
      assert.equal(result , 18, ' Кролик не соответствует : ' + result ); 
    })
  });  

 





  it("Дарим 2,3,8,9,10 кролика", function() {
 

     return meta.giff(2, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
      return meta.giff(3, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
  }).then(function(result) {

      return meta.giff(8, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
  }).then(function(result) {
      return meta.giff(9, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
  }).then(function(result) {
    return meta.giff(10, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value} );
  }).then(function(result) {
     return meta.ownerOf.call(10);
    }).then( (result ) => {
   //     assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
        assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
  })
}); 

 
   
 

   var cost = 100000000000000;
    it("Покупаем кролика #10 ",  function() {
      return  meta.buyBunny(3, {from: accounts[0], gas:GasCost, gasPrice:  gasPrice_value, value: cost }).then( (result3 ) => {
         return meta.ownerOf.call(3);
      }).then( (result2 ) => {
        assert.equal(result2 , accounts[0], ' Кролик не принадлежит купившему'); 
      })
    }); 


 
 

it("Устанавливаем стоимость для SIRE 1 ("+SireBunnyID +") в размере ", function() {
   meta.setRabbitSirePrice(SireBunnyID, priceChildren,  {from: accounts[0], gas : GasCost, gasPrice : gasPrice_value}).then(function(result) {  
    assert.isTrue(result); 
  })
}); 


// 0x5aeda56215b167893e80b4fe645ba6d5bab767de
  it("Устанавливаем стоимость для SIRE 2 ("+SireBunnyID +") в размере "+ priceChildren, function() {
        meta.setRabbitSirePrice(SireBunnyID, priceChildren, {from: accounts[0], gas:GasCost, gasPrice:gasPrice_value})
      .then(function(instance) {  
       //  assert.isTrue(instance,instance); 
         assert.equal(instance , true, ' Кролик не соответствует : ' + instance  ); 
      })
    }); 



    // 0x5aeda56215b167893e80b4fe645ba6d5bab767de
    it("Воспроизводим своего ребёнка смешивая гены с "+MotherBunnyID + ' и ' + SireBunnyID +' кроликами', function() {
            // сколько денег надо для нового кролика?
            // Для нового кролика надо + 25%   
            newprice = priceChildren*bigPrice+(priceChildren*bigPrice/4);
              meta.createChildren(MotherBunnyID, SireBunnyID, {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value, value:newprice}).then(function() {
              return meta.ownerOf.call(newBunnyID);
            }).then( (result ) => {
             assert.equal(result ,accounts[0], 'Ошибка проверки соответствия нового кролика и аккаунта : ' + result ); 
        })
    }); 


    // 0x5aeda56215b167893e80b4fe645ba6d5bab767de
    it("Выставляем на продажу кролика("+newBunnyID+") и получаем стоимость сверяя её с " + (priceChildren*bigPrice), function() {
             meta.setMarket(newBunnyID, priceChildren , {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
              return meta.currentPrice.call(newBunnyID);
            }).then( (result ) => {
               assert.equal(result ,priceChildren*bigPrice , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
        })
    }); 


    // 0x5aeda56215b167893e80b4fe645ba6d5bab767de
    it("Снимаем с продажи нашего кролика ("+newBunnyID+")"  , function() {
         meta.stopMarket(newBunnyID, {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
          return meta.currentPrice.call(newBunnyID);
        }).then( (result ) => {
          assert.equal(result , 0 , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
      })
    }); 


    it("Подарим нового кролика("+newBunnyID+") пользователю: " + giffes, function() {
        meta.giff(newBunnyID, giffes , {from: accounts[0], gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
      return meta.ownerOf.call(newBunnyID);
      }).then( (result ) => {
         assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
      })
  }); 


    // 0x5aeda56215b167893e80b4fe645ba6d5bab767de
    it("Проверяем страницу с продажными кроликами ", function() {

     return  meta.getBids(1).then(function(result) {
     // }).then( (result ) => {
        
         assert.equal(result ,222 , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
  })
}); 

   
it("Проверка на ошибку. Можно ли установить стоимость кролику который нам не принадлежит  "+ priceBunny, function() { 
 // expectRevert(meta.setMarket(2, priceBunny , {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value}));
 
}); 

   
      it("Покупаем кролика которого подарили и который не продаётся", function() {
        // Дарим третьего пролика
        return meta.buyBunny(newBunnyID,  {from: accounts[0], gas:GasCost,gasPrice:  gasPrice_value, value:cost}).then(function(error,instance) {
          console.log(error);
          
        })
      }); 

*/
});