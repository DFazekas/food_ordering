// Standard packages.
// External packages.
import 'package:cloud_firestore/cloud_firestore.dart';
// Custom packages.

class FoodModel {
  String name;
  String price;
  String oldPrice;
  bool onSale;
  String description;
  String imagePath;

  FoodModel(
      {this.name,
      this.price,
      this.oldPrice,
      this.onSale,
      this.description,
      this.imagePath});

  FoodModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    try {
      var data = doc.data();
      this.name = data["name"] as String;
      this.price = data["price"] as String;
      this.oldPrice = data["old_price"] as String;
      this.onSale = data["on_sale"] as bool;
      this.description = data["description"] as String;
      this.imagePath = data["image_path"] as String;
    } catch (e) {
      print(e);
    }
  }
}
