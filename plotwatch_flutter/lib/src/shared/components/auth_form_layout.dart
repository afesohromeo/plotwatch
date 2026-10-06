import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Body of the welcome, sign-in, sign-up and password reset pages: centred,
/// scrollable, and at most 420 px wide on tablets and desktops.
class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
  });

  static const double maxWidth = 420;

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: context.textTheme.headlineSmall),
              if (subtitle != null) ...[
                const Gap.vertical(height: AppSpacing.sm),
                Text(subtitle!, style: context.textTheme.bodyMedium),
              ],
              const Gap.vertical(height: AppSpacing.lg),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
