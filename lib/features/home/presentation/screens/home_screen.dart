import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/features/home/presentation/widgets/item_list_widget.dart';
import 'package:paranubhutifoundation/shared/widgets/appbar_screen.dart';
import 'package:paranubhutifoundation/shared/widgets/bottam_navigation_screen.dart';
import 'package:paranubhutifoundation/shared/widgets/custom_image_card.dart';
import 'package:paranubhutifoundation/core/theme/app_colors.dart';
import 'package:paranubhutifoundation/core/theme/app_text_styles.dart';
import 'package:paranubhutifoundation/core/theme/app_theme.dart';






// 👇 adjust these two paths to wherever these screens actually live in your project
import 'package:paranubhutifoundation/features/home/presentation/screens/register_birthday_screen.dart';
import 'package:paranubhutifoundation/features/donation/presentation/screen/donate_screen.dart';

/// Home screen — matches the "Birthday Cause" Stitch design:
/// header → headline → Your Birthday card → Someone Special card →
/// Quick Actions (Donate Now / Share a Fundraiser) → Featured Cause.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _HomeAppBar(),
      bottomNavigationBar: const BottomNavigationScreen(selectedIndex: 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginMobile,
            vertical: AppSpacing.unit * 2,
          ),
          children: [
            Text(
              'CELEBRATE WITH PURPOSE',
              style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.unit),
            Text('Make your day mean more.', style: AppTextStyles.displayLgMobile),

            const SizedBox(height: AppSpacing.sectionGap),

            _ActionCard(
              icon: Icons.cake_rounded,
              iconColor: AppColors.primary,
              title: 'Your birthday',
              description: "Let's turn your special day into a world-changing gift.",
              button: _FilledPillButton(
                label: 'Add your birthday',
                trailingIcon: Icons.arrow_forward_rounded,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterBirthdayScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.gutter),

            _ActionCard(
              icon: Icons.groups_rounded,
              iconColor: AppColors.tertiary,
              title: 'Someone special?',
              description: 'Honor a loved one by starting a fundraiser for their birthday.',
              button: _OutlinedPillButton(
                label: "Add someone else's",
                trailingIcon: Icons.add_rounded,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterBirthdayScreen()),
                  );
                  // If RegisterBirthdayScreen needs to know it's "someone else" up
                  // front, add a constructor param, e.g.:
                  // RegisterBirthdayScreen(initialRelation: 'other')
                },
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            Text('Quick Actions', style: AppTextStyles.headlineMd),
            const SizedBox(height: AppSpacing.gutter),

            _QuickActionTile(
              backgroundColor: AppColors.secondaryContainer,
              icon: Icons.volunteer_activism_rounded,
              title: 'Donate Now',
              description: 'Support a trending cause immediately.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DonateScreen()),
                );
              },
            ),
            const SizedBox(height: AppSpacing.gutter),
            _QuickActionTile(
              backgroundColor: AppColors.primaryContainer,
              icon: Icons.ios_share_rounded,
              title: 'Share a Fundraiser',
              description: 'Invite friends to join a celebration of giving.',
              onTap: () {
                // TODO: navigate to CreateFundraiserScreen once that screen exists
              },
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Featured Cause', style: AppTextStyles.headlineMd),
                TextButton(
                  onPressed: () {
                    // TODO: Navigator.pushNamed(context, RoutesNames.causes);
                  },
                  child: Text(
                    'See All',
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.gutter),

            const _FeaturedCauseCard(
              tag: 'Education',
              imagePath: 'assets/images/education.jpg',
              title: 'Birthday Books for All',
              description:
              'Help us provide 1,000 books to children in underserved communities this month.',
              amountRaised: 4200,
              goalAmount: 5000,
            ),

            const SizedBox(height: AppSpacing.sectionGap),
          ],
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          const Text('🎉 ', style: TextStyle(fontSize: 20)),
          Text(
            'Birthday Cause',
            style: AppTextStyles.headlineMd.copyWith(color: AppColors.primary, fontSize: 20),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none_rounded, color: AppColors.onSurface),
          onPressed: () {
            // TODO: Navigator.pushNamed(context, RoutesNames.notifications);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// White card used for "Your birthday" / "Someone special?" — icon, title,
/// description, and a CTA button slot.
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final Widget button;

  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sectionGap - AppSpacing.unit),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: iconColor),
            const SizedBox(height: AppSpacing.gutter),
            Text(title, style: AppTextStyles.headlineMd),
            const SizedBox(height: AppSpacing.unit),
            Text(description, style: AppTextStyles.bodyMd),
            const SizedBox(height: AppSpacing.sectionGap - AppSpacing.unit),
            SizedBox(width: double.infinity, child: button),
          ],
        ),
      ),
    );
  }
}

/// Solid coral pill button, e.g. "Add your birthday →"
class _FilledPillButton extends StatelessWidget {
  final String label;
  final IconData? trailingIcon;
  final VoidCallback onPressed;

  const _FilledPillButton({required this.label, required this.onPressed, this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          if (trailingIcon != null) ...[
            const SizedBox(width: AppSpacing.unit),
            Icon(trailingIcon, size: 18),
          ],
        ],
      ),
    );
  }
}

/// Coral-outlined pill button, e.g. "Add someone else's +"
class _OutlinedPillButton extends StatelessWidget {
  final String label;
  final IconData? trailingIcon;
  final VoidCallback onPressed;

  const _OutlinedPillButton({required this.label, required this.onPressed, this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          if (trailingIcon != null) ...[
            const SizedBox(width: AppSpacing.unit),
            Icon(trailingIcon, size: 18),
          ],
        ],
      ),
    );
  }
}

/// Colored tappable tile used for Quick Actions ("Donate Now", "Share a
/// Fundraiser") — background color passed in (secondaryContainer / primaryContainer).
class _QuickActionTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 👈 was hardcoded to a broken Navigator.push with an undefined `route`
      borderRadius: BorderRadius.circular(AppRadius.xxl),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.gutter + AppSpacing.unit),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.unit),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.onSurface, size: 22),
            ),
            const SizedBox(width: AppSpacing.gutter),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headlineMd.copyWith(fontSize: 18, color: AppColors.onSurface),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface.withValues(alpha: 0.75)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Featured cause card — image with a category tag, title, description,
/// and a "$X raised / Goal: $Y" progress bar.
class _FeaturedCauseCard extends StatelessWidget {
  final String tag;
  final String imagePath;
  final String title;
  final String description;
  final double amountRaised;
  final double goalAmount;

  const _FeaturedCauseCard({
    required this.tag,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.amountRaised,
    required this.goalAmount,
  });

  double get _progress => goalAmount <= 0 ? 0 : (amountRaised / goalAmount).clamp(0, 1);

  String _formatAmount(double value) {
    return value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                imagePath,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 160,
                  color: AppColors.surfaceContainerHigh,
                  child: Icon(Icons.image_rounded, color: AppColors.onSurfaceVariant, size: 40),
                ),
              ),
              Positioned(
                top: AppSpacing.unit,
                left: AppSpacing.unit,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(
                    tag,
                    style: AppTextStyles.labelCaps.copyWith(color: AppColors.onTertiaryContainer),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.headlineMd.copyWith(fontSize: 18)),
                const SizedBox(height: AppSpacing.unit),
                Text(description, style: AppTextStyles.bodyMd),
                const SizedBox(height: AppSpacing.gutter),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${_formatAmount(amountRaised)} raised',
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Goal: \$${_formatAmount(goalAmount)}',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.unit),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 10,
                    backgroundColor: AppColors.surfaceContainerHigh,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}