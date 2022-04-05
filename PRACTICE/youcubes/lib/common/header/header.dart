import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youcubes/controllers/metamask.dart';
import 'package:youcubes/utils/screenHelper.dart';

//Logo do cabeçalho
class HeaderLogo extends StatelessWidget {
  const HeaderLogo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: ()=> Navigator.of(context).pushReplacementNamed('/'),
        child: RichText(
          text: const TextSpan(
           text: "YouCubes",
           style: TextStyle(color: Colors.white, fontSize: 24.0)
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: buildHeader(context),
      ),
      mobile: buildHeader(context),
      tablet: buildHeader(context),
    );
  }

  Widget buildHeader(BuildContext context){

    final provider = Provider.of<MetaMaskProvider>(context, listen: true)..init();

    return Container(
      color: const Color(0xff024373),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HeaderLogo(),
          const Spacer(flex: 2),

          Expanded(flex: 6, child: buildSearchField()),
          Container(
            child: const Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 5.5, bottom: 5.5),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xff00F0FF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5)
              ),
            ),
            
          ),
          const Spacer(flex: 2),
          
          //User data
          Row(
            children: [
              //upload button
              InkWell(
                onTap: ()=>Navigator.of(context).pushReplacementNamed('/upload'),
                child: const Icon(Icons.upload_rounded, color: Colors.white)
              ),Container(
                    child: provider.isConnected ? ElevatedButton(
                      onPressed: () async => await provider.connect(),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff00F0FF)),
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Image.asset(
                              "/metamask.svg",
                              fit: BoxFit.cover,
                              scale: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Connect to MetaMask',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ) 
                    : Text('0x00000000000000000000000',style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  ),

              const SizedBox(width: 10,),
              
            ],
          )
          
        ],
      ),
    );
  }

  Widget buildSearchField() => Padding(
    padding: const EdgeInsets.only(left: 10.00, top: 2.00, bottom: 2.00),
    child: TextFormField(
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
        
        fillColor: Colors.white,
        isDense: true,
        contentPadding: EdgeInsets.all(12.00),
        filled: true,
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), 
            bottomLeft: Radius.circular(5), 
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), 
            bottomLeft: Radius.circular(5), 
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
    ),
  );

}