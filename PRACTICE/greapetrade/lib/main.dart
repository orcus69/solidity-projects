
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:greapetrade/controllers/metamask.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Greape Trade | Ganache Testnet',
        debugShowCheckedModeBanner: false,
        home: _buildHome(context));
  }

  Widget _buildHome(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MetaMaskProvider()..init(),
      builder: (_, child) {
        return Scaffold(
          backgroundColor: const Color(0xff02111A),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 350,
                      child: Consumer<MetaMaskProvider>(
                        builder: (context, provider, child) {
                          late final String text;
                          late bool isConnected = false;

                          if(provider.isConnected && provider.isInOperatingChain){
                            text = "Connected.";
                            isConnected = true;
                          }else if(provider.isConnected && !provider.isInOperatingChain){
                            text = "Wrong chain ID[${provider.currentChain}]. Please conect to ID[${MetaMaskProvider.operatingChain}].";
                          }else if(Ethereum.isSupported){
                            return _buildCard(context);
                          }else{
                            text = "Please use a Web3 supported browser.";
                          }
                          
                          return isConnected ? _buildCard(context) : Text(text, style: const TextStyle(color: Colors.white),);
                          
                        }
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "/images/josue.svg",
                    fit: BoxFit.cover,
                    scale: 4,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildCard(BuildContext context) {
    //FormKey
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    //TextControllers
    final TextEditingController toAddressController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => MetaMaskProvider(),
      builder: (_, child) {
        return Card(
          margin: const EdgeInsets.only(top: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.white,
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<MetaMaskProvider>(
              builder: (context, provider, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: Image.asset(
                          "/images/logo.svg",
                          fit: BoxFit.cover,
                          scale: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      provider.currentAddress,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
        
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListTile(
                            title: TextFormField(
                              controller: toAddressController,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff5900B2), width: 1.0),
                                ),
                                hintStyle: TextStyle(color: Color(0xff5900B2)),
                                hintText: '0x000000000000',
                                labelText: 'to:',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (addres) => addres!.isEmpty ? "Error. Please insert an address!" : null,
                            ),
                          ),
        
                          ListTile(
                            title: TextFormField(
                              controller: amountController,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff5900B2), width: 1.0),
                                ),
                                hintText: '0.0001',
                                labelText: 'Amount',
                              ),
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'\.|[0-9]')),],
                              keyboardType: TextInputType.number,
                              validator: (amount){
                                if(amount!.isEmpty){
                                  return "Error. Please insert an amount!";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "from: ${provider.currentAddress}\nto: ${toAddressController.text}\nYour Balnace: ${provider.balance} ETH",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child:  (!provider.isConnected) ? ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff5900B2)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  )
                                ),
                                child: provider.isLoading ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 4,),
                                      )
                                    ],
                                  ) 
                                  : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Image.asset(
                                        "/images/metamask.svg",
                                        fit: BoxFit.cover,
                                        scale: 10,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Text(
                                      'Connect to MetaMask',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                onPressed: () async => await provider.connect(),
                              )
                              : ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5900B2)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  )
                                ),
                                onPressed: () async{ 
                                  if(formKey.currentState!.validate()){
                                    await provider.transfer(
                                      provider.currentAddress, 
                                      toAddressController.text, 
                                      amountController.text
                                    );
                                  
                                  //make a deposit
                                  //metaMaskProvider.deposit(BigInt.one).then((value) => print('ok')).catchError((e){print(e);});
                                  }
                                },
                                child: provider.isLoading ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 6.0),
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 4,),
                                    )
                                  ],
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [ 
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 14.0),
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ), 
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        );
      }
    );
  }
}
