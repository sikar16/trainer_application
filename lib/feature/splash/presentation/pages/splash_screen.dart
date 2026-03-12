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
      if (mounted) context.push('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            context.push('/training');
          } else if (state is ProfileError) {
            context.push('/login');
          }
        },
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/gheeroHwhite.png',
                    width: 200,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Positioned(
            //   bottom: 3,
            //   right: 5,
            //   child: Container(
            //     padding: const EdgeInsets.only(
            //       left: 16,
            //       top: 8,
            //       right: 0,
            //       bottom: 0,
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: const BorderRadius.only(
            //         topLeft: Radius.circular(8),
            //         bottomLeft: Radius.circular(8),
            //       ),
            //     ),
            //     child: Text(
            //       'Trainer App',
            //       style: TextStyle(
            //         color: colorScheme.primary,
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
