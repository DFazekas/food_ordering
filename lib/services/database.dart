import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/models/food.dart';
import 'package:food_ordering/models/store.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});

  /// Stream all store documents.
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

  /// Stream all food documents from a single store, specified by their uid.
  Stream<List<FoodModel>> streamFood({String uid}) {
    try {
      return firestore
          .collection("stores")
          .doc(uid)
          .collection("menu")
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

  /// Add a Store object to Firestore.
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

  /// Add a Food object to the menu collection, given a Store's UID.
  Future<void> addFoodToStore(
      {StoreModel store, FoodModel food, bool, isDefault = false}) async {
    try {
      if (isDefault == true) {
        food = FoodModel(
            description: "Our fries are the best in...",
            imagePath:
                "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
            name: "Fries",
            oldPrice: "5.43",
            onSale: true,
            price: "4.23");
      }
      await firestore
          .collection("stores")
          .doc(store.uid)
          .collection("menu")
          .add({
        "name": food.name,
        "description": food.description,
        "image_path": food.imagePath,
        "old_price": food.oldPrice,
        "price": food.price,
        "on_sale": food.onSale
      });
    } catch (e) {
      print(e);
    }
  }
}
