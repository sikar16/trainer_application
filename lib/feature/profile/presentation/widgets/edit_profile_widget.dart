import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../../../core/di/injection_container.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryCodeController.text = '+251'; // Default country code
    // Load current profile data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(GetProfileEvent());
    });
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

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      final request = EditProfileRequestModel(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber:
            '${_countryCodeController.text.trim()}${_phoneController.text.trim()}',
      );

      context.read<ProfileBloc>().add(EditProfileEvent(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileEditSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );

              if (state.isPhoneChanged) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Phone number changed. You may need to verify it.',
                    ),
                    backgroundColor: Colors.orange,
                  ),
                );
              }

              if (state.isEmailChanged) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email changed. You may need to verify it.'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            } else if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              bool isLoading = state is ProfileLoading;
              String? errorMessage;

              if (state is ProfileError) {
                errorMessage = state.message;
              } else if (state is ProfileLoaded) {
                // Populate form fields with current profile data
                final profile = state.profile;
                _firstNameController.text = profile.firstName;
                _lastNameController.text = profile.lastName;
                _emailController.text = profile.email;

                // Split phone number into country code and phone number
                final phoneNumber = profile.phoneNumber;
                String countryCode = '+251'; // default
                String phone = phoneNumber;

                if (phoneNumber.startsWith('+')) {
                  // Find where the country code ends (typically after 3-4 digits)
                  for (int i = 4; i <= 5; i++) {
                    if (phoneNumber.length > i) {
                      countryCode = phoneNumber.substring(0, i);
                      phone = phoneNumber.substring(i);
                      break;
                    }
                  }
                }

                _countryCodeController.text = countryCode;
                _phoneController.text = phone;
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (errorMessage != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  errorMessage,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onErrorContainer,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {}); // Clear error by rebuilding
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                          hintText: _firstNameController.text.isEmpty
                              ? 'Enter first name'
                              : _firstNameController.text,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                          hintText: _lastNameController.text.isEmpty
                              ? 'Enter last name'
                              : _lastNameController.text,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          hintText: _emailController.text.isEmpty
                              ? 'Enter email address'
                              : _emailController.text,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        style: TextStyle(color: Colors.grey[600]),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _countryCodeController,
                              decoration: InputDecoration(
                                labelText: 'Country Code',
                                border: OutlineInputBorder(),
                                hintText: _countryCodeController.text.isEmpty
                                    ? '+251'
                                    : _countryCodeController.text,
                              ),
                              keyboardType: TextInputType.phone,
                              readOnly: true,
                              style: TextStyle(color: Colors.grey[600]),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                                hintText: _phoneController.text.isEmpty
                                    ? 'Enter phone number'
                                    : _phoneController.text,
                                errorMaxLines: 2,
                              ),
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                // Trigger real-time validation
                                _phoneController.value = TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                    offset: value.length,
                                  ),
                                );
                                setState(
                                  () {},
                                ); // Rebuild to show validation errors
                              },
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
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: isLoading ? null : _updateProfile,
                        child: isLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text('Updating...'),
                                ],
                              )
                            : const Text('Update Profile'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
