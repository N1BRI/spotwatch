import 'package:flutter/material.dart';
import 'package:spotwatch/ui/screens/widgets/main_screen_desktop.dart';
import 'package:spotwatch/ui/screens/widgets/main_screen_mobile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if(constraints.maxWidth > 800){
          return const MainScreenDesktop();
        }
        else{
          return const MainScreenMobile();
        }
      },
    );
  }
}
