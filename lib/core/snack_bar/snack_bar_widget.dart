import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MessageType { success, warning, error, info }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    required MessageType type,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onActionPressed,
    String? actionLabel,
    bool showIcon = true,
    bool dismissible = true,
    bool showCloseButton = true,
  }) {
    HapticFeedback.lightImpact();

    final theme = Theme.of(context);
    final colors = _getColors(context, type);
    final iconData = _getIcon(type);

    final snackBar = SnackBar(
      content: Container(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            // Icon Container with subtle background
            if (showIcon) ...[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.iconBackgroundColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: colors.iconColor, size: 20),
              ),
              const SizedBox(width: 16),
            ],

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Subtitle
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.textColor.withValues(alpha: 0.8),
                        fontSize: 12,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Action Button and Close Button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Action Button
                if (actionLabel != null && onActionPressed != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: onActionPressed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colors.actionColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: colors.actionColor.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          actionLabel.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.actionColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Close Button
                if (showCloseButton)
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: colors.textColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: colors.textColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: colors.backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colors.borderColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      dismissDirection: dismissible
          ? DismissDirection.horizontal
          : DismissDirection.none,
      elevation: 8,
      // shadowColor: colors.backgroundColor.withValues(alpha: 0.3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static ({
    Color backgroundColor,
    Color textColor,
    Color actionColor,
    Color iconColor,
    Color iconBackgroundColor,
    Color borderColor,
  })
  _getColors(BuildContext context, MessageType type) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    switch (type) {
      case MessageType.success:
        return (
          backgroundColor: isDark
              ? _blendColors(Colors.green.shade900, Colors.black, 0.2)
              : _blendColors(Colors.green.shade50, Colors.white, 0.8),
          textColor: isDark ? Colors.green.shade100 : Colors.green.shade800,
          actionColor: isDark ? Colors.green.shade300 : Colors.green.shade600,
          iconColor: isDark ? Colors.green.shade300 : Colors.green.shade600,
          iconBackgroundColor: isDark
              ? Colors.green.shade300
              : Colors.green.shade600,
          borderColor: isDark ? Colors.green.shade700 : Colors.green.shade200,
        );
      case MessageType.warning:
        return (
          backgroundColor: isDark
              ? _blendColors(Colors.orange.shade900, Colors.black, 0.2)
              : _blendColors(Colors.orange.shade50, Colors.white, 0.8),
          textColor: isDark ? Colors.orange.shade100 : Colors.orange.shade800,
          actionColor: isDark ? Colors.orange.shade300 : Colors.orange.shade600,
          iconColor: isDark ? Colors.orange.shade300 : Colors.orange.shade600,
          iconBackgroundColor: isDark
              ? Colors.orange.shade300
              : Colors.orange.shade600,
          borderColor: isDark ? Colors.orange.shade700 : Colors.orange.shade200,
        );
      case MessageType.error:
        return (
          backgroundColor: isDark
              ? _blendColors(Colors.red.shade900, Colors.black, 0.2)
              : _blendColors(Colors.red.shade50, Colors.white, 0.8),
          textColor: isDark ? Colors.red.shade100 : Colors.red.shade800,
          actionColor: isDark ? Colors.red.shade300 : Colors.red.shade600,
          iconColor: isDark ? Colors.red.shade300 : Colors.red.shade600,
          iconBackgroundColor: isDark
              ? Colors.red.shade300
              : Colors.red.shade600,
          borderColor: isDark ? Colors.red.shade700 : Colors.red.shade200,
        );
      case MessageType.info:
        return (
          backgroundColor: isDark
              ? _blendColors(Colors.blue.shade900, Colors.black, 0.2)
              : _blendColors(Colors.blue.shade50, Colors.white, 0.8),
          textColor: isDark ? Colors.blue.shade100 : Colors.blue.shade800,
          actionColor: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
          iconColor: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
          iconBackgroundColor: isDark
              ? Colors.blue.shade300
              : Colors.blue.shade600,
          borderColor: isDark ? Colors.blue.shade700 : Colors.blue.shade200,
        );
    }
  }

  static Color _blendColors(Color color1, Color color2, double ratio) {
    return Color.lerp(color1, color2, ratio)!;
  }

  static IconData _getIcon(MessageType type) {
    switch (type) {
      case MessageType.success:
        return Icons.check_circle_rounded;
      case MessageType.warning:
        return Icons.warning_rounded;
      case MessageType.error:
        return Icons.error_rounded;
      case MessageType.info:
        return Icons.info_rounded;
    }
  }

  // Optional: Method for quick usage
  static void success(
    BuildContext context,
    String message, {
    String? subtitle,
  }) {
    show(
      context,
      title: message,
      subtitle: subtitle,
      type: MessageType.success,
    );
  }

  static void error(BuildContext context, String message, {String? subtitle}) {
    show(context, title: message, subtitle: subtitle, type: MessageType.error);
  }

  static void warning(
    BuildContext context,
    String message, {
    String? subtitle,
  }) {
    show(
      context,
      title: message,
      subtitle: subtitle,
      type: MessageType.warning,
    );
  }

  static void info(BuildContext context, String message, {String? subtitle}) {
    show(context, title: message, subtitle: subtitle, type: MessageType.info);
  }
}
