import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youcubes/common/header/header.dart';
import 'package:youcubes/components/video_body.dart';
import 'package:youcubes/controllers/metamask.dart';
import 'package:youcubes/pages/upload_page.dart';
import 'package:youcubes/utils/globals.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:youcubes/common/header/header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'YouCubes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: Theme.of(context).copyWith(
        platform: TargetPlatform.android,
        scaffoldBackgroundColor: const Color(0xffffffff),
        primaryColor: const Color(0xff024373),
        canvasColor: const Color(0xff00F0FF),
      ),
      builder: (context,widget)=>ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.resize(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.resize(2460, name: "4K"),

        ],
        background: Container(
          color: const Color(0xff00243E),

        )
      ),
      onGenerateRoute: (route){
        switch(route.name){
            case '/upload':
              return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                    create: (_) => MetaMaskProvider()..init(),
                    builder: (_, child) {
                    return Scaffold(
                      body: Column(
                        children: [
                          Header(),
                          UploadPage(),
                        ],
                      ),
                    );
                  }
                )
              );
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => MyHomePage(title: 'YouCubes'),
              );
          }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon customIcon = const Icon(Icons.search);
 Widget customSearchBar = RichText(
          text: const TextSpan(
           text: "YouCubes",
           style: TextStyle(color: Colors.white, fontSize: 32.0)
          ),
        );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MetaMaskProvider(),
      builder: (_, child) {
        return Scaffold(
          
          key: Globals.scaffoldKey,
          
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                //Header
                Header(),

                //Video body
                VideoBody()
                
              ],
            ),
          ),
        );
      }
    );
  }

  

}