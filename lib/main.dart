import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud_app/cubit/news_bloc.dart';
import 'package:news_cloud_app/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
