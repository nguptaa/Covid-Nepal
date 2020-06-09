import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SomethingWentWrong extends StatefulWidget {
  @override
  _SomethingWentWrongState createState() => _SomethingWentWrongState();
}

class _SomethingWentWrongState extends State<SomethingWentWrong> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: FaIcon(
            FontAwesomeIcons.exclamationTriangle,
            size: size.longestSide * 0.1,
          ),
        ),
        SizedBox(
          height: size.longestSide * 0.01,
        ),
        Center(
          child: Text(
            'Something went Wrong!',
            style: TextStyle(
              fontSize: size.longestSide * 0.02,
            ),
          ),
        ),
        SizedBox(
          height: size.longestSide * 0.015,
        ),
        Center(
          child: RaisedButton(
            color: Colors.red[600],
            onPressed: () {
              setState(() {});
            },
            child: Text(
              'Retry',
              style: TextStyle(fontSize: size.width * 0.05),
            ),
          ),
        )
      ],
    );
  }
}
