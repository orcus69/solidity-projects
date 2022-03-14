
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:greapetrade/controllers/metamask.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
    return Card(
      margin: const EdgeInsets.only(top: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.white,
      elevation: 6.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              context.read<MetaMaskProvider>().currentAddress,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 10,
            ),
    
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  title: TextFormField(
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
                  ),
                ),
    
                ListTile(
                  title: TextFormField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xff5900B2), width: 1.0),
                      ),
                      hintText: '0.0001',
                      labelText: 'Amount',
                    ),
                    keyboardType: TextInputType.number,
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
                      "from: ${context.read<MetaMaskProvider>().currentAddress}\nto: 0x00000000000000000\nYour Balnace: ${context.read<MetaMaskProvider>().balance} ETH",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                _builButton(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _builButton(BuildContext context){
    final isConnected = context.read<MetaMaskProvider>().isConnected;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child:  (!isConnected) ? ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5900B2)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0),
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
          onPressed: () => context.read<MetaMaskProvider>().connect(),
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
          child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Enviar',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          onPressed: ()async{
            //make a deposit
            context.read<MetaMaskProvider>().deposit(BigInt.one).then((value) => print('ok')).catchError((e){print(e);});
          }
          ,
        ), 

      ),
    );
  }
}
