
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier{
  //ID of Ganache
  static const operatingChain = 1337;

  String currentAddress = "";
  int currentChain = -1;

  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => Ethereum.isSupported && currentAddress.isNotEmpty;

  // contractAddress and abi are setted after contract deploy
  String contractAddress = '0x6ed6064904D158A9fe7b50969378d2A5875A214C';

  List abi = [
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


  //connect to metamask
  Future<void> connect() async{
    if (Ethereum.isSupported){
      try {
        // Prompt user to connect to the provider, i.e. confirm the connection modal
        // Get all accounts in node disposal
        final accounts = await ethereum!.requestAccount(); 

        if(accounts.isNotEmpty) currentAddress = accounts.first;

        currentChain = await ethereum!.getChainId();

        accounts; // [foo,bar]
        notifyListeners();
      } on EthereumUserRejected {
        print('User rejected the modal');
      }
    }
  }

  clear(){
    currentAddress = "";
    currentChain = -1;
    notifyListeners();
  }

  init(){
    if(Ethereum.isSupported){
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }
}