import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_app/app_router.dart';
import 'package:new_app/web_services/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.dolphinWebServices();
  runApp( DolphinApp(appRouter: AppRouter()));
}

class DolphinApp extends StatelessWidget {
 final AppRouter appRouter;
  DolphinApp( {super.key,required this.appRouter});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}


