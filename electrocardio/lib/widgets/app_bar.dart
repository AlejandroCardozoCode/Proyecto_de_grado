import 'package:flutter/material.dart';

class ApplicationAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool darkIcons;
  const ApplicationAppBar({Key? key, required this.darkIcons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (darkIcons) {
      return AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
