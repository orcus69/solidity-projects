
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

  final _abi = [
    'function deposit() payable',
    'event Deposit(address indexed from, uint amount, uint time)'
  ];
  // contractAddress and abi are setted after contract deploy
  String get fixedSwapContractAddress => '0x6ed6064904D158A9fe7b50969378d2A5875A214C';
  //Create a conection to smart contract
  //Get Balance of Wallet
  final signer = provider!.getSigner();

  Contract connectToContract(String address) => Contract(address, _abi, signer);

  BigInt balance =  BigInt.zero;
  getBalance() async {
    balance = await signer.getBalance();

    notifyListeners();
  }
  
  //Smart contract functions

  //Transfer
  //uint256 return a Bigint type in flutter
  transfer(String fromAddres, String toAddress, String amount)async{
    isLoading = true;
    notifyListeners();
    //TODO: Make transfer transaction

    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }

  //deposit
  deposit( BigInt amount) async {
    isLoading = true;
    notifyListeners();
    final contract = connectToContract(fixedSwapContractAddress);
    
    //create a deposit transaction
    await contract.send(
      'deposit',
      [amount]
    );

    isLoading = false;
    notifyListeners();
  }

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