import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BurgerPage extends StatefulWidget {
  final String foodname, imgPath, price;

  BurgerPage({this.foodname, this.imgPath, this.price});

  @override
  _BurgerPageState createState() => _BurgerPageState();
}

class _BurgerPageState extends State<BurgerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Nav bar section.
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Nav menu.
                Icon(Icons.menu, color: Colors.black),
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
                        height: 12.0,
                        width: 12.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text('1',
                              style: GoogleFonts.notoSans(
                                fontSize: 7.0,
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
          // Hero section.
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.foodname.toString().toUpperCase(),
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w800,
                fontSize: 27.0,
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Hero(
                tag: widget.foodname,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.imgPath),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Btn - Favorite.
                  InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      // TODO: Implement ontap.
                    },
                    child: Stack(
                      children: <Widget>[
                        // Shadow.
                        Container(
                          height: 45.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFE7D6A).withOpacity(0.1),
                                blurRadius: 6.0,
                                spreadRadius: 6.0,
                                offset: Offset(5.0, 11.0),
                              ),
                            ],
                            color: Colors.red,
                          ),
                        ),
                        // Icon.
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: Color(0xFFFE7D6A),
                              size: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35.0),
                  // Btn - Share.
                  InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {},
                    child: Stack(
                      children: <Widget>[
                        // Shadow.
                        Container(
                          height: 45.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFE7D6A).withOpacity(0.1),
                                blurRadius: 6.0,
                                spreadRadius: 6.0,
                                offset: Offset(5.0, 11.0),
                              ),
                            ],
                            color: Colors.red,
                          ),
                        ),
                        // Icon.
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.restore,
                              color: Color(0xFFFE7D6A),
                              size: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
