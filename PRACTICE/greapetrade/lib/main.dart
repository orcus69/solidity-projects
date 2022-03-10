import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xff02111A),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 350,
                  child: Card(
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
                          const Text(
                            "0x00000000000000000",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                  child: const Text(
                                    "from: 0x00000000000000000\nto: 0x00000000000000000\namount: 10 ETH",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5900B2)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                      )
                                    ),
                                    onPressed: () {},
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
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
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
}
