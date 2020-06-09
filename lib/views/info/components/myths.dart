import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getCovidMyths.dart';

class Myths extends StatefulWidget {
  @override
  _MythsState createState() => _MythsState();
}

String language = 'Np';

class _MythsState extends State<Myths> {
  final CovidMyths covidMyths = CovidMyths();
  Future<List<CovidMythsStat>> _futureMythImage;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      covidMyths.getCovidMythsStats();
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    _futureMythImage = covidMyths.getCovidMythsStats();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Myths',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: refresh,
          child: FutureBuilder(
            future: _futureMythImage,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data[index].imageUrl,
                                placeholder: (context, url) =>
                                    CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CupertinoActivityIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
