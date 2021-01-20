import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StorePage extends StatefulWidget {
  final String foodName, imgPath, price;

  StorePage({this.foodName, this.imgPath, this.price});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  double netPrice = 0.0;
  int quantity = 1;
  final Color redColor = Color(0xFFFE7D6A);
  final Color pinkColor = Color(0xFFF68D7F);
  final Color greenColor = Color(0xFFD7FBD9);
  final Color blueColor = Color(0xFFC6E7FE);
  final Color orangeColor = Color(0xFFFFD143);

  /// Adjusts the quantity and net price.
  void adjustQuantity({String direction}) {
    setState(() {
      switch (direction) {
        case "MINUS":
          quantity = (quantity > 1) ? (quantity - 1) : 1;
          break;
        case "PLUS":
          quantity = (quantity < 9) ? (quantity + 1) : quantity;
          break;
        default:
          return;
      }
    });
  }

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
              widget.foodName.toString().toUpperCase(),
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
                tag: widget.foodName,
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
          // Price and quantity section.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Price.
              Container(
                height: 70.0,
                width: 125.0,
                child: Center(
                  child: Text(
                      "\$" + (int.parse(widget.price) * quantity).toString(),
                      style: GoogleFonts.notoSans(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5E6166))),
                ),
              ),
              // Quantity controls.
              Container(
                height: 60.0,
                width: 225.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFE7D6A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 105.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          // Btn -- Remove.
                          IconButton(
                              icon: Icon(Icons.remove,
                                  size: 17.0, color: Color(0xFFFE7D6A)),
                              onPressed: () =>
                                  adjustQuantity(direction: 'MINUS')),
                          // Quantity.
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.notoSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFe7D6A),
                            ),
                          ),
                          // Btn -- Add.
                          IconButton(
                              icon: Icon(Icons.add,
                                  size: 17.0, color: Color(0xFFFE7D6A)),
                              onPressed: () =>
                                  adjustQuantity(direction: 'PLUS')),
                        ],
                      ),
                    ),
                    Text("Add to cart"),
                  ],
                ),
              ),
            ],
          ),
          // Featured section.
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "FEATURED",
              style: GoogleFonts.notoSans(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 225.0,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildListItem(
                    imgPath: "assets/cheese.png",
                    name: "Sweet cheese",
                    price: "11",
                    color: pinkColor),
                _buildListItem(
                    imgPath: "assets/taco.png",
                    name: "Taco",
                    price: "9",
                    color: greenColor),
                _buildListItem(
                    imgPath: "assets/sandwich.png",
                    name: "Sandwich",
                    price: "4",
                    color: blueColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
