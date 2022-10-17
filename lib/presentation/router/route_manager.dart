
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/data/models/category_widget_input.dart';
import 'package:salaya_delivery_app/data/models/shipping_type.dart';
import 'package:salaya_delivery_app/presentation/screens/basket/basket_page.dart';
import 'package:salaya_delivery_app/presentation/screens/category/category_page.dart';
import 'package:salaya_delivery_app/presentation/screens/checkout/checkout_page.dart';
import 'package:salaya_delivery_app/presentation/screens/dashboard/dashboard_page.dart';
import 'package:salaya_delivery_app/presentation/screens/product_details/product_details_page.dart';
import 'package:salaya_delivery_app/presentation/screens/search/search_page.dart';

class Routes {
  static const String dashboardRoute = '/';
  static const String basketRoute = '/basket';
  static const String categoryRoute  = '/category';
  static const String checkoutRoute = '/checkout';
  static const String productDetailsRoute = '/productDetails';
  static const String searchRoute = '/search';
}

class RouteGenerator {

  static Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case Routes.dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case Routes.basketRoute:
        return MaterialPageRoute(builder: (_) => const BasketPage());
      case Routes.categoryRoute:
        if (args is CategoryWidgetInput) {
          return MaterialPageRoute(builder: (_) => CategoryPage(input: args,));
        }
        return MaterialPageRoute(builder: (_) => const CategoryPage());
      case Routes.checkoutRoute:
        if (args is ShippingType) {
          return MaterialPageRoute(builder: (_) => CheckoutPage(shippingType: args,));
        }
        return unDefinedRoute();
      case Routes.productDetailsRoute:
        if (args is String) {
          return MaterialPageRoute(builder: (_) => ProductDetailsPage(productId: args,));
        }
        return unDefinedRoute();
      case Routes.searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_)=> Scaffold(
          appBar: AppBar(title: const Text('Not Found'),),
          body: const Center(child: Text('Not Found'),),
        )
    );
  }
}