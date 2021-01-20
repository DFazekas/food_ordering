import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  String name;
  String price;
  String oldPrice;
  bool onSale;

  FoodModel({this.name, this.price, this.oldPrice, this.onSale});

  FoodModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    this.name = doc.data()["name"] as String;
    this.price = doc.data()["price"] as String;
    this.oldPrice = doc.data()["old_price"] as String;
    this.onSale = doc.data()["on_sale"] as bool;
  }
}
