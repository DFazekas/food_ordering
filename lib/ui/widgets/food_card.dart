// Standard packages.
import 'package:flutter/material.dart';
// External packages.
import 'package:google_fonts/google_fonts.dart';
// Custom packages.
import 'package:food_ordering/data_layer/food.dart';

class FoodCard extends StatefulWidget {
  final FoodModel food;

  FoodCard({this.food});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Container(
        child: Row(
          children: <Widget>[
            // Left column.
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(widget.food.imagePath),
                width: 100.0,
                height: 100.0,
              ),
            ),
            SizedBox(width: 15.0),
            // Right column.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Name.
                  Text(widget.food.name,
                      style: GoogleFonts.notoSans(fontWeight: FontWeight.w600)),
                  // Description.
                  Text(widget.food.description,
                      style: GoogleFonts.notoSans(
                          color: Colors.grey.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                  SizedBox(height: 5.0),
                  // Price and quantity.
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Prices.
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Old price.
                            Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: widget.food.onSale,
                              child: Text("\$" + widget.food.oldPrice,
                                  style: GoogleFonts.lato(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    // color: Colors.grey.withOpacity(0.8),
                                    color: Colors.redAccent.withOpacity(0.6),
                                    decoration: TextDecoration.lineThrough,
                                  )),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            // Current price.
                            Text("\$" + widget.food.price,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                        // Quantity controls.
                        InkWell(
                            onTap: () {
                              // TODO: implement add to checkout.
                            },
                            child: Container(
                                height: 30.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                  child: Text("ADD",
                                      style: TextStyle(color: Colors.white)),
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
