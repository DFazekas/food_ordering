// Standard packages.
import 'package:flutter/material.dart';
// External packages.
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Custom packages.
import 'package:food_ordering/data_layer/database.dart';
import 'package:food_ordering/data_layer/food.dart';
import 'package:food_ordering/data_layer/store.dart';
import 'package:food_ordering/ui/widgets/food_card.dart';

class StorePage extends StatefulWidget {
  final FirebaseFirestore firestore;
  final StoreModel store;

  StorePage({this.firestore, this.store});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final Color redColor = Color(0xFFFE7D6A);
  final Color pinkColor = Color(0xFFF68D7F);
  final Color greenColor = Color(0xFFD7FBD9);
  final Color blueColor = Color(0xFFC6E7FE);
  final Color orangeColor = Color(0xFFFFD143);
  int numCheckout = 0;

  Widget _buildListItem(
      {String imgPath, String name, String price, Color color}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Food list item.
              // TODO: extract into builder.
              Container(
                width: 210.0,
                child: Row(
                  children: <Widget>[
                    // Food image.
                    Container(
                      height: 75.0,
                      width: 75.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: color,
                      ),
                      child: Center(
                        child: Image.asset(
                          imgPath,
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    // Food details.
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name.
                        Text(
                          name,
                          style: GoogleFonts.notoSans(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                        // Price.
                        Text(
                          "\$" + price,
                          style: GoogleFonts.lato(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            textStyle: TextStyle(color: redColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                width: 210.0,
                child: Row(
                  children: <Widget>[
                    // Food image.
                    Container(
                      height: 75.0,
                      width: 75.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: color,
                      ),
                      child: Center(
                        child: Image.asset(
                          imgPath,
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    // Food details.
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name.
                        Text(
                          name,
                          style: GoogleFonts.notoSans(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                        // Price.
                        Text(
                          "\$" + price,
                          style: GoogleFonts.lato(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            textStyle: TextStyle(color: redColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(children: <Widget>[
          // Nav bar section.
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // TODO: Implement back button.
                // Nav menu.
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black)),
                // Shopping cart.
                Stack(
                  children: [
                    // Invisible outer frame.
                    Container(
                      height: 45.0,
                      width: 45.0,
                      color: Colors.transparent,
                    ),
                    // Shopping cart icon.
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFFE7D6A).withOpacity(0.3),
                              blurRadius: 6.0,
                              spreadRadius: 4.0,
                              offset: Offset(0.0, 4.0)),
                        ],
                        color: Color(0xFFFE7D6A),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                    ),
                    // Notification icon.
                    Positioned(
                      top: 1.0,
                      right: 4.0,
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(this.numCheckout.toString(),
                              style: GoogleFonts.notoSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700,
                                textStyle: TextStyle(color: Colors.red),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Brand section.
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                // Store logo.
                SvgPicture.network(
                  widget.store.logoPath,
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.fill,
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                ),
                SizedBox(width: 20.0),
                // Store name.
                Text(
                  widget.store.name.toString(),
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 27.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          // Delivery time, rating, fees.
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("15-25 min",
                    style: GoogleFonts.notoSans(
                        fontSize: 14.0, fontWeight: FontWeight.w600)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating stars.
                    Text(
                      widget.store.ratingStars.toString(),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    // Star icon.
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent[400],
                      size: 14.0,
                    ),
                    SizedBox(width: 5.0),
                    // Rating votes.
                    Text(
                      "(${widget.store.ratingVotesStr})",
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 14.0, color: Colors.black)),
                    ),
                  ],
                ),
                Text("\$2.99 delivery fee",
                    style: GoogleFonts.notoSans(
                        fontSize: 14.0, fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Divider(height: 40.0),
          // Store info section.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Section header.
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Restaurant info",
                  style: GoogleFonts.notoSans(fontWeight: FontWeight.w600),
                ),
              ),
              // Store address.
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("1455 Market St, Toronto...",
                        style: GoogleFonts.notoSans()),
                    Text("MORE INFO",
                        style: GoogleFonts.notoSans(
                            decoration: TextDecoration.underline)),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 40.0),
          // Menu section.
          Padding(
            padding: EdgeInsets.only(top: 0, left: 15.0, right: 15.0),
            child: Container(
              child: StreamBuilder(
                  stream: Database(firestore: widget.firestore)
                      .streamFood(uid: widget.store.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FoodModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData == false || snapshot.data.isEmpty) {
                        return const Center(
                          child: Text("The menu is currently unavailable."),
                        );
                      } else {
                        // TODO: implement listview builder.
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ListView.separated(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return FoodCard(food: snapshot.data[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 40.0,
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      return Center(child: Text("Loading..."));
                    }
                  }),
            ),
          ),
        ]),
      )),
    );
  }
}
