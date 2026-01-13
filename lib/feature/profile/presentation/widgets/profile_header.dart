import 'package:flutter/material.dart';
import 'package:training/feature/profile/domain/entities/profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;
  final bool isEditing;
  final void Function(ProfileEntity) onEdit;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.isEditing,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
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
        if (!isEditing)
          IconButton(
            onPressed: () => onEdit(profile),
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
}
