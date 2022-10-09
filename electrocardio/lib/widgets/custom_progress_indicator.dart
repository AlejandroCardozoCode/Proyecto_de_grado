import 'package:flutter/material.dart';

import '../theme/theme.dart';

class customProgressIndicator extends StatelessWidget {
  const customProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(shape: BoxShape.circle, color: ThemeApp.primary),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
