// Standard packages.
import 'package:flutter/material.dart';
// External packages.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering/models/food.dart';
// Custom packages.
import 'package:food_ordering/models/store.dart';
import 'package:food_ordering/screens/store_page.dart';
import 'package:food_ordering/services/database.dart';

class StoreCard extends StatefulWidget {
  final FirebaseFirestore firestore;
  final StoreModel store;
  final String logoPath;
  final String storeName;
  final Color boxColor;
  final Color txtColor;
  final double ratingStars;
  final int ratingVotes;
  final String ratingVotesStr;
  final String estimatedDelivery;
  final int index;

  StoreCard(
      {Key key,
      this.firestore,
      this.store,
      this.logoPath,
      this.storeName,
      this.boxColor,
      this.txtColor,
      this.ratingStars,
      this.ratingVotes,
      this.ratingVotesStr,
      this.estimatedDelivery,
      this.index})
      : super(key: key);

  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(right: 15.0, left: widget.index == 0 ? 15.0 : 0.0),
        child: InkWell(
          onTap: () {
            // Open store page.
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StorePage(
                      firestore: widget.firestore,
                      store: widget.store,
                    )));
          },
          child: Container(
            height: 175.0,
            width: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: widget.boxColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Store logo.
                Hero(
                  tag: widget.storeName,
                  child: Container(
                    height: 75.0,
                    width: 125.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: SvgPicture.network(
                        widget.logoPath,
                        height: 40.0,
                        width: 40.0,
                        fit: BoxFit.fill,
                        placeholderBuilder: (context) =>
                            CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                // Store name.
                Text(
                  widget.storeName,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: widget.txtColor,
                  ),
                ),
                SizedBox(height: 7.0),
                // Store estimated delivery.
                Text(
                  widget.estimatedDelivery,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: widget.txtColor,
                  ),
                ),
                SizedBox(height: 10.0),
                // Rating.
                Container(
                  width: 90,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Rating stars.
                      Text(
                        widget.ratingStars.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: widget.txtColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      // Star icon.
                      Icon(
                        Icons.star,
                        color: widget.txtColor,
                        size: 13.0,
                      ),
                      SizedBox(width: 5.0),
                      // Rating votes.
                      Text(
                        "(${widget.ratingVotesStr})",
                        style:
                            TextStyle(fontSize: 11.0, color: widget.txtColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
