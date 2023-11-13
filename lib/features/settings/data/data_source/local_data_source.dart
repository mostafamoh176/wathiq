import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/features/settings/data/model/credit_card_model.dart';

abstract class LocalDataSource {
  Future<List<CardModel>> getCachedCredit();
  Future cacheCredit(List<CardModel> cardsModel);
  Future<void> deleteAllDocuments();
}

const String CACHED_CARDS = "CACHED_CARDS";

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future cacheCredit(List<CardModel> cardModels) {
    List cardsModelsToJson = cardModels
        .map<Map<String, dynamic>>((cardModel) => cardModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_CARDS, json.encode(cardsModelsToJson));
    return Future.value();
  }

  @override
  Future<List<CardModel>> getCachedCredit() {
    final jsonString = sharedPreferences.getString(CACHED_CARDS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CardModel> jsonToPostModels = decodeJsonData
          .map<CardModel>((jsonPostModel) => CardModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }

  void main() async {
    await deleteAllDocuments();
  }

  @override
  Future<void> deleteAllDocuments() async {
    // Reference to the Firestore collection
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('Cart');

    // Get all documents in the collection
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collection.get();

    // Delete all documents in the collection
    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      await document.reference.delete();
    }

    print('All documents in the collection deleted successfully');
  }
}
