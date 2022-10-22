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
    /*
    context.read<AppPractitioner>().create(
          firstName: "Ricardo",
          lastName: "Gomez",
          id: "1023974032",
          role: "Cardiologo",
          active: "true",
          address: "calle 15 sur # 10 - 60",
          birthDate: "31-12-1998",
          email: "abcdef@gmail.com",
          gender: "Hombre",
          imgUrl:
              "https://painlesshire.com/wp-content/uploads/2017/07/doctor.jpg",
        );
    context.read<AppPractitioner>().diagnosticTestValues();
*/
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
