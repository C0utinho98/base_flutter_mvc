import 'package:base/app/controllers/auth/auth_controller.dart';
import 'package:base/app/services/analytics_service.dart';
import 'package:base/app/shared/routes/app_routes.dart';
import 'package:base/app/views/widgets/auth_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final _analyticsService = AnalyticsService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new AuthController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        navigatorObservers: [_analyticsService.getAnalyticsObserver()],
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
        },
      ),
    );
  }
}
