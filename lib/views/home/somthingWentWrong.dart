import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        Flexible(
          child: SvgPicture.asset(
            'assets/images/somethingWentWrong.svg',
            height: size.longestSide * 0.2,
            placeholderBuilder: (BuildContext context) => Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        ),
        SizedBox(
          height: size.longestSide * 0.02,
        ),
        Flexible(
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
        Flexible(
          child: RaisedButton(
            color: Colors.red[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              setState(() {});
            },
            child: Text(
              'Retry',
              style: TextStyle(fontSize: size.longestSide * 0.02),
            ),
          ),
        )
      ],
    );
  }
}
