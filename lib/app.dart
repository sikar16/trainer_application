import 'package:flutter/material.dart';
import 'package:gheero/app_bloc_provider.dart';
import 'package:gheero/core/router/route.dart';
import 'package:gheero/core/theme/theme.dart';
import 'package:gheero/core/theme/util.dart';

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
