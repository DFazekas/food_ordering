import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/models/food.dart';
import 'package:food_ordering/models/store.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});

  Stream<List<StoreModel>> streamStores({String uid}) {
    try {
      return firestore.collection(uid).get().then((query) {
        List<StoreModel> retVal = <StoreModel>[];
        query.docs.forEach((doc) {
          retVal.add(StoreModel.fromDocumentSnapshot(doc: doc));
        });
        return retVal;
      }).asStream();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<FoodModel>> streamFood({String uid}) {
    try {
      return firestore
          .collection("stores")
          .doc("store_01")
          .collection("menu")
          // .collection("menu")
          .get()
          .then((query) {
        List<FoodModel> retVal = <FoodModel>[];
        query.docs.forEach((QueryDocumentSnapshot doc) {
          retVal.add(FoodModel.fromDocumentSnapshot(doc: doc));
        });
        return retVal;
      }).asStream();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addStore({StoreModel store, bool isDefault = false}) async {
    try {
      if (isDefault == true) {
        store = StoreModel(
            name: "McDonalds",
            logoPath: "https://cdn.worldvectorlogo.com/logos/burger-king-4.svg",
            numItems: 0,
            estimatedDelivery: "5-10 min",
            ratingStars: 3.6,
            ratingVotes: 281,
            colorMain: Color(0xFFFFE9C6),
            colorText: Color(0xFFDA9551));
      }

      await firestore.collection("stores").add({
        "name": store.name,
        "logo_path": store.logoPath,
        "num_items": store.numItems,
        "rating_stars": store.ratingStars,
        "rating_votes": store.ratingVotes,
        "estimated_delivery": store.estimatedDelivery,
        "color_main": store.colorMain.value.toString(),
        "color_text": store.colorText.value.toString(),
      });
    } catch (e) {
      rethrow;
    }
  }
}
