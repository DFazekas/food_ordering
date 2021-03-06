// Standard packages.
import 'dart:math';
import 'package:flutter/material.dart';
// External packages.
import 'package:cloud_firestore/cloud_firestore.dart';
// Custom packages.
import 'package:food_ordering/data_layer/food.dart';

class StoreModel {
  String uid;
  String name;
  String logoPath;
  int numItems;
  String estimatedDelivery;
  double ratingStars;
  int ratingVotes;
  String ratingVotesStr;
  Color colorMain;
  Color colorText;
  List<FoodModel> menu;

  StoreModel(
      {this.uid,
      this.name,
      this.logoPath,
      this.numItems,
      this.estimatedDelivery,
      this.ratingStars,
      this.ratingVotes,
      this.colorMain,
      this.colorText});

  StoreModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    try {
      var data = doc.data();
      this.uid = doc.id;
      this.name = data["name"] as String;
      this.logoPath = data["logo_path"] != null
          ? (data["logo_path"] as String)
          : "https://cdn.worldvectorlogo.com/logos/burger-king-4.svg";
      this.numItems = data["num_items"] as int;
      this.estimatedDelivery = data["estimated_delivery"] as String;
      this.ratingStars = data["rating_stars"] as double;
      this.ratingVotes = data["rating_votes"] as int;
      this.colorMain = Color(int.parse(data["color_main"]));
      this.colorText = Color(int.parse(data["color_text"]));

      // Round rating votes to nearest thousand.
      double thousand =
          ((data["rating_votes"] as int) / pow(10, 2)).roundToDouble() / 10;
      this.ratingVotesStr =
          (thousand >= 1) ? "${thousand}k" : this.ratingVotes.toString();
    } catch (e) {
      print(e);
    }
  }
}
