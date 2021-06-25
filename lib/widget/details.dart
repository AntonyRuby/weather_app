import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final IconData icon;
  final String firstText;
  final String lastText;

  Details(this.icon, this.firstText, this.lastText);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text(firstText),
          Text(lastText, style: TextStyle(color: Colors.white54))
        ],
      ),
    );
  }
}
