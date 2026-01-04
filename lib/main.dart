import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trainer_application/core/route/route.dart';
import 'package:trainer_application/core/theme/theme.dart';
import 'package:trainer_application/core/theme/util.dart';

import 'package:trainer_application/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:trainer_application/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:trainer_application/feature/auth/domain/usecases/login_usecase.dart';
import 'package:trainer_application/feature/auth/presentation/bloc/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    final textTheme = createTextTheme(context, "Roboto", "Roboto");
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(
            LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Trainer Application',
        routerConfig: router,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      ),
    );
  }
}
