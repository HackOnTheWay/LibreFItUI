import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/profile_page.dart';
import 'themes.dart';
import 'utils/user_profile.dart';

class ProfilePageRoot extends StatefulWidget {
  static final String title = 'User Profile';

  @override
  State<ProfilePageRoot> createState() => _ProfilePageRootState();
}

class _ProfilePageRootState extends State<ProfilePageRoot> {
  void callInit() async {
    await getProfile();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // callInit();
  }

  @override
  Widget build(BuildContext context) {
    getProfile();

    return ThemeProvider(
      initTheme: false ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          title: ProfilePageRoot.title,
          home: ProfilePage(),
        ),
      ),
    );
  }
}
