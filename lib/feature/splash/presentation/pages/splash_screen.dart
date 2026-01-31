import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gheero/core/storage/storage_service.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_event.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndLoadProfile();
  }

  Future<void> _checkTokenAndLoadProfile() async {
    final token = await StorageService.getToken();
    if (token != null) {
      final profileBloc = context.read<ProfileBloc>();
      profileBloc.add(GetProfileEvent());
    } else {
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            context.go('/dashboard');
          } else if (state is ProfileError) {
            context.go('/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('asset/images/gheero.png', width: 200, height: 100),
              const SizedBox(height: 10),
              const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
