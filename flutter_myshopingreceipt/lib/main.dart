import 'package:flutter/material.dart';
import 'package:flutter_myshopingreceipt/nvvm/view_model/dashboard_viewmodel.dart';
import 'package:flutter_myshopingreceipt/nvvm/view_model/formaddreceipt_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_myshopingreceipt/nvvm/view/dashboard.dart';
import 'package:flutter_myshopingreceipt/routes_generator.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => FormAddReceiptViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Shoping Receipt',
      initialRoute: Dashboard.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
