import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gheero/core/snack_bar/snack_bar_widget.dart';
import 'package:gheero/core/widgets/custom_appbar.dart';
import 'package:gheero/core/widgets/bottom_navigation.dart';
import 'package:gheero/core/storage/storage_service.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../domain/entities/profile_entity.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final profileBloc = context.read<ProfileBloc>();
    if (profileBloc.state is! ProfileLoaded) {
      context.read<ProfileBloc>().add(GetProfileEvent());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _navigateToEditProfile(ProfileEntity profile) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(profile: profile),
      ),
    );
  }

  Future<void> _logout() async {
    try {
      final colorScheme = Theme.of(context).colorScheme;
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Log Out',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        await StorageService.clearAll();

        if (mounted) {
          context.go('/login');
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.error(context, 'Failed to log out. Please try again.');
      }
    }
  }

  Widget _buildProfilePicture(ProfileEntity profile) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              image: profile.profilePictureUrl != null
                  ? DecorationImage(
                      image: NetworkImage(profile.profilePictureUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profile.profilePictureUrl == null
                ? Icon(Icons.person, size: 40, color: Colors.grey[600])
                : null,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${profile.firstName} ${profile.lastName}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0x0F02C27D),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Active',
            style: TextStyle(
              color: Color(0xFF02C27D),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    IconData? icon,
    String? svgAsset,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, size: 24, color: Colors.grey[700])
            else if (svgAsset != null)
              SvgPicture.asset(
                svgAsset,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Colors.grey[700]!,
                  BlendMode.srcIn,
                ),
              )
            else
              const SizedBox.shrink(),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(ProfileEntity profile) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 251, 251, 251),
          child: Column(
            children: [
              _buildMenuItem(
                svgAsset: 'assets/icons/edit.svg',
                title: 'Edit Profile',
                onTap: () => _navigateToEditProfile(profile),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        Container(
          color: const Color.fromARGB(255, 251, 251, 251),
          child: Column(
            children: [
              _buildMenuItem(
                svgAsset: 'assets/icons/language.svg',
                title: 'Language',
                onTap: () {
                  // TODO: Implement language selection
                },
              ),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Help',
                onTap: () {
                  // TODO: Implement help
                },
              ),
              _buildMenuItem(
                svgAsset: 'assets/icons/privacy.svg',
                title: 'Privacy and Security',
                onTap: () {
                  // TODO: Implement privacy and security
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: const Color.fromARGB(255, 251, 251, 251),
          child: Column(
            children: [
              _buildMenuItem(
                svgAsset: 'assets/icons/logout.svg',
                title: 'Log out',
                onTap: () => _logout(),
              ),
            ],
          ),
        ),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileEditSuccess) {
          CustomSnackBar.success(context, "Profile updated successfully");
        } else if (state is ProfileError) {
          CustomSnackBar.error(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: CustomAppBar(
          title: "Profile",
          onMenuTap: () {},
          onNotificationTap: () {},
          onProfileTap: () {},
        ),
        bottomNavigationBar: const BottomNavigation(currentIndex: 2),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            ProfileEntity? profile;
            bool isLoading = false;
            String? errorMessage;

            if (state is ProfileLoading) {
              isLoading = true;
            } else if (state is ProfileLoaded) {
              profile = state.profile;
            } else if (state is ProfileError) {
              errorMessage = state.message;
            }

            if (profile == null && !isLoading && errorMessage == null) {
              return _buildLoadingState(colorScheme);
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
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
                    _buildProfilePicture(profile),
                    const SizedBox(height: 40),
                    _buildMenuItems(profile),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
