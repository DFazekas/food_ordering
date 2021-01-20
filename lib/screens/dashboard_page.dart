// Standard packages.
import 'package:flutter/material.dart';
// External packages.
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Custom packages.
import 'package:food_ordering/screens/food_tabs.dart';
import 'package:food_ordering/models/store.dart';
import 'package:food_ordering/services/database.dart';
import 'package:food_ordering/widgets/store_card.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Nav bar.
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nav menu.
                Icon(Icons.menu, color: Colors.black),
                // Profile avatar.
                InkWell(
                  onTap: () {
                    setState(() {
                      Database(firestore: _firestore).addStore(isDefault: true);
                    });
                  }, // TODO: implement ontap.
                  child: Stack(
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
                )
              ],
            ),
          ),
          // Page title.
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text("SEARCH FOR",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 27.0,
                )),
          ),
          Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "FOOD ITEMS",
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w800, fontSize: 27.0),
              )),
          SizedBox(height: 25.0),
          // Search bar.
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Try: "cheese burger"',
                  hintStyle: GoogleFonts.notoSans(
                      fontSize: 14.0, color: Colors.grey.withOpacity(0.7)),
                  border: InputBorder.none,
                  fillColor: Colors.grey.withOpacity(0.5),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          // Recommendations.
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Popular Stores",
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500, fontSize: 18.0),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
              height: 200.0,
              child: StreamBuilder(
                  stream: Database(firestore: this._firestore)
                      .streamStores(uid: "stores"),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<StoreModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData == false || snapshot.data.isEmpty) {
                        return const Center(
                            child: Text("No stores available at this time."));
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            StoreModel data = snapshot.data[index];
                            return StoreCard(
                              logoPath: data.logoPath,
                              storeName: data.name,
                              ratingStars: data.ratingStars,
                              ratingVotes: data.ratingVotes,
                              ratingVotesStr: data.ratingVotesStr,
                              estimatedDelivery: data.estimatedDelivery,
                              boxColor: data.colorMain,
                              txtColor: data.colorText,
                              index: index,
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(child: Text("Loading..."));
                    }
                    // return ListView(
                    //   scrollDirection: Axis.horizontal,
                    //   children: [
                    //     _buildFoodCard(
                    //       iconUrl: "assets/burger.png",
                    //       foodName: "Hamburger",
                    //       price: "21",
                    //       boxColor: Color(0xFFFFE9C6),
                    //       txtColor: Color(0xFFDA9551),
                    //     ),
                    //     _buildFoodCard(
                    //       iconUrl: "assets/fries.png",
                    //       foodName: "Fries",
                    //       price: "15",
                    //       boxColor: Color(0xFFC3E3FF),
                    //       txtColor: Color(0xFF7799B9),
                    //     ),
                    //     _buildFoodCard(
                    //       iconUrl: "assets/doughnut.png",
                    //       foodName: "Doughnut",
                    //       price: "15",
                    //       boxColor: Color(0xFFD7FBD9),
                    //       txtColor: Color(0xFF4DCD76),
                    //     ),
                    //   ],
                    // );
                  })),
          // Featured.
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: TabBar(
              controller: tabController,
              tabs: [
                Tab(child: Text("FEATURED")),
                Tab(child: Text("COMBO")),
                Tab(child: Text("FAVOURITES")),
                Tab(child: Text("RECOMMENDED")),
              ],
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.5),
              labelStyle: GoogleFonts.notoSans(
                  fontSize: 16.0, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.notoSans(
                  fontSize: 12.0, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 450.0,
            child: TabBarView(
              controller: tabController,
              children: [
                FoodTab(),
                FoodTab(),
                FoodTab(),
                FoodTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
