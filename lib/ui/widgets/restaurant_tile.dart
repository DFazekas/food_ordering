import 'package:flutter/material.dart';
import 'package:food_ordering/data_layer/restaurant.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  final index;

  RestaurantTile({Key key, @required this.restaurant, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15, left: this.index == 0 ? 15.0 : 0.0),
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Store image.
            Hero(
              tag: restaurant.name,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Store name.
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Text(
                restaurant.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // Store rating.
            Container(
              width: 90,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Rating stars.
                  Text(
                    this.restaurant.rating.average,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  // Star icon.
                  Icon(
                    Icons.star,
                    color: Colors.yellow[900],
                    size: 13.0,
                  ),
                  SizedBox(width: 5.0),
                  // Voting count.
                  Text("(${this.restaurant.ratingVotes.toString()})",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
