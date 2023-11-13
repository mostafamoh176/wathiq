import 'package:flutter/cupertino.dart';
import 'package:theka_task/core/util/paths.dart';
import 'package:theka_task/features/bottom_nav_bar_feature/presentation/view/bottom_nav_view.dart';
import 'package:theka_task/features/cart/presentation/view/cart_screen.dart';
import 'package:theka_task/features/checkout_payment/presentation/view/checkout_screen.dart';
import 'package:theka_task/features/favorites/presentation/view/favorite_screen.dart';
import 'package:theka_task/features/home_feature/presentation/view/item_details.dart';
import 'package:theka_task/features/notifications_feature/presentation/view/notifications.dart';
import 'package:theka_task/features/settings/presentation/view/settings_screen.dart';
import 'package:theka_task/features/settings/presentation/view/wallet_screen.dart';

class Routes {
  // Private constructor
  Routes._();

  // Singleton instance
  static final Routes _instance = Routes._();

  // Factory method to access the singleton instance
  factory Routes() {
    return _instance;
  }

  Map<String, WidgetBuilder> get routes => {
        Paths.HOME: (context) => BottomNavBarView(),
        Paths.CART: (context) => const CartScreen(),
        Paths.NOTIFICATIONS: (context) => const NotificationsScreen(),
        Paths.FAVORITES: (context) => const FavoriteScreen(),
        Paths.SETTINGS: (context) => const SettingsScreen(),
        Paths.CARD_DETAILS: (context) => const ProductDetsils(),
        Paths.CHECKOUT: (context) => const CheckOutScreen(),
        Paths.CREDITCARD: (context) => CreditCardScreen(),
        Paths.BOTTOMNAVBAR: (context) => BottomNavBarView(),
      };

  // Access the singleton instance
  static Routes get instance => _instance;
}
