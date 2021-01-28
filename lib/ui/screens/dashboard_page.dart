// Standard packages.
import 'package:flutter/material.dart';
import 'package:food_ordering/bloc/restaurant_bloc.dart';
import 'package:food_ordering/data_layer/location.dart';
import 'package:food_ordering/data_layer/restaurant.dart';
import 'package:food_ordering/ui/widgets/restaurant_tile.dart';
// External packages.
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Custom packages.
import 'package:food_ordering/data_layer/database.dart';
import 'package:food_ordering/data_layer/store.dart';
import 'package:food_ordering/ui/screens/food_tabs.dart';
import 'package:food_ordering/ui/widgets/store_card.dart';

class Dashboard extends StatefulWidget {
  final Location location;

  const Dashboard({Key key, @required this.location}) : super(key: key);

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
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final bloc = RestaurantBloc(widget.location);
    bloc.submitQuery("Toronto");
    return ListView(
      children: [
        // Shopping cart.
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                setState(null);
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
                        // TODO: pull from BLoC stream.
                        child: Text('0',
                            style: GoogleFonts.notoSans(
                              fontSize: 7.0,
                              textStyle: TextStyle(color: Colors.red),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ],
          ),
        ),
        // Page title.
        Container(
          width: 20,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Text("What do you want to eat?",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 27.0,
                )),
          ),
        ),

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
        // Popular restaurants.
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            "Popular Restaurants",
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
        ),
        SizedBox(height: 20.0),
        Container(height: 155.0, child: buildRestaurantStreamBuilder(bloc)),
        // Featured.
        // SizedBox(height: 20.0),
        // Padding(
        //   padding: EdgeInsets.only(left: 15.0),
        //   child: TabBar(
        //     controller: tabController,
        //     tabs: [
        //       Tab(child: Text("FEATURED")),
        //       Tab(child: Text("COMBO")),
        //       Tab(child: Text("FAVOURITES")),
        //       Tab(child: Text("RECOMMENDED")),
        //     ],
        //     isScrollable: true,
        //     indicatorColor: Colors.transparent,
        //     labelColor: Colors.black,
        //     unselectedLabelColor: Colors.grey.withOpacity(0.5),
        //     labelStyle: GoogleFonts.notoSans(
        //         fontSize: 16.0, fontWeight: FontWeight.w700),
        //     unselectedLabelStyle: GoogleFonts.notoSans(
        //         fontSize: 12.0, fontWeight: FontWeight.w500),
        //   ),
        // ),
        // Container(
        //   height: MediaQuery.of(context).size.height - 450.0,
        //   child: TabBarView(
        //     controller: tabController,
        //     children: [
        //       FoodTab(),
        //       FoodTab(),
        //       FoodTab(),
        //       FoodTab(),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

Widget buildRestaurantStreamBuilder(RestaurantBloc bloc) {
  return StreamBuilder(
      stream: bloc.stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData == false || snapshot.data.isEmpty) {
            return const Center(
                child: Text("No stores available at this time."));
          } else {
            final results = snapshot.data;
            return Expanded(child: _buildResearchResults(results));
          }
        } else {
          return const Center(child: Text("Loading..."));
        }
      });
}

Widget _buildResearchResults(List<Restaurant> results) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: results.length,
    itemBuilder: (_, index) {
      final restaurant = results[index];
      return RestaurantTile(restaurant: restaurant, index: index);
    },
  );
}
