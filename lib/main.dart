import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_autorun_issue/store.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Provider(
      create: (_) => AppState()..initialize(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ReactionBuilder(
        builder: (context) {
          return autorun(
            (_) {
              print("A reaction has been triggered!");
            },
          );
        },
        child: Observer(
          name: "CurrentScreen",
          builder: (context) {
            switch (context.read<AppState>().currentPage) {
              case AppPage.splash:
                return const MySplashPage(title: "Splash Page");
              case AppPage.home:
                return const MySplashPage(title: "Home Page");
              case AppPage.login:
                return const Placeholder();
            }
          },
        ),
      ),
    );
  }
}

class MySplashPage extends StatefulWidget {
  const MySplashPage({super.key, required this.title});

  final String title;

  @override
  State<MySplashPage> createState() => _MySpashPageState();
}

class _MySpashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Am action has been fired!");
          context.read<AppState>().goTo(
                AppPage.home,
              );
        },
        tooltip: 'Smash It.',
        child: const Icon(Icons.app_registration_outlined),
      ),
    );
  }
}
