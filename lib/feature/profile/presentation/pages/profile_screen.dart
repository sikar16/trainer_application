import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gheero/core/snack_bar/snack_bar_widget.dart';

import 'package:gheero/core/widgets/app_drawer.dart';
import 'package:gheero/core/widgets/custom_appbar.dart';

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
  late TextEditingController _countryCodeController;
  late TextEditingController _phoneController;

  ProfileEntity? _currentProfile;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _countryCodeController = TextEditingController(text: '+251');
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
    _countryCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _startEditing(ProfileEntity profile) {
    final phoneNumber = profile.phoneNumber;
    String countryCode = '+251';
    String phone = phoneNumber;

    if (phoneNumber.startsWith('+')) {
      for (int i = 4; i <= 5; i++) {
        if (phoneNumber.length > i) {
          countryCode = phoneNumber.substring(0, i);
          phone = phoneNumber.substring(i);
          break;
        }
      }
    }

    setState(() {
      _isEditing = true;
      _currentProfile = profile;
      _firstNameController.text = profile.firstName;
      _lastNameController.text = profile.lastName;
      _emailController.text = profile.email;
      _countryCodeController.text = countryCode;
      _phoneController.text = phone;
    });
  }

  void _cancelEditing() => setState(() => _isEditing = false);

  void _saveProfile() {
    if (!_formKey.currentState!.validate() || _currentProfile == null) return;
    final request = EditProfileRequestModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber:
          '${_countryCodeController.text.trim()}${_phoneController.text.trim()}',
    );

    context.read<ProfileBloc>().add(EditProfileEvent(request));
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
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
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ProfileEntity profile) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              decoration: const BoxDecoration(shape: BoxShape.circle),
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

  Widget _buildInputField(
    BuildContext context,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    String? hint,
    bool readOnly = false,
    String? Function(String?)? validator,
    int? errorMaxLines,
    void Function(String)? onChanged,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      readOnly: readOnly,
      onChanged: onChanged,
      style: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: readOnly ? Colors.grey[600] : null,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(16),
        hintText: hint,
        errorMaxLines: errorMaxLines,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: readOnly ? Colors.grey[200]! : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: readOnly ? Colors.grey[300]! : colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        filled: true,
        fillColor: readOnly ? Colors.grey[100] : Colors.grey[50],
      ),
      validator:
          validator ??
          (value) =>
              value == null || value.isEmpty ? "This field is required" : null,
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: const Offset(0, 0),
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
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Icon(icon, size: 20, color: colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: textTheme.bodyMedium?.copyWith(
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

  Widget _buildProfileInfo(ProfileEntity profile) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        _buildInfoTile(
          context: context,
          icon: Icons.person_outline,
          label: "First Name",
          child: _isEditing
              ? _buildInputField(context, _firstNameController)
              : Text(
                  profile.firstName,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
        _buildInfoTile(
          context: context,
          icon: Icons.person_outline,
          label: "Last Name",
          child: _isEditing
              ? _buildInputField(context, _lastNameController)
              : Text(
                  profile.lastName,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
        _buildInfoTile(
          context: context,
          icon: Icons.email_outlined,
          label: "Email Address",
          child: _isEditing
              ? _buildInputField(
                  context,
                  _emailController,
                  keyboard: TextInputType.emailAddress,
                  readOnly: true,
                )
              : Text(
                  profile.email,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
        _buildInfoTile(
          context: context,
          icon: Icons.phone_outlined,
          label: "Phone Number",
          child: _isEditing
              ? Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildInputField(
                        context,
                        _countryCodeController,
                        keyboard: TextInputType.phone,
                        hint: '+251',
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: _buildInputField(
                        context,
                        _phoneController,
                        keyboard: TextInputType.phone,
                        hint: '923456541',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }

                          final cleanPhone = value.replaceAll(
                            RegExp(r'\D'),
                            '',
                          );

                          if (cleanPhone.length != 9) {
                            return 'Phone number must be 9 digits';
                          }

                          if (!cleanPhone.startsWith('7') &&
                              !cleanPhone.startsWith('9')) {
                            return 'Phone number must start with 7 or 9';
                          }

                          return null;
                        },
                        errorMaxLines: 2,
                        onChanged: (value) {
                          _phoneController.value = TextEditingValue(
                            text: value,
                            selection: TextSelection.collapsed(
                              offset: value.length,
                            ),
                          );
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Text(
                          _countryCodeController.text,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Text(
                          _phoneController.text,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildEditModeActions(bool isLoading) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
            onPressed: isLoading ? null : _saveProfile,
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.check, size: 18),
            label: Text(isLoading ? "Saving..." : "Save Changes"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 2,
            ),
          ),
        ],
      ),
    );
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
            ProfileEntity? profile;
            bool isLoading = false;
            String? errorMessage;

            if (state is ProfileLoading) {
              isLoading = true;
              if (_currentProfile != null) {
                profile = _currentProfile;
              }
            } else if (state is ProfileLoaded) {
              profile = state.profile;
              if (!_isEditing) {
                _currentProfile = profile;

                final phoneNumber = profile.phoneNumber;
                String countryCode = '+251';
                String phone = phoneNumber;

                if (phoneNumber.startsWith('+')) {
                  for (int i = 4; i <= 5; i++) {
                    if (phoneNumber.length > i) {
                      countryCode = phoneNumber.substring(0, i);
                      phone = phoneNumber.substring(i);
                      break;
                    }
                  }
                }

                _firstNameController.text = profile.firstName;
                _lastNameController.text = profile.lastName;
                _emailController.text = profile.email;
                _countryCodeController.text = countryCode;
                _phoneController.text = phone;
              }
            } else if (state is ProfileError) {
              errorMessage = state.message;
              if (_currentProfile != null) {
                profile = _currentProfile;
              }
            }

            if (profile == null && !isLoading && errorMessage == null) {
              return _buildLoadingState(colorScheme);
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (errorMessage != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorScheme.error),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: colorScheme.error),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  color: colorScheme.onErrorContainer,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {});
                              },
                              icon: Icon(Icons.close, color: colorScheme.error),
                            ),
                          ],
                        ),
                      ),
                    if (profile != null) ...[
                      _buildProfileHeader(profile),
                      const SizedBox(height: 24),
                      _buildProfileInfo(profile),
                      if (_isEditing) _buildEditModeActions(isLoading),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
