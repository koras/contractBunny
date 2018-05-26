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

var costRabbit = 1000000000000000;

var priceBunny = 1;
var SireBunnyID = 6;
var MotherBunnyID = 5;
var newBunnyID = 14;
var arrayBunnyPrice = [];

//var priceChildren = 2;
var priceChildren = 12000000000000000;

var ownerMoney;

let private_accounts =  ["7df9a875a174b3bc565e6424a0050ebc1b2d1d82","f41c74c9ae680c1aa78f42e5647a62f353b7bdde"];

 
// use the given Provider, e.g in Mist, or instantiate a new websocket provider
var web3 = new Web3(Web3.givenProvider || 'http://127.0.0.1:8545');
// or
//var web3 = new Web3(Web3.givenProvider || new Web3.providers.WebsocketProvider('http://127.0.0.1:8545'));


 

contract('Тесты на Подарки ', ( accounts) => {

  let giffes = accounts[1];

  var oldBalance =[];
  var bunnySire =[20,21,23,25,26,27];
  var bunnySirePrice =[120000000000000000,52000000000000000,27000000000000000,72000000000000000,66000000000000000,37000000000000000,37000000000000000,28000000000000000,30000000000000000];
  var bunnySireItter = 0;
 
  ownerMoney = accounts[5];
  var ItterTest = 0;
  var meta; 

  function Gennezise() {
      meta.createGennezise({from: accounts[0], gas:  GasCost ,gasPrice:gasPrice_value});
  }

  ItterTest++;
  it(ItterTest + ") Загружаем контракт "+accounts[0], function() {
    return MetaCoin.deployed().then(function(instance) {
              meta = instance; 
 
      return meta.totalSupply.call();
    }).then( (result ) => {
      assert.equal(result , 0, ' Загружаем контракт : ' + result); 
    });
  });
  
 
  ItterTest++;
  it(ItterTest + ") Получаем бесплатного кролика в рамках промо акции"  , function() {
    
        return   meta.createGennezise({from: accounts[6], gas:  GasCost ,gasPrice:gasPrice_value }).then(function(instance) {
      return meta.totalSupply.call();
    }).then( () => {
       assert.isTrue(true); 
    })
  }); 
  ItterTest++;
  it(ItterTest + ") Тест на ошибку, второго кролика получить нельзя"  , function() {
    expectRevert(meta.createGennezise({from: accounts[6], gas:  GasCost ,gasPrice:gasPrice_value }));
  }); 
});