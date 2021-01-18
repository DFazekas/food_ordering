import 'package:flutter/material.dart';
import 'package:food_ordering/screens/food_tabs.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
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
                Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 6.0,
                            spreadRadius: 4.0,
                            offset: Offset(0.0, 3.0)),
                      ],
                      color: Color(0xFFC6E7FE),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/tuxedo.png"),
                        fit: BoxFit.contain,
                      ),
                    ))
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
                "RECIPES",
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
                  hintText: "Search",
                  hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
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
              "Recommended",
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500, fontSize: 18.0),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFoodCard(
                    iconUrl: "assets/burger.png",
                    foodName: "Hamburger",
                    price: "21",
                    boxColor: Color(0xFFFFE9C6),
                    txtColor: Color(0xFFDA9551),
                  ),
                  _buildFoodCard(
                    iconUrl: "assets/fries.png",
                    foodName: "Fries",
                    price: "15",
                    boxColor: Color(0xFFC3E3FF),
                    txtColor: Color(0xFF7799B9),
                  ),
                  _buildFoodCard(
                    iconUrl: "assets/doughnut.png",
                    foodName: "Doughnut",
                    price: "15",
                    boxColor: Color(0xFFD7FBD9),
                    txtColor: Color(0xFF4DCD76),
                  ),
                ],
              )),
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

  Widget _buildFoodCard({
    String iconUrl,
    String foodName,
    String price,
    Color boxColor,
    Color txtColor,
  }) {
    return Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 175.0,
            width: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: boxColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Item icon.
                Hero(
                  tag: foodName,
                  child: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(iconUrl, height: 50.0, width: 50.0),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                // Item name.
                Text(
                  foodName,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: txtColor,
                  ),
                ),
                // Item price.
                Text(
                  "\$" + price,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: txtColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
