import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppNavBarCardio extends StatefulWidget {
  final Function currentIndex;
  const AppNavBarCardio({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<AppNavBarCardio> createState() => _AppNavBarCardioState();
}

class _AppNavBarCardioState extends State<AppNavBarCardio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: ThemeApp.primary,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GNav(
            backgroundColor: ThemeApp.primary,
            activeColor: Colors.white,
            color: Colors.white,
            tabBackgroundColor: Colors.white.withOpacity(0.1),
            padding: const EdgeInsets.all(20),
            onTabChange: (index) {
              widget.currentIndex(index);
            },
            tabs: const [
              GButton(
                gap: 10,
                icon: Icons.monitor_heart_outlined,
                text: "Reportes Pendientes",
              ),
              GButton(
                gap: 10,
                icon: Icons.person,
                text: "Perfil",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
