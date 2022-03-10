// Source code to interact with smart contract
//<-- Autor: Prof. Fabio santos (fssilva@uea.edu.br) -->

//connection with node
if (window.ethereum) {
  window.web3 = new Web3(window.ethereum)
  window.ethereum.enable()
}
else if (window.web3) {
  window.web3 = new Web3(window.web3.currentProvider)
}
else {
  window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!')
}


// contractAddress and abi are setted after contract deploy
var contractAddress = '0xf8b24fF5190de80F396d759a6Cc5335823B9a91C';

//contract abi
var abi = [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "user",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "etherAmount",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "time",
				"type": "uint256"
			}
		],
		"name": "Deposit",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "deposit",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	}
];

//contract instance
contract = new web3.eth.Contract(abi, contractAddress);

async function deposito(amount){
	
	//metamask accounts
	const accounts = await web3.eth.getAccounts();
		
	await contract.methods
		  .deposit()
		  .send({
			from: accounts[0],
			value: amount
		  })
		  .then( function(r){
		  	console.log(r);
			return r;
		  });	
}


