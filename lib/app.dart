import 'package:flutter/material.dart';
import 'package:training/app_bloc_provider.dart';
import 'package:training/core/router/route.dart';
import 'package:training/core/theme/theme.dart';
import 'package:training/core/theme/util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    final textTheme = createTextTheme(context, "Roboto", "Roboto");
    final MaterialTheme theme = MaterialTheme(textTheme);

    return AppBlocProviders(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Trainer Application',
        routerConfig: router,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      ),
    );
  }
}
