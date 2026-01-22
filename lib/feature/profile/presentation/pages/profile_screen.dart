import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/core/snack_bar/snack_bar_widget.dart';

import 'package:training/core/widgets/app_drawer.dart';
import 'package:training/core/widgets/custom_appbar.dart';
import 'package:training/feature/profile/presentation/widgets/edit_mode_actions.dart';
import 'package:training/feature/profile/presentation/widgets/error_state.dart';
import 'package:training/feature/profile/presentation/widgets/loading_state.dart';
import 'package:training/feature/profile/presentation/widgets/profile_header.dart';
import 'package:training/feature/profile/presentation/widgets/profile_info.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../domain/entities/profile_entity.dart';
import '../../data/models/edit_profile_request_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  ProfileEntity? _currentProfile;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    final profileBloc = context.read<ProfileBloc>();
    if (profileBloc.state is! ProfileLoaded) {
      context.read<ProfileBloc>().add(GetProfileEvent());
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _startEditing(ProfileEntity profile) {
    setState(() {
      _isEditing = true;
      _currentProfile = profile;
      _firstNameController.text = profile.firstName;
      _lastNameController.text = profile.lastName;
      _emailController.text = profile.email;
      _phoneController.text = profile.phoneNumber;
    });
  }

  void _cancelEditing() => setState(() => _isEditing = false);

  void _saveProfile() {
    if (!_formKey.currentState!.validate() || _currentProfile == null) return;
    final request = EditProfileRequestModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
    );

    context.read<ProfileBloc>().add(EditProfileEvent(request));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileEditSuccess) {
          CustomSnackBar.success(context, "Profile updated successfully");
          setState(() => _isEditing = false);
          context.read<ProfileBloc>().add(GetProfileEvent());
        } else if (state is ProfileError) {
          CustomSnackBar.error(context, state.message);
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(),
        appBar: CustomAppBar(
          title: "Profile",
          onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
          onNotificationTap: () {},
          onProfileTap: () {},
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) return LoadingState(colorScheme);

            if (state is ProfileLoaded) {
              final profile = state.profile;
              if (!_isEditing) _currentProfile = profile;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(
                        profile: profile,
                        isEditing: _isEditing,
                        onEdit: _startEditing,
                      ),
                      const SizedBox(height: 24),
                      ProfileInfo(
                        profile: profile,
                        isEditing: _isEditing,
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                      ),
                      if (_isEditing)
                        EditModeActions(
                          onCancel: _cancelEditing,
                          onSave: _saveProfile,
                        ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileError) {
              return ErrorState(
                message: state.message,
                onRetry: () =>
                    context.read<ProfileBloc>().add(GetProfileEvent()),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
