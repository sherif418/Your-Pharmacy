import 'package:get_it/get_it.dart';
import 'package:flutter_application_1/services/firebase_core_service.dart';

// Repositories
import 'package:flutter_application_1/features/auth/data/auth_repository.dart';
import 'package:flutter_application_1/features/orders/data/orders_repository.dart';
// import 'package:flutter_application_1/features/chronic_meds/data/chronic_meds_repository.dart';
import 'package:flutter_application_1/features/pharmacist/data/pharmacist_repository.dart';

// Blocs
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/orders/bloc/orders_bloc.dart';
// import 'package:flutter_application_1/features/chronic_meds/bloc/chronic_meds_bloc.dart';
import 'package:flutter_application_1/features/pharmacist/bloc/pharmacist_orders_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Core services
  getIt.registerLazySingleton<FirebaseCoreService>(() => FirebaseCoreService());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<OrdersRepository>(() => OrdersRepository());
  // getIt.registerLazySingleton<ChronicMedsRepository>(() => ChronicMedsRepository());
  getIt.registerLazySingleton<PharmacistRepository>(() => PharmacistRepository());

  // Blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<OrdersBloc>(
    () => OrdersBloc(ordersRepository: getIt<OrdersRepository>()),
  );
  // getIt.registerFactory<ChronicMedsBloc>(
  //   () => ChronicMedsBloc(repository: getIt<ChronicMedsRepository>()),
  // );
  getIt.registerFactory<PharmacistOrdersBloc>(
    () => PharmacistOrdersBloc(repository: getIt<PharmacistRepository>()),
  );
}
