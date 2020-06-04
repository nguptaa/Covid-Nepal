import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Covid Nepal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
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
            Text('Retry!')
          ],
        ),
      ),
    );
  }
}
