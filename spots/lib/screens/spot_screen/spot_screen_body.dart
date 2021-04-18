import 'package:flutter/material.dart';
import 'package:spots/models/models.dart';

class SpotBody extends StatelessWidget {
  const SpotBody({Key key, this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(spot.description),
    );
  }
}
