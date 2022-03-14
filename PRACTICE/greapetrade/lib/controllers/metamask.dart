
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
  String get fixedSwapContractAddress => '0x6ed6064904D158A9fe7b50969378d2A5875A214C';

  final _abi = [
    'function deposit() payable',
    'event Deposit(address indexed from, uint amount, uint time)'
  ];
  BigInt deposite = BigInt.zero;

  //Get Balance of Wallet
  final signer = provider!.getSigner();
  BigInt balance =  BigInt.zero;

  getBalance() async {
    balance = await signer.getBalance();

    notifyListeners();
  }

  Contract connectToContract(String address) => Contract(address, _abi, signer);

  //wrapper of the contract funtion
  deposit( BigInt amount) async {
    final contract = connectToContract(fixedSwapContractAddress);
    
    //create a deposit transaction
    await contract.send(
      'deposit',
    );
  }



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
        getBalance();
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