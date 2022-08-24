import 'package:flutter/material.dart';
import 'package:flutter_myshopingreceipt/nvvm/view/dashboard.dart';
import 'package:flutter_myshopingreceipt/nvvm/view/form_add_receipt.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      // case LoginScreen.routeName:
      //   return MaterialPageRoute(builder: (context) {
      //     CustomProgressDialog.context = context;
      //     return LoginScreen();
      //   });
      case Dashboard.routeName:
        return MaterialPageRoute(builder: (context) {
          return Dashboard();
        });
      case FormAddReceipt.routeName:
        return MaterialPageRoute(builder: (context) {
          return FormAddReceipt();
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Route Error'),
        ),
        body: const Center(
          child: Text('Route Error'),
        ),
      );
    });
  }
}
