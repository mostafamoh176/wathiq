import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/core/util/dio_helper.dart';
import 'package:theka_task/core/util/paths.dart';
import 'package:theka_task/features/home_feature/data/model/banner_model.dart';
import 'package:theka_task/features/home_feature/data/model/item_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProductModel();
  Future<Unit> favProductsDpcument(ProductModel productModel);
  Future<List<BannerModel>> getAllBannerModel();
  Future<Unit> addProductToCart(
      {required ProductModel productModel, required int numberOfItem});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl();
  @override
  Future<List<ProductModel>> getAllProductModel() async {
    final Response response =
        await DioHelper.getData(url: Paths.PRODUCTDEALURL);

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      List<ProductModel> product =
          responseData.map((json) => ProductModel.fromJson(json)).toList();
      return product;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> favProductsDpcument(ProductModel productModel) async {
    try {
      // Get a reference to Firestore collection
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('favorite_collection');

      // Add a new document with a reference to another document
      DocumentReference<Map<String, dynamic>> newDocumentReference =
          await collection.add({
        'name': productModel.internalName,
        'image': productModel.thumb,
        'price': productModel.normalPrice,
        'referenceField': FirebaseFirestore.instance
            .collection('other_collection')
            .doc('other_document_id'),
      });

      print('Document added with ID: ${newDocumentReference.id}');
      return Future.value(unit);
    } catch (e) {
      print('Error adding document: $e');
      throw ServerException();
    }
  }

  @override
  Future<List<BannerModel>> getAllBannerModel() async {
    //! get List of banner from
    try {
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('adsBanner');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();
      print('List of Banners: ${querySnapshot}');

      List<BannerModel> bannerList =
          querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return BannerModel.fromJson(doc.data()!);
      }).toList();

      print('List of Banners: $bannerList');

      List<BannerModel> sortedBannerModel = [];

      for (var element in bannerList) {
        if (element.isShow) sortedBannerModel.add(element);
      }

      return sortedBannerModel;
    } catch (e) {
      print('Error fetching data: $e');
      throw ServerException();
    }
  }

  @override
  Future<Unit> addProductToCart(
      {required ProductModel productModel, required int numberOfItem}) async {
    try {
      // Get a reference to Firestore collection
      //! check or update function to check if this document is there
      //! if yes : update it
      //! else: create new document in this collection
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Cart');
      String documentId = productModel.internalName;
      DocumentReference<Map<String, dynamic>> documentRef =
          collection.doc(documentId);
      Map<String, dynamic> newData = {
        'name': productModel.internalName,
        'image': productModel.thumb,
        'price': productModel.normalPrice,
        "id": productModel.gameID,
        "number": numberOfItem
      };
      // Check if the document exists
      bool documentExists = (await documentRef.get()).exists;
      if (documentExists) {
        // Document exists, update the data
        await documentRef.set(newData, SetOptions(merge: true));
        print('Data in Firestore document updated successfully');
      } else {
        // Document does not exist, create a new document
        await documentRef.set(newData);
        print('New Firestore document created successfully');
      }

      return Future.value(unit);
    } catch (e) {
      throw ServerException();
    }
  }
}
