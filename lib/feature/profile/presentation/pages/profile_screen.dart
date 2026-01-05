import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trainer_application/core/widgets/app_drawer.dart';
import 'package:trainer_application/core/widgets/custom_appBar.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../domain/entities/profile_entity.dart';

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

    context.read<ProfileBloc>().add(GetProfileEvent());
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

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate() && _currentProfile != null) {
      final Map<String, dynamic> profileData = {
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phoneNumber': _phoneController.text.trim(),
      };

      if (_currentProfile!.trainer != null) {
        final trainer = _currentProfile!.trainer!;
        profileData['trainer'] = {
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
          'phoneNumber': _phoneController.text.trim(),
          'faydaId': trainer.faydaId,
          'gender': trainer.gender,
          'dateOfBirth': trainer.dateOfBirth,
          'language': {'id': trainer.language.id},
          'zone': {'id': trainer.zone.id},
          if (trainer.city != null) 'city': trainer.city,
          'woreda': trainer.woreda,
          'houseNumber': trainer.houseNumber,
          'location': trainer.location,
          'academicLevel': {'id': trainer.academicLevel.id},
          'trainingTags': trainer.trainingTags
              .map((tag) => {'id': tag.id})
              .toList(),
          'experienceYears': trainer.experienceYears,
          'coursesTaught': trainer.coursesTaught,
          'certifications': trainer.certifications,
        };
      }

      context.read<ProfileBloc>().add(EditProfileEvent(profileData));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileEditSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Profile updated successfully"),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: colorScheme.primary,
            ),
          );
          setState(() => _isEditing = false);
          context.read<ProfileBloc>().add(GetProfileEvent());
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: colorScheme.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
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
            if (state is ProfileLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Loading profile...",
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

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
                      _buildProfileHeader(
                        context,
                        profile,
                        colorScheme,
                        textTheme,
                      ),

                      const SizedBox(height: 24),

                      _buildProfileInfoCards(profile, colorScheme, textTheme),

                      if (_isEditing) _buildEditModeActions(),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileError) {
              return _buildErrorState(context, state, colorScheme, textTheme);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  /// Profile Header Widget
  Widget _buildProfileHeader(
    BuildContext context,
    ProfileEntity profile,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.person_outline, color: colorScheme.primary, size: 24),
            const SizedBox(width: 12),
            Text(
              "Personal Information",
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ],
        ),
        if (!_isEditing)
          IconButton(
            onPressed: () => _startEditing(profile),
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 22,
                color: colorScheme.primary,
              ),
            ),
            tooltip: "Edit Profile",
          ),
      ],
    );
  }

  Widget _buildProfileInfoCards(
    ProfileEntity profile,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      children: [
        _infoTile(
          icon: Icons.person_outline,
          label: "First Name",
          child: _isEditing
              ? _input(_firstNameController)
              : Text(
                  profile.firstName,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
        _infoTile(
          icon: Icons.person_outline,
          label: "Last Name",
          child: _isEditing
              ? _input(_lastNameController)
              : Text(
                  profile.lastName,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
        _infoTile(
          icon: Icons.email_outlined,
          label: "Email Address",
          child: _isEditing
              ? _input(_emailController, keyboard: TextInputType.emailAddress)
              : Text(
                  profile.email,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
        _infoTile(
          icon: Icons.phone_outlined,
          label: "Phone Number",
          child: _isEditing
              ? _input(_phoneController, keyboard: TextInputType.phone)
              : Text(
                  profile.phoneNumber,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildEditModeActions() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// Cancel Button
          OutlinedButton.icon(
            onPressed: _cancelEditing,
            icon: const Icon(Icons.close, size: 18),
            label: const Text("Cancel"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: Colors.grey[400]!),
            ),
          ),
          const SizedBox(width: 12),

          ElevatedButton.icon(
            onPressed: _saveProfile,
            icon: const Icon(Icons.check, size: 18),
            label: const Text("Save Changes"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    ProfileError state,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Unable to load profile",
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<ProfileBloc>().add(GetProfileEvent()),
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text("Try Again"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "This field is required" : null,
    );
  }
}
