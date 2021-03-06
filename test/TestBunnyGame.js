//return;

// http://www.chaijs.com/api/assert/
// return; 

// kill
// fuser -k 8545/tcp

// fuser -k 8555/tcp


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

var costRabbit = 1000000000000000;

var priceBunny = 1;
var SireBunnyID = 6;
var MotherBunnyID = 5;
var newBunnyID = 14;
var arrayBunnyPrice = [];

var priceChildren = 12000000000000000;

var comission = 5;
var ownerMoney;
let private_accounts =  ["7df9a875a174b3bc565e6424a0050ebc1b2d1d82","f41c74c9ae680c1aa78f42e5647a62f353b7bdde"];

 
// use the given Provider, e.g in Mist, or instantiate a new websocket provider
var web3 = new Web3(Web3.givenProvider || 'http://127.0.0.1:8545');
// or
//var web3 = new Web3(Web3.givenProvider || new Web3.providers.WebsocketProvider('http://127.0.0.1:8545'));


 

contract('Основной функционал контракта', ( accounts) => {

  let giffes = accounts[4];
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
  ownerCEO = accounts[0];
  ownerMoney = accounts[5];

  function Gennezise(uintData) {
    let bunny = 0;
    if(uintData > 10){ 
      bunny = 1;
   }
      meta.createGennezise(bunny, {from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});
  }

  ItterTest++;
  it(ItterTest + ") Загружаем контракт "+ownerCEO, function() {
    return MetaCoin.deployed().then(function(instance) {
              meta = instance; 
        return web3.eth.getBalance(ownerCEO) 
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
    return meta.transferOwnerMoney(accounts[5], {from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value}).then(function(instance) {
        return web3.eth.getBalance(accounts[5]);
     }).then( (result ) => {
        oldBalance[5] =result;  
       return meta.getOwnerMoney();
      }).then( (result ) => {
      assert.equal(result , accounts[5], 'Ошибка установки кошелька: ' + result+', '+accounts[5]); 
 // return;
    });
  });


 // return;

 ItterTest++;
 it(ItterTest + ") Проверка доступности приватного контракта :", function() {
       return  meta.isPriv().then(function(result) { 
           assert.equal(result  ,true , 'Ошибка  '+result   );  
     })
   }); 
    
 
   

 


 



//    ItterTest++;
//    it(ItterTest + ") Создаём кроликов"  , function() {
        
//            meta.createGennezise(0, {from: ownerCEO, gas:  GasCost, gasPrice: gasPrice_value });
//            meta.createGennezise(0, {from: ownerCEO, gas:  GasCost, gasPrice: gasPrice_value });
//            meta.createGennezise(1, {from: ownerCEO, gas:  GasCost, gasPrice: gasPrice_value });
//            meta.createGennezise(1, {from: ownerCEO, gas:  GasCost, gasPrice: gasPrice_value });
//            meta.createGennezise(1, {from: ownerCEO, gas:  GasCost, gasPrice: gasPrice_value });
//          return   meta.createGennezise(1, {from: ownerCEO, gas:  GasCost, gasPrice: gasPrice_value }).then(function(error,result) {
//           return meta.totalSupply.call();
//          }).then( (result) => {
//         assert.equal(result  ,6 , 'Ошибка Добавления кроликов '+result  );  
//    })
//    }); 

 
   
//    it(ItterTest + ") Check parent "  , function() {
//     return meta.getMotherCount(1).then(function(result) {
//       assert.equal(result, 0, result  ); 
//     })
//  }); 


//  it(ItterTest + ") Check mather "  , function() {
//   return meta.getRabbitMother(3).then(function(result) {
//     assert.equal(result, 100, result  ); 
//   })
// }); 
  
   




// ItterTest++;
// it(ItterTest + ") Создаём кроликов"  , function() {
//       for(let i=0;i<3;i++){
//           Gennezise(i);
//         }

//       return   meta.createGennezise(0, {from: ownerCEO, gas:  GasCost, gasPrice:gasPrice_value }).then(function(error,result) {
//        return meta.totalSupply.call();
//       }).then( (result) => {
//      assert.equal(result  ,53 , 'Ошибка Добавления кроликов '+result  );  
// })
// }); 
 
// ItterTest++;
// it(ItterTest + ") check list "+ ownerCEO, () =>  { 
//  return meta.getTokenList(1, ownerCEO ).then( (result ) => {
//    assert.equal(result , 2, ' '+result ); 
//  })
// }); 
// return;









  ItterTest++;
  it(ItterTest + ") Создаём кроликов"  , function() {
        for(let i=0;i<52;i++){
            Gennezise(i);
          }

        return   meta.createGennezise(0, {from: ownerCEO, gas:  GasCost, gasPrice:gasPrice_value }).then(function(error,result) {
         return meta.totalSupply.call();
        }).then( (result) => {
       assert.equal(result  ,53 , 'Ошибка Добавления кроликов '+result  );  
  })
  }); 
   
 
 




// ItterTest++;
// it(ItterTest + ")  getTokenOwner :", function() {
//       return  meta.getTokenOwner(ownerCEO).then(function(result) { 
//           assert.equal(result[0]  ,53 , 'Ошибка проверки второй страницы с getTokenOwner '+result  );  
//     })
//   }); 
 



 
  ItterTest++;
  it(ItterTest + ") Выставляем на продажу кролика(16,12) и получаем стоимость сверяя её с " + (priceChildren), function() {
    
        meta.startMarket( 10, (costRabbit),{from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});
      //  meta.startMarket( 11, (costRabbit*3),{from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});
     ///   meta.startMarket( 21, (costRabbit*4),{from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});
    ///    meta.startMarket( 8, (costRabbit*5),{from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});
    //    meta.startMarket( 23, (costRabbit*826),{from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});
     //   meta.startMarket( 12, (costRabbit*201), {from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});

        return meta.startMarket(16, priceChildren , {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
                return meta.currentPrice.call(16);
              }).then( (result ) => {

               assert.equal(result ,(priceChildren+(priceChildren/100*comission)) , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
        })
    });  
  // 10 = 53
 
 
   
  ItterTest++;
  it(ItterTest + ") Дарим 2,3,8,9,10,16 кролика", function() {
    meta.giff(2, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value} );
 //   meta.giff(8, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(9, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(12, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(16, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value} );
    meta.giff(10, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value} );
    return meta.giff(3, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
    return meta.ownerOf.call(3);
    }).then( (result ) => {
        
        assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
    })
}); 
 
    
// ItterTest++;
// it(ItterTest + ") Узнаём текущую стоимость кролика #10 ", () =>  { 

//   //meta.startMarket( 10, (costRabbit),{from: ownerCEO, gas:  GasCost ,gasPrice:gasPrice_value});
//     return meta.currentPrices( 1, {from: ownerCEO}).then( (result ) => {

//       assert.equal(result , ((costRabbit+(costRabbit/100)*comission)),  'Кролик стоит не ту щену которую устанавливали иначально costRabbit '+
//       costRabbit+' comission '
//        +comission  + ' result '+result ); 
//    })
//  }); 


     
  
 
 

 


   ItterTest++;
   it(ItterTest + ") Покупаем кролика #10 ", () =>  { 
    return meta.buyBunny(10, {from: ownerCEO, gas:GasCost, gasPrice:  gasPrice_value, value:(12000000000000000)})
    
    .then( (result ) => {
    return meta.ownerOf.call(10) ;
    }).then( (result ) => {
      assert.equal(result , ownerCEO, ' 2Кролик не принадлежит купившему'+result ); 
    })
  }); 
  


  

 
 ItterTest++;
 it(ItterTest + ") Проверка на ошибку: Покупаем кролика который принадлежит мне #35 ", () =>  { 
  expectRevert(meta.buyBunny(20, {from: ownerCEO, gas:GasCost, gasPrice:  gasPrice_value, value:costRabbit}));
}); 


// ItterTest++;
// it(ItterTest + ") Получаем баланс пользователей после продажи кролика" , function() { 
//   // 100000000000000000000
//   // 100000000000000
//   return web3.eth.getBalance(giffes) .then( (result ) => {
//     var additionBalance  = result - oldBalance[1];
//     var plusBalance = costRabbit/100*95;
//     assert.isAbove(result, oldBalance[1], 'Баланс пользователя ');
//   //   assert.equal(result , 0, ' Баланс пользователя : ' + additionBalance +' plusBalance '+plusBalance );  
//   }) 
// }); 


// ItterTest++;
// it(ItterTest + ") Проверяем процент полученный от продажи" , function() { 
//   // 100000000000000000000
//   // 100000000000000
//   return web3.eth.getBalance(ownerMoney) .then( (result ) => {
//     var additionBalance  = result - oldBalance[1];
//     var plusBalance = costRabbit/100*5;
    
//     assert.isAbove((result+10000), oldBalance[5]+plusBalance, 'Баланс пользователя '+result+ ' oldBalance[5] '+oldBalance[5]);
//   //   assert.equal(result , 0, 'Баланс пользователя '+result+ ' oldBalance[5] '+oldBalance[5] +' plusBalance'+plusBalance);
//   }) 
// }); 
 
//var costRabbit = 
// 400000000000000;
// 380000000000000;
        
    ItterTest++;
    it(ItterTest + ") Устанавливаем стоимость для оплодотворения  кролика ("+SireBunnyID +") в размере "+priceChildren, function() {
      return meta.setRabbitSirePrice(SireBunnyID, priceChildren,  {from: ownerCEO, gas : GasCost, gasPrice : gasPrice_value}).then(function(result) {  
        
        
        return meta.getSirePrice.call(SireBunnyID);
        }).then( (result ) => {
 
        assert.equal(result , ( priceChildren +( (priceChildren/100) * comission)+( (priceChildren/100) * 25)), 'Ошибка проверки соответствия нового кролика('+SireBunnyID+') и аккаунта priceChildren : '+priceChildren +' result :' + result ); 
       })
    }); 
    
 
    ItterTest++;
    it(ItterTest + ") Заполняем базу кроликами для оплодоиворения "+bunnySire, function() {
     
     
      return meta.setRabbitSirePrice(bunnySire[bunnySireItter], bunnySirePrice[bunnySireItter],  {from: ownerCEO, gas : GasCost, gasPrice : gasPrice_value})
      
      .then(function() {  
         bunnySireItter++; 
       }).then( () => {
         bunnySireItter++;  
       return meta.setRabbitSirePrice(bunnySire[bunnySireItter], bunnySirePrice[bunnySireItter],  {from: ownerCEO, gas : GasCost, gasPrice : gasPrice_value}) 
       

      assert.isTrue(true);  
     
      })
    });  
    
    


    ItterTest++;
    it(ItterTest + ") Делаем из кролика, крольчицу ("+bunnySire[1]+") в размере "+priceChildren, function() {
      return meta.setSireStop(bunnySire[1], {from: ownerCEO, gas : GasCost, gasPrice : gasPrice_value}).then(function(result) {  
        assert.isTrue(true); 
      })
    }); 
 


    ItterTest++;
    it(ItterTest + ") Воспроизводим своего ребёнка смешивая гены с "+MotherBunnyID + 
    ' и ' + SireBunnyID +' кроликами за '+(priceChildren+(priceChildren/4)+(priceChildren/100*comission)), function() {

      
        // сколько денег надо для нового кролика?
        // Для нового кролика надо + 25%   
        newprice = priceChildren+(priceChildren/4)+((priceChildren/100)*comission);

        return  meta.createChildren(MotherBunnyID, SireBunnyID, {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value, value:newprice}).then(function() {
          return meta.ownerOf.call(newBunnyID);
        }).then( (result ) => {
        assert.equal(result ,ownerCEO, 'Ошибка проверки соответствия нового кролика и аккаунта : ' + result ); 
    })
  }); 




  ItterTest++;
  it(ItterTest + ") Проверяем сколько раз был оплодотворён кролик ("+MotherBunnyID+")", function() {
        return  meta.getcoolduwn(MotherBunnyID).then(function(result) {
            assert.equal(result[1] ,1 , 'Ошибка количества оплодотворения '+result[1]); 
            assert.equal(result[2] ,120 , 'Ошибка количества оплодотворения '+result[2]); 
      })
    }); 
 
    ItterTest++;
    it(ItterTest + ") Пытаемся ещё раз родить, но с ошибкой  Кролики: "+MotherBunnyID + ' и ' + SireBunnyID , function() {
        // сколько денег надо для нового кролика?
        // Для нового кролика надо + 25%   
    //    newprice = priceChildren*bigPrice+(priceChildren*bigPrice/4);
    expectRevert(meta.createChildren(MotherBunnyID, SireBunnyID, {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value, value:newprice})); 
    //})
  }); 


  ItterTest++;
  it(ItterTest + ") Выставляем на продажу кролика + ("+newBunnyID+") и получаем стоимость сверяя её с " + (priceChildren), function() {

             return meta.startMarket(newBunnyID, priceChildren , {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
              return meta.currentPrice.call(newBunnyID);
            }).then( (result ) => {
               assert.equal(result ,(priceChildren+(priceChildren/100*comission)) , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
        })
    }); 
 


    ItterTest++;
    it(ItterTest + ") Снимаем с продажи нашего кролика ("+8+")"  , function() {
      return meta.stopMarket(8, {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
          return meta.currentPrice.call(8);
        }).then( (result ) => {
          assert.equal(result , 0 , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
      })
    }); 


 

    ItterTest++;
    it(ItterTest + ") Снимаем с продажи нашего кролика ("+7+")"  , function() {
      return meta.stopMarket(7, {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value}).then(function() {
          return meta.currentPrice.call(7);
        }).then( (result ) => {
          assert.equal(result , 0 , 'Ошибка проверки соответствия цены на нового кролика: ' + result ); 
      })
    }); 

 
    ItterTest++;
    it(ItterTest + ") Подарим нового кролика("+newBunnyID+") пользователю: " + giffes, function() {
      return meta.giff(newBunnyID, giffes , {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
      return meta.ownerOf.call(newBunnyID);
      }).then( (result ) => {
         assert.equal(result , giffes, 'Подарок не соответстует тому которому подарили : ' + result +' != ' +giffes); 
      })
    }); 


 

  
  
    ItterTest++;
    it(ItterTest + ") Проверка на ошибку. Можно ли установить стоимость кролику который нам не принадлежит. Если хорошо, то нельзя", function() { 
        expectRevert(meta.startMarket(2, priceBunny , {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value}));
      }); 

      ItterTest++;
      it(ItterTest + ") Проверка на ошибку.Покупаем кролика который не продаётся . Если хорошо, то нельзя", function() { 
        expectRevert(meta.buyBunny(10, {from: ownerCEO, gas:GasCost, gasPrice:  gasPrice_value, value:costRabbit})); 
      }); 

    
      var description = 'Мой первый любимый и самый лучший кролик на свете';
      ItterTest++;
      it(ItterTest + ") Дадим описание кролику: "+description, function() { 
        return meta.setDescriptionRabbit(1, description, {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
          return meta.getDescriptionRabbit.call(1);
          }).then( (result ) => {
             assert.equal(result , description, 'Описание кролика : ' + result); 
          })
      }); 
      var bunnyName = 'Первый кроль';
      ItterTest++;
      it(ItterTest + ") Назовём нашего кролика: "+bunnyName, function() { 
        return meta.setNameRabbit(1, bunnyName, {from: ownerCEO, gas:GasCost,gasPrice: gasPrice_value}).then(function(instance) {
          return meta.getNameRabbit.call(1);
          }).then( (result ) => {
            return meta.getNameRabbit.call(1);
            }).then( (result ) => {
             assert.equal(result ,bunnyName, 'Название кролика не соответствует заданному'); 
          })
      }); 







      ItterTest++;
      it(ItterTest + ") Пользователь получает бесплатного кролика"  , function() {
        
            return   meta.createGennezise(0, {from: accounts[6], gas:  GasCost, gasPrice:gasPrice_value }).then(function(error,result) {
                return meta.balanceOf.call(accounts[6]);
            }).then( (result) => {
         //  assert.isTrue(true); 
           assert.equal(result  , 1 , 'Ошибка Добавления кроликов '+ result  );   
      })
      }); 
      ItterTest++;
      it(ItterTest + ") Пытаемся получить ещё одного бесплатного кролика "+ accounts[6], () =>  { 
       expectRevert(meta.createGennezise(0, {from: accounts[6], gas:  GasCost, gasPrice:gasPrice_value }));
     }); 

 
        
    it((ItterTest++)+ ") Check parent "  , function() {
      return meta.getMotherCount(1).then(function(result) {
        assert.equal(result, 41, result  ); 
      })
   }); 
  
  
   it((ItterTest++) + ") Check mather "  , function() {
    return meta.getRabbitMother(30).then(function(result) {
      assert.equal(result[0], 1, result[0]  ); 
    })
 }); 

 it((ItterTest++) + ") Get total money 1"  , function() {
  return meta.getTotalSalaryBunny(1).then(function(result) {
    assert.equal(result, 0, result); 
  })
}); 
 

ItterTest++;
it(ItterTest + ') Воспроизводим своего ребёнка смешивая гены с 27  и  ' + SireBunnyID +' кроликами за '+(priceChildren+(priceChildren/4)+(priceChildren/100*comission)), function() {
    // сколько денег надо для нового кролика?
    // Для нового кролика надо + 25%   
    newprice = priceChildren+(priceChildren/4)+((priceChildren/100)*5);

      return  meta.createChildren(27, SireBunnyID, {from: ownerCEO, gas:GasCost,gasPrice:  gasPrice_value, value:newprice}).then(function() {
        return meta.ownerOf.call(54);
      }).then( (result ) => {
      assert.equal(result ,ownerCEO, 'Ошибка проверки соответствия нового кролика и аккаунта : ' + result ); 
  })
}); 

 it((ItterTest++) + ") Get total money 2"  , function() {
  return meta.getTotalSalaryBunny(1).then(function(result) {
    assert.equal(result, 3000000000000000, result); 
  })
}); 
});