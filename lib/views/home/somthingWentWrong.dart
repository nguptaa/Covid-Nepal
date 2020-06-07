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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/images/socialDis.svg',
          height: size.height * 0.30,
          placeholderBuilder: (BuildContext context) => Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red[600],
              ),
            ),
          ),
        ),
        Text('Something went wrong!')
      ],
    );
  }
}
