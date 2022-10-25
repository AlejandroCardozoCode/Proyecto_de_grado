import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'screens.dart';

class HomeOncologist extends StatefulWidget {
  const HomeOncologist({Key? key}) : super(key: key);

  @override
  State<HomeOncologist> createState() => _HomeOncologistState();
}

class _HomeOncologistState extends State<HomeOncologist> {
  int index = 0;
  AppNavBarOnco? navBar;
  @override
  void initState() {
    super.initState();
    navBar = AppNavBarOnco(
      currentIndex: (i) {
        setState(
          () {
            index = i;
          },
        );
      },
    );
  }

  final List<Widget> _body = [
    const SelectPatient(),
    const ObservationList(),
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
