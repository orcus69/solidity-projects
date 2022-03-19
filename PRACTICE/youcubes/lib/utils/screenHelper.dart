import 'package:flutter/material.dart';

class ScreenHelper extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenHelper({ Key? key, required this.mobile, required this.tablet, required this.desktop }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 800.0;

  static bool isTablet(BuildContext context) => 
    MediaQuery.of(context).size.width >= 800.0 && 
    MediaQuery.of(context).size.width < 1200.0;
    
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1200.0;
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext contex, BoxConstraints constraints){
        if(constraints.maxWidth >= 1200.0){
          return desktop;
        }else if(constraints.maxWidth >= 800.0 && constraints.maxWidth < 1200.0 ){
          return tablet;
        }else{
          return mobile;
        }
      }
      );
  }
}