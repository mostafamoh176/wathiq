import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/features/cart/data/model/cart_model.dart';

abstract class GetRemoteData {
  Future<List<CartModel>> fetchAllProductCart();
}

class GetAllRemoteDataCartImpl implements GetRemoteData {
  @override
  Future<List<CartModel>> fetchAllProductCart() async {
    //! get List of cart from
    try {
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Cart');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();
      print('List of Banners: ${querySnapshot}');

      List<CartModel> cartList =
          querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return CartModel.fromJson(doc.data()!);
      }).toList();

      print('List of Banners: $cartList');

      return cartList;
    } catch (e) {
      print('Error fetching data: $e');
      throw ServerException();
    }
  }
}
