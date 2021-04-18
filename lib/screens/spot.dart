import 'package:flutter/material.dart';
import 'package:spots/models/models.dart';
import 'package:spots/screens/spot_screen/spot_screen_body.dart';
import 'package:spots/screens/spot_screen/spot_screen_header.dart';

class SpotInfoScreen extends StatelessWidget {
  final Spot spot;

  const SpotInfoScreen({Key key, @required this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.network('https://picsum.photos/250?image=9',
              height: 250, fit: BoxFit.cover),
          SpotHeader(spot: spot),
          Container(
            margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Divider(
              color: Colors.red,
              thickness: 2,
            ),
          ),
          SpotBody(
            spot: spot,
          )
        ],
      ),
    );
  }
}
