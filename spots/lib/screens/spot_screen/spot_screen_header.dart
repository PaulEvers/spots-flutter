import 'package:flutter/material.dart';
import 'package:spots/models/models.dart';

class SpotHeader extends StatelessWidget {
  const SpotHeader({Key key, this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    spot.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  spot.category,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          // Icon(
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
          // Text('41'),
        ],
      ),
    );
  }
}
