import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppNavBarOnco extends StatefulWidget {
  final Function currentIndex;
  const AppNavBarOnco({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<AppNavBarOnco> createState() => _AppNavBarOncoState();
}

class _AppNavBarOncoState extends State<AppNavBarOnco> {
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
                text: "Nuevo Reporte",
              ),
              GButton(
                gap: 10,
                icon: Icons.document_scanner_outlined,
                text: "Historial Reportes",
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

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeApp.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GNav(
          backgroundColor: ThemeApp.primary,
          activeColor: Colors.white,
          color: Colors.white,
          tabBackgroundColor: Colors.white.withOpacity(0.1),
          padding: EdgeInsets.all(20),
          onTabChange: (index) {},
          tabs: const [
            GButton(
              icon: Icons.monitor_heart_outlined,
              text: " Reporte",
            ),
            GButton(
              icon: Icons.document_scanner_outlined,
              text: " Historial",
            ),
            GButton(
              icon: Icons.messenger_outline_rounded,
              text: " Mensajes",
            ),
            GButton(
              icon: Icons.wallet,
              text: " Pagos",
            ),
          ],
        ),
      ),
    );
  }
}
