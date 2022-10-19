import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaya_delivery_app/core/themes/theme_manager.dart';
import 'package:salaya_delivery_app/data/repositories/local/local_product_repository.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_branch_repository.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_category_repository.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_checkout_repository.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/branch/branch_bloc.dart';
import 'package:salaya_delivery_app/logic/debug/app_bloc_observer.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Bloc.observer = AppObserver();
  runApp(MyApp(sharedPreferences: prefs,));
}

class MyApp extends StatelessWidget {

  final SharedPreferences sharedPreferences;

  const MyApp({
    Key? key,
    required this.sharedPreferences
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RemoteCategoryRepository>(create: (context) => RemoteCategoryRepository()),
        RepositoryProvider<RemoteCheckoutRepository>(create: (context) => RemoteCheckoutRepository()),
        RepositoryProvider<RemoteBranchRepository>(create: (context) => RemoteBranchRepository()),
        RepositoryProvider<RemoteProductRepository>(create: (context) => RemoteProductRepository()),
        RepositoryProvider<LocalProductRepository>(create: (context) => LocalProductRepository(prefs: sharedPreferences))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BasketBloc>(create: (context) => BasketBloc()),
          BlocProvider<BranchBloc>(create: (context) => BranchBloc(
            remoteBranchRepository: context.read<RemoteBranchRepository>()))
        ],
        child: MaterialApp(
          title: 'Salaya Delivery',
          debugShowCheckedModeBanner: false,
          theme: getThemeApplication(),
          initialRoute: Routes.dashboardRoute,
          onGenerateRoute: RouteGenerator.getRoute,
        )
      )
    );
  }
}
