class Paths {
  // Private constructor
  Paths._();

  // Singleton instance
  static final Paths _instance = Paths._();

  // Factory method to access the singleton instance
  factory Paths() {
    return _instance;
  }

  // Paths
  static const HOME = '/home';
  static const SETTINGS = '/settings';
  static const NOTIFICATIONS = '/notifications';
  static const CART = '/cart';
  static const FAVORITES = '/favorites';
  static const CARD_DETAILS = "/cardDetails";
  static const CHECKOUT = "/checkout";
  static const CREDITCARD = "/creaditCard";
  static const BASEURL = "https://www.cheapshark.com/";
  static const PRODUCTDEALURL = "api/1.0/deals";
  static const BOTTOMNAVBAR = "/bottomNavBar";
}
