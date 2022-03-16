
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier{
  //ID of Ganache
  static const operatingChain = 1337;
  String currentAddress = "";
  int currentChain = -1;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => Ethereum.isSupported && currentAddress.isNotEmpty;

  //Loading
  bool _load = false;
  set isLoading(bool value) => _load = value;
  bool get isLoading => _load;

  final _abi = '''[
		{
			"inputs": [
				{
					"internalType": "address payable",
					"name": "_to",
					"type": "address"
				}
			],
			"name": "transfer",
			"outputs": [],
			"stateMutability": "payable",
			"type": "function"
		}
	]''';
  // contractAddress and abi are setted after contract deploy
  String get fixedSwapContractAddress => '0x355ec1745A1a43b47F3A72c8C6720b7DD79eD679';
  //Create a conection to smart contract
  //Get Balance of Wallet
  final signer = provider!.getSigner();

  Contract connectToContract(String address) => Contract(address, Interface(_abi), signer);

  BigInt balance =  BigInt.zero;
  getBalance() async {
    balance = await signer.getBalance();

    notifyListeners();
  }
  
  //Smart contract functions

  //Transfer
  //uint256 return a Bigint type in flutter
  transfer(String fromAddres, String toAddress, double amount)async{
    isLoading = true;
    notifyListeners();
    final contract = connectToContract(fixedSwapContractAddress);

    //send ethers
    await contract.send(
      'transfer', 
      [toAddress], 
      TransactionOverride(
        //amount in wei
        value: BigInt.from(amount*1000000000000000000)
      ),
    ).catchError((e){
      isLoading = false;
      notifyListeners();
    });

    isLoading = false;
    notifyListeners();
  }

  //deposit
  // deposit( BigInt amount) async {
  //   isLoading = true;
  //   notifyListeners();
  //   final contract = connectToContract(fixedSwapContractAddress);
    
  //   //create a deposit transaction
  //   await contract.send(
  //     'deposit',
  //     [amount]
  //   );

  //   isLoading = false;
  //   notifyListeners();
  // }

  //Trade
  
  //End smart contract funcions

  //connect to metamask
  Future<void> connect() async{
    isLoading = true;
    notifyListeners();
    if (Ethereum.isSupported){
      try {
        // Prompt user to connect to the provider, i.e. confirm the connection modal
        // Get all accounts in node disposal
        final accounts = await ethereum!.requestAccount(); 

        if(accounts.isNotEmpty) currentAddress = accounts.first;

        currentChain = await ethereum!.getChainId();

        accounts; // [foo,bar]

        getBalance();

        isLoading = false;
        notifyListeners();
      } on EthereumUserRejected {
        isLoading = false;
        print('User rejected the modal');
        notifyListeners();
      }
    }

  }

  clear(){
    currentAddress = "";
    currentChain = -1;
    notifyListeners();
  }
  
  //Init if browser has Web3 support
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