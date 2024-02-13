import 'package:flutter/material.dart';
import 'package:my_bot/Provider/MessageProvider.dart';
import 'package:my_bot/Screens/HomeScreen.dart';
import 'package:my_bot/Screens/ProfileScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MessageProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Bot',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true
        ),
        routes: {
          'home' : (context) => const HomeScreen(),
          'profile' : (context) => const ProfileScreen(),
        },
        initialRoute: 'home',
      ),
    );
  }
}
