//import 'package:LibreFit/fitness_app/ui_view/title_view.dart';
import 'package:LibreFit/fitness_app/reel/screens/home_page.dart';
import 'package:flutter/material.dart';


class ReelScreen extends StatefulWidget {
  const ReelScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _ReelScreenState createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> with TickerProviderStateMixin {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
