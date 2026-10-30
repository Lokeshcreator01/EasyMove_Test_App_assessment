import 'package:easymove/features/homescreen/data/dataSources/realestate_data_source.dart';
import 'package:easymove/features/homescreen/data/repositories/realestate_repositories_impl.dart';
import 'package:easymove/features/homescreen/domain/useCases/realestate_use_case.dart';
import 'package:easymove/features/homescreen/presentation/cubit/realestate_cubit.dart';
import 'package:easymove/features/login_screen/data/DataSource/user_entity_datasource.dart';
import 'package:easymove/features/login_screen/data/Repositories/user_entity_repositories_impl.dart';
import 'package:easymove/features/login_screen/domain/useCases/user_use_case.dart'
    as auth;
import 'package:easymove/features/login_screen/presentation/cubit/user_cubit.dart';
import 'package:easymove/features/login_screen/presentation/pages/login_page.dart';
import 'package:easymove/features/login_screen/data/storage/auth_storage.dart';
import 'package:easymove/features/homescreen/presentation/pages/home_screen.dart';
import 'package:easymove/features/Services_screen/data/datasource/Services_data_source.dart';
import 'package:easymove/features/Services_screen/data/repositories/Srevices_repositories_impl.dart';
import 'package:easymove/features/Services_screen/domain/useCauses/Services_use_Causes.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_cubit.dart';
import 'package:easymove/features/Services_screen/presentation/pages/service_screen_onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedToken = await AuthStorage().getToken();
  final realestateCubit = RealestateCubit(
    UserUseCase(
      RealestateRepositoriesImpl(
        realestateDataSource: RealestateDataSourceImpl(),
      ),
    ),
  );
  final userCubit = UserCubit(
    auth.UserUseCase(
      UserRepositoriesImpl(userDataSource: UserDataSourceImpl()),
    ),
  );
  final servicesCubit = ServicesCubit(
    ServicesUseCase(
      ServicesRepositoriesImpl(servicesDataSource: ServicesDataSourceImpl()),
    ),
  );
  final hasSeenOnboarding = await AuthStorage().hasSeenOnboarding();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: realestateCubit),
        BlocProvider.value(value: userCubit),
        BlocProvider.value(value: servicesCubit),
      ],
      child: MyApp(
        isAuthenticated: savedToken?.isNotEmpty == true,
        hasSeenOnboarding: hasSeenOnboarding,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.isAuthenticated,
    required this.hasSeenOnboarding,
    super.key,
  });

  final bool isAuthenticated;
  final bool hasSeenOnboarding;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: !hasSeenOnboarding
          ? const ServiceScreenOnboard()
          : isAuthenticated
          ? const HomeScreen()
          : const LoginPage(),
    );
  }
}
