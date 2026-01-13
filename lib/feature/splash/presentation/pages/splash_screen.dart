import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training/core/storage/storage_service.dart';
import 'package:training/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:training/feature/profile/presentation/bloc/profile_event.dart';
import 'package:training/feature/profile/presentation/bloc/profile_state.dart';

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
      // Token exists → fetch profile
      // ignore: use_build_context_synchronously
      final profileBloc = context.read<ProfileBloc>();
      profileBloc.add(GetProfileEvent());
    } else {
      // No token → go to login
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            // Profile loaded → go to dashboard
            context.go('/dashboard');
          } else if (state is ProfileError) {
            // Profile failed → go to login
            context.go('/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('asset/images/logo.png', width: 200, height: 100),
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
