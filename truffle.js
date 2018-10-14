// geth --datadir ~/ethpriv    --rpc  --rpcapi db,eth,net,web3,personal --identity '10' --rpccorsdomain "http://localhost:8000"    --networkid 10 --mine     console


//geth --datadir "~/ethpriv" --mine --rpc  --rpcapi db,eth,net,web3   --rpcport 9545   --unlock 0  console
// geth --datadir=./ethpriv --password ./password.txt account new > ./ethpriv/acc/account5.txt
// https://github.com/ethereum/go-ethereum/issues/14831


// https://habr.com/post/341466/

module.exports = {

  networks: {

    development: {
      host: "127.0.0.1",
      port: 8545, 
     network_id: "*",
    // gas: 46000, 
   //  gasLimit: 6700000, 
     from: '0x4ece223a70f46056419957ebda1e31d5d79ff03a',
   //  from: "0x4a174BaF2E41f5B8A68fc79139C054a541402c79", // default address to use for any transaction Truffle makes during migrations
 
  // gas: 4395000,
//gasPrice: 2776297000 ,
   //  gasPrice: 22000000000,

    },
    //  truffle migrate --reset --network rinkeby
    // работатет
    rinkeby: {
      host: "127.0.0.1",
      port: 8545, 
     network_id: "*",
    // gas: 5395000,
 //    gasLimit: 22000000,
  //   from: '0x15c7c1d8754e7f47d49126e1ab8964f23c1bf6de',
     from: "0x4a174BaF2E41f5B8A68fc79139C054a541402c79", // default address to use for any transaction Truffle makes during migrations
     //gasPrice: 1000000000,
    gasPrice: 2776297000 ,

    }
  },	
  rpc: {
    host: "127.0.0.1",
  //  gas: 7700000,
   // gasPrice: 100000200000,
		port: 8545
  }, 

  solc: {
		optimizer: {
			enabled: false,
			runs: 200
		}
	},
};
