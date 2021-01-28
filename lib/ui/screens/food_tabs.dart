// Standard packages.
import 'package:flutter/material.dart';
// External packages.
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';
// Custom packages.

class FoodTab extends StatefulWidget {
  @override
  _FoodTabState createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _buildListItem(
              foodName: "Delicious hot dog",
              rating: 4.0,
              afterPrice: '6',
              beforePrice: '10',
              imgPath: 'assets/hotdog.png'),
          _buildListItem(
              foodName: "Cheese pizza",
              rating: 5.0,
              afterPrice: '12',
              beforePrice: '14',
              imgPath: 'assets/hotdog.png'),
        ],
      ),
    );
  }

  Widget _buildListItem(
      {String foodName,
      double rating,
      String afterPrice,
      String beforePrice,
      String imgPath}) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Left column -- image section.
          Container(
            width: 110.0,
            child: Row(children: [
              Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Color(0xFFFFE3DF),
                  ),
                  child: Center(
                      child: Image.asset(imgPath, height: 50.0, width: 50.0))),
            ]),
          ),
          // Middle column -- content section.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Food name.
              Text(
                foodName,
                style: GoogleFonts.notoSans(
                    fontSize: 14.0, fontWeight: FontWeight.w400),
              ),
              // Food rating.
              SmoothStarRating(
                allowHalfRating: false,
                onRated: (v) {},
                starCount: rating.toInt(),
                rating: rating,
                color: Color(0xFFFFD143),
                borderColor: Color(0xFFFFD143),
                size: 15.0,
                spacing: 0.0,
                isReadOnly: true,
              ),
              // Food price.
              Row(
                children: <Widget>[
                  // New price.
                  Text(
                    '\$' + afterPrice,
                    style: GoogleFonts.lato(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      textStyle: TextStyle(
                        color: Color(0xFFF68D7F),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.0),
                  // Old price.
                  Text(
                    '\$' + beforePrice,
                    style: GoogleFonts.lato(
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w600,
                      textStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          // Right column -- button section.
          FloatingActionButton(
            heroTag: foodName,
            mini: true,
            onPressed: () {},
            child: Center(
              child: Icon(Icons.add, color: Colors.white),
            ),
            backgroundColor: Color(0xFFFE7D6A),
          ),
        ],
      ),
    );
  }
}
