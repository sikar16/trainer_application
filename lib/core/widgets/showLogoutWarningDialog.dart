import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gheero/core/snack_bar/snack_bar_widget.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_event.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_state.dart';

void showLogoutWarningDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            CustomSnackBar.success(context, "Logout sucessfully");
            context.pop();
            context.go('/login');
          } else if (state is ProfileError) {
            CustomSnackBar.error(context, state.message);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 24),
                  SizedBox(width: 8),
                  Text('Logout Warning', style: TextStyle(color: Colors.black)),
                ],
              ),
              content: Text(
                'Are you sure you want to log out?',
                style: TextStyle(color: Colors.black54),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                state is ProfileLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          context.read<ProfileBloc>().add(LogoutEvent());
                        },
                        child: Text('Logout'),
                      ),
              ],
            );
          },
        ),
      );
    },
  );
}
