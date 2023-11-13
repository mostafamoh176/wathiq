import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/features/cart/data/model/cart_model.dart';
import 'package:theka_task/features/favorites/data/model/favorite_model.dart';

abstract class GetRemoteDataFavorite {
  Future<List<FavoriteModel>> fetchAllFavorite();
}

class GetAllRemoteDataFavImpl implements GetRemoteDataFavorite {
  @override
  Future<List<FavoriteModel>> fetchAllFavorite() async {
    //! get List of facorite
    try {
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('FavoriteModel');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();

      List<FavoriteModel> favList =
          querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return FavoriteModel.fromJson(doc.data()!);
      }).toList();

      return favList;
    } catch (e) {
      print('Error fetching data: $e');
      throw ServerException();
    }
  }
}
