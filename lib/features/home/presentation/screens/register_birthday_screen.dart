import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/core/theme/app_colors.dart';
import 'package:paranubhutifoundation/core/theme/app_text_styles.dart';
import 'package:paranubhutifoundation/core/theme/app_theme.dart';
import 'package:paranubhutifoundation/shared/widgets/bottam_navigation_screen.dart';

/// Register Birthday screen — "Who are we celebrating?" toggle, date of
/// birth picker, reminder preferences, and a Save button.
class RegisterBirthdayScreen extends StatefulWidget {
  const RegisterBirthdayScreen({super.key});

  @override
  State<RegisterBirthdayScreen> createState() => _RegisterBirthdayScreenState();
}

enum _Relation { myself, someoneElse }

class _RegisterBirthdayScreenState extends State<RegisterBirthdayScreen> {
  _Relation _relation = _Relation.myself;
  DateTime? _dateOfBirth;
  bool _remindMe = true;
  int _remindDaysBefore = 3;

  static const List<int> _reminderOptions = [1, 3, 7];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dateOfBirth = picked);
    }
  }

  String get _formattedDate {
    if (_dateOfBirth == null) return '';
    final d = _dateOfBirth!;
    return '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';
  }

  void _onSave() {
    // TODO: write to Firestore `birthdays` collection:
    // { ownerId, personName, relation, dob, reminderDaysBefore, reminderChannel }
    // then Navigator.pop(context) or navigate back to Home.
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
        title: Row(
          children: [
            const Text('🎉 ', style: TextStyle(fontSize: 18)),
            Text('Birthday Cause', style: AppTextStyles.headlineMd.copyWith(color: AppColors.primary, fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, color: AppColors.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationScreen(selectedIndex: 2),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginMobile,
            vertical: AppSpacing.unit * 2,
          ),
          children: [
            Text('Register Birthday', style: AppTextStyles.displayLgMobile.copyWith(fontSize: 28)),
            const SizedBox(height: AppSpacing.unit),
            Text(
              "Let's make your next celebration meaningful by giving back.",
              style: AppTextStyles.bodyMd,
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.gutter + AppSpacing.unit),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('WHO ARE WE CELEBRATING?', style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary)),
                    const SizedBox(height: AppSpacing.gutter),
                    _RelationToggle(
                      selected: _relation,
                      onChanged: (value) => setState(() => _relation = value),
                    ),

                    const SizedBox(height: AppSpacing.sectionGap - AppSpacing.unit),

                    Text('DATE OF BIRTH', style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary)),
                    const SizedBox(height: AppSpacing.unit),
                    InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today_rounded),
                        ),
                        child: Text(
                          _dateOfBirth == null ? 'dd-mm-yyyy' : _formattedDate,
                          style: AppTextStyles.bodyMd.copyWith(
                            color: _dateOfBirth == null ? AppColors.outline : AppColors.onSurface,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sectionGap - AppSpacing.unit),

                    Text('NOTIFICATIONS', style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Remind me', style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                        Switch(
                          value: _remindMe,
                          activeThumbColor: AppColors.primary,
                          onChanged: (value) => setState(() => _remindMe = value),
                        ),
                      ],
                    ),

                    if (_remindMe) ...[
                      const SizedBox(height: AppSpacing.gutter),
                      Text('REMIND ME BEFORE', style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary)),
                      const SizedBox(height: AppSpacing.unit),
                      DropdownButtonFormField<int>(
                        initialValue: _remindDaysBefore,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        items: _reminderOptions
                            .map((days) => DropdownMenuItem(
                          value: days,
                          child: Text('$days day${days > 1 ? 's' : ''} before'),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) setState(() => _remindDaysBefore = value);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _dateOfBirth != null ? _onSave : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.favorite_rounded, size: 18),
                    SizedBox(width: AppSpacing.unit),
                    Text('Save Birthday'),
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

/// Pill-shaped segmented toggle: "Myself" / "Someone else".
class _RelationToggle extends StatelessWidget {
  final _Relation selected;
  final ValueChanged<_Relation> onChanged;

  const _RelationToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(child: _buildOption(context, 'Myself', _Relation.myself)),
          Expanded(child: _buildOption(context, 'Someone else', _Relation.someoneElse)),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label, _Relation value) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.unit * 1.5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.buttonText.copyWith(
            color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}