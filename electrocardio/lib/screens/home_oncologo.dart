import 'package:electrocardio/screens/new_report_screen.dart';
import 'package:electrocardio/screens/profile_screen.dart';
import 'package:electrocardio/screens/report_list_screen.dart';
import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    NewReportScreen(),
    ReportListScreen(),
    NewReportScreen(),
    ProfileScreen(),
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
