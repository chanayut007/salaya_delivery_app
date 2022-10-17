import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salaya_delivery_app/core/themes/theme_manager.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salaya Delivery',
      theme: getThemeApplication(),
      initialRoute: Routes.dashboardRoute,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
