import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:theka_task/features/favorites/data/data_source/fav_remote_data_source.dart';
import 'package:theka_task/features/favorites/data/repository_impl/get_all_fav.dart';
import 'package:theka_task/features/favorites/domain/repository/get_all_fav_repo.dart';
import 'package:theka_task/features/favorites/domain/use_cases/get_all_fav_usecase.dart';
import 'package:theka_task/features/favorites/presentation/business_logic/fav_bloc.dart';
import 'package:theka_task/features/notifications_feature/data/data_source/remote_data_source_noti.dart';
import 'package:theka_task/features/notifications_feature/data/repository_impl/get_all_notification_repo_impl.dart';
import 'package:theka_task/features/notifications_feature/domain/repository/get_all_noti.dart';
import 'package:theka_task/features/notifications_feature/domain/use_cases/get_all_notification_usecase.dart';
import 'package:theka_task/features/notifications_feature/presentation/business_logic/noti_bloc.dart';
import 'package:theka_task/features/settings/domain/use_cases/cash_Credit_details.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theka_task/core/util/dio_helper.dart';
import 'package:theka_task/core/util/network.dart';
import 'package:theka_task/features/cart/data/data_source/remote_data_source.dart';
import 'package:theka_task/features/cart/data/repository_impl/get_all_repository_impl.dart';
import 'package:theka_task/features/cart/domain/repository/get_all_carts.dart';
import 'package:theka_task/features/cart/domain/use_cases/get_all_cart_usecase.dart';
import 'package:theka_task/features/cart/presentation/business_logic/cart_bloc.dart';
import 'package:theka_task/features/home_feature/data/data_source/remote_dat_source.dart';
import 'package:theka_task/features/home_feature/data/repository_impl/get_all_product_repository_impl.dart';
import 'package:theka_task/features/home_feature/domain/repository/get_product_details.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/add_product_to_cart.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/favorite_product.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/get_all_banner.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/get_all_product.dart';
import 'package:theka_task/features/home_feature/presentation/businees_logic/product_bloc.dart';
import 'package:theka_task/features/settings/data/data_source/local_data_source.dart';
import 'package:theka_task/features/settings/data/repository_impl/cashed_cards_repository_impl.dart';
import 'package:theka_task/features/settings/domain/repository/cashed_credit_card.dart';
import 'package:theka_task/features/settings/domain/use_cases/check_clear_card.dart';
import 'package:theka_task/features/settings/presentation/business_logic/bloc/setting_bloc_bloc.dart';
import 'package:theka_task/features/notifications_feature/data/data_source/remote_data_source_noti.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Bloc
  sl.registerFactory(() => ProductBloc(
      getAllProductUseCase: sl(),
      favProductUsecase: sl(),
      getAllBannerUseCase: sl(),
      addProductToCart: sl()));
  sl.registerFactory(() => CartBloc(getAllCartUseCase: sl()));
  sl.registerFactory(() => FavBloc(getAllFavUseCase: sl()));

  sl.registerFactory(() => NotificationBloc(getAllNotificationUsecase: sl()));
  sl.registerFactory(() =>
      SettingBlocBloc(cashCreditUseCase: sl(), cashCreditDataUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => CashCreditUseCase(creditCardRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllNotificationUsecase(getAllNotificationRepo: sl()));
  sl.registerLazySingleton(
      () => GetAllProductUseCase(productDetailsrepository: sl()));
  sl.registerLazySingleton(() => FavProductUsecase(sl()));
  sl.registerLazySingleton(
      () => GetAllBannerUseCase(productDetailsrepository: sl()));
  sl.registerLazySingleton(
      () => AddProductToCart(productDetailsRepository: sl()));
  sl.registerLazySingleton(() => GetAllCartUseCase(getAllCartRepository: sl()));
  sl.registerLazySingleton(() => GetAllFsvUseCase(getAllFavRepository: sl()));

  sl.registerLazySingleton(
      () => CashCreditDataUseCase(creditCardRepository: sl()));
// Repository
  sl.registerLazySingleton<ProductDetailsRepository>(
    () => GetAllProductRepositoryImpl(
      productRemoteData: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<GetAllNotificationRepo>(
    () => GetAllNotificationsRepoImpl(getRemoteNotificationData: sl()),
  );
  sl.registerLazySingleton<GetAllCartRepository>(
    () => GetAllCartRepositoryImpl(
      networkInfo: sl(),
      getRemoteData: sl(),
    ),
  );

  sl.registerLazySingleton<GetAllFavRepository>(
    () => GetAllFavRepositoryImpl(
      networkInfo: sl(),
      getRemoteDataFavorite: sl(),
    ),
  );
  sl.registerLazySingleton<CreditCardRepository>(
    () => CashedCardsRepositoryImpl(localDataSource: sl()),
  );
// Datasources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());
  sl.registerLazySingleton<GetRemoteData>(() => GetAllRemoteDataCartImpl());
  sl.registerLazySingleton<GetRemoteDataFavorite>(
      () => GetAllRemoteDataFavImpl());

  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<GetRemoteNotificationData>(
      () => GetAllRemoteDataNotificationImpl());

// Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Firebase.initializeApp());
}
