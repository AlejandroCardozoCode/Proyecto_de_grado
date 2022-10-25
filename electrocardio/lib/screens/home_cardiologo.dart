import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'screens.dart';

class HomeCardiologist extends StatefulWidget {
  const HomeCardiologist({Key? key}) : super(key: key);

  @override
  State<HomeCardiologist> createState() => _HomeCardiologistState();
}

class _HomeCardiologistState extends State<HomeCardiologist> {
  int index = 0;
  AppNavBarCardio? navBar;
  @override
  void initState() {
    super.initState();
    navBar = AppNavBarCardio(
      currentIndex: (i) {
        setState(() {
          index = i;
        });
      },
    );
  }

  final List<Widget> _body = [
    const DiagnosticListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body[index],
        bottomNavigationBar: navBar,
      ),
    );
  }
}
