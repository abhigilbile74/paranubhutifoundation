import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/core/theme/app_colors.dart';
import 'package:paranubhutifoundation/core/theme/app_text_styles.dart';
import 'package:paranubhutifoundation/core/theme/app_theme.dart';
import 'package:paranubhutifoundation/models/cause_model.dart';
import 'payment_details_screen.dart';

/// Donate screen — "Make a Birthday Gift".
/// Vertical list of cause cards (icon badge + title + description + radio),
/// followed by a gift-amount picker (3 circular presets + custom amount),
/// then "Continue to Payment".
class DonateScreen extends StatefulWidget {
  final String? preselectedCauseId;

  const DonateScreen({super.key, this.preselectedCauseId});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  // TODO: replace with causes fetched from Firestore via a provider
  final List<CauseModel> _causes = const [
    CauseModel(
      id: 'health',
      title: 'Health Support',
      description: 'Providing general health check-ups, and diagnostic tests.',
      icon: Icons.restaurant_rounded,
      badgeColor: AppColors.primaryContainer,
    ),
    CauseModel(
      id: 'education',
      title: 'Education Support',
      description: 'Scholarships and supplies for students pursuing their dreams.',
      icon: Icons.school_rounded,
      badgeColor: AppColors.secondaryContainer,
    ),
    CauseModel(
      id: 'women',
      title: 'Women Empowerment',
      description: 'Providing hygiene and health kits, skill development programs.',
      icon: Icons.groups_rounded,
      badgeColor: AppColors.tertiaryContainer,
    ),
    CauseModel(
      id: 'environment',
      title: 'Environment',
      description: 'Tree planting and wildlife conservation initiatives.',
      icon: Icons.eco_rounded,
      badgeColor: AppColors.inversePrimary,
    ),
  ];

  static const List<_AmountOption> _presetAmounts = [
    _AmountOption(amount: 25, label: 'Small'),
    _AmountOption(amount: 50, label: 'Popular'),
    _AmountOption(amount: 100, label: 'Large'),
  ];

  String? _selectedCauseId;
  double? _selectedPresetAmount;
  final TextEditingController _customAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCauseId = widget.preselectedCauseId ?? _causes.first.id;
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  double? get _finalAmount {
    final custom = double.tryParse(_customAmountController.text);
    if (custom != null && custom > 0) return custom;
    return _selectedPresetAmount;
  }

  bool get _canContinue => _selectedCauseId != null && _finalAmount != null && _finalAmount! > 0;

  void _selectPreset(double amount) {
    setState(() {
      _selectedPresetAmount = amount;
      _customAmountController.clear();
    });
  }

  void _onContinue() {
    final cause = _causes.firstWhere((c) => c.id == _selectedCauseId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentDetailsScreen(
          causeCategory: 'Selected Cause',
          causeTitle: cause.title,
          amount: _finalAmount!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Birthday Cause', style: AppTextStyles.headlineMd.copyWith(fontSize: 18, color: AppColors.primary)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, color: AppColors.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginMobile,
            vertical: AppSpacing.unit * 2,
          ),
          children: [
            Text('Make a Birthday Gift', style: AppTextStyles.displayLgMobile.copyWith(fontSize: 26)),
            const SizedBox(height: AppSpacing.unit),
            Text(
              "Transform your celebration into real-world impact. Choose a cause close to your heart.",
              style: AppTextStyles.bodyMd,
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            Text('CHOOSE A CAUSE', style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary)),
            const SizedBox(height: AppSpacing.gutter),

            ..._causes.map(
                  (cause) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.gutter),
                child: _CauseListTile(
                  cause: cause,
                  isSelected: cause.id == _selectedCauseId,
                  onTap: () => setState(() => _selectedCauseId = cause.id),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap - AppSpacing.unit),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.gutter + AppSpacing.unit),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SELECT GIFT AMOUNT', style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary)),
                    const SizedBox(height: AppSpacing.gutter),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _presetAmounts
                          .map((option) => _AmountCircle(
                        option: option,
                        selected: _selectedPresetAmount == option.amount &&
                            _customAmountController.text.isEmpty,
                        onTap: () => _selectPreset(option.amount),
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap - AppSpacing.unit),
                    Text('Custom Amount (₹)', style: AppTextStyles.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: AppSpacing.unit),
                    TextField(
                      controller: _customAmountController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(hintText: 'Enter other amount'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canContinue ? _onContinue : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Continue to Payment'),
                    SizedBox(width: AppSpacing.unit),
                    Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),
          ],
        ),
      ),
    );
  }
}

/// Horizontal cause card: colored icon badge, title, description, and a
/// radio-style selection indicator on the right.
class _CauseListTile extends StatelessWidget {
  final CauseModel cause;
  final bool isSelected;
  final VoidCallback onTap;

  const _CauseListTile({required this.cause, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(AppSpacing.gutter),
        decoration: BoxDecoration(
          color: isSelected ? cause.badgeColor.withValues(alpha: 0.18) : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cause.badgeColor,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(cause.icon, color: AppColors.onSurface, size: 22),
            ),
            const SizedBox(width: AppSpacing.gutter),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cause.title, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(
                    cause.description ?? '',
                    style: AppTextStyles.bodyMd.copyWith(fontSize: 13, color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.unit),
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: isSelected ? AppColors.primary : AppColors.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountOption {
  final double amount;
  final String label;
  const _AmountOption({required this.amount, required this.label});
}

/// Circular selectable gift-amount button (e.g. "$50 / Popular").
class _AmountCircle extends StatelessWidget {
  final _AmountOption option;
  final bool selected;
  final VoidCallback onTap;

  const _AmountCircle({required this.option, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? AppColors.primaryContainer.withValues(alpha: 0.25) : AppColors.surfaceContainerLowest,
              border: Border.all(color: selected ? AppColors.primary : AppColors.outlineVariant, width: selected ? 2 : 1),
            ),
            alignment: Alignment.center,
            child: Text(
              '\$${option.amount.toStringAsFixed(0)}',
              style: AppTextStyles.bodyMd.copyWith(
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.primary : AppColors.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            option.label,
            style: AppTextStyles.labelCaps.copyWith(
              fontSize: 10,
              color: selected ? AppColors.primary : AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}