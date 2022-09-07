import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'screens.dart';

class HomeOncologo extends StatefulWidget {
  const HomeOncologo({Key? key}) : super(key: key);

  @override
  State<HomeOncologo> createState() => _HomeOncologoState();
}

class _HomeOncologoState extends State<HomeOncologo> {
  int index = 0;
  AppNavBar? navBar;
  @override
  void initState() {
    super.initState();
    navBar = AppNavBar(
      currentIndex: (i) {
        setState(() {
          index = i;
        });
      },
    );
  }

  final List<Widget> _body = [
    const SelectPatient(),
    const ReportListScreen(),
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
