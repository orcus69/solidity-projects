
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';

class MetaMaskProvider extends GetxController{
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

  //ABI of contract
  final _abi = '''''';

  // contractAddress and abi are setted after contract deploy
  String get fixedSwapContractAddress => '';
  //Create a conection to smart contract
  //Get Balance of Wallet
  final signer = provider!.getSigner();

  Contract connectToContract(String address) => Contract(address, Interface(_abi), signer);
  
  //Smart contract functions

  //End smart contract funcions

  //connect to metamask
  Future<void> connect() async{
    isLoading = true;
    update();
    if (Ethereum.isSupported){
      try {
        // Prompt user to connect to the provider, i.e. confirm the connection modal
        // Get all accounts in node disposal
        final accounts = await ethereum!.requestAccount(); 

        if(accounts.isNotEmpty) currentAddress = accounts.first;

        currentChain = await ethereum!.getChainId();

        accounts; // [foo,bar]

        isLoading = false;
        update();
      } on EthereumUserRejected {
        isLoading = false;
        print('User rejected the modal');
        update();
      }
    }

  }

  clear(){
    currentAddress = "";
    currentChain = -1;
    update();
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