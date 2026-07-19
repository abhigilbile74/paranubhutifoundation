import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/core/theme/app_colors.dart';
import 'package:paranubhutifoundation/core/theme/app_text_styles.dart';
import 'package:paranubhutifoundation/core/theme/app_theme.dart';
/// Payment Details screen — shown after Donate screen, before the actual
/// payment gateway hand-off. Lets the donor pick a UPI app or enter a UPI ID,
/// toggle anonymity, and confirm.
///
/// For the MVP (external Razorpay Payment Link approach), tapping a UPI app
/// or "Confirm & Donate" should launch the Razorpay-hosted payment page via
/// url_launcher rather than processing payment natively here — see the
/// `_onConfirm` TODO below.
class PaymentDetailsScreen extends StatefulWidget {
  final String causeCategory; // e.g. "Selected Cause" label above the title
  final String causeTitle; // e.g. "Food Assistance"
  final double amount;

  const PaymentDetailsScreen({
    super.key,
    required this.causeCategory,
    required this.causeTitle,
    required this.amount,
  });

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  static const List<_UpiApp> _upiApps = [
    _UpiApp(name: 'Google Pay', icon: Icons.account_balance_wallet_rounded),
    _UpiApp(name: 'PhonePe', icon: Icons.smartphone_rounded),
    _UpiApp(name: 'Paytm', icon: Icons.qr_code_rounded),
    _UpiApp(name: 'BHIM', icon: Icons.account_balance_rounded),
  ];

  final TextEditingController _upiIdController = TextEditingController();
  String? _selectedApp;
  bool _isAnonymous = false;

  @override
  void dispose() {
    _upiIdController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    // TODO: launch Razorpay Payment Link via url_launcher, passing
    // amount, causeTitle, anonymous flag, and selected UPI app/UPI ID
    // as metadata/prefill where the gateway supports it.
    // e.g. launchUrl(Uri.parse(paymentLinkUrl));
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
        title: Text('Payment Details', style: AppTextStyles.headlineMd.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginMobile,
            vertical: AppSpacing.unit * 2,
          ),
          children: [
            _SelectedCauseCard(
              causeCategory: widget.causeCategory,
              causeTitle: widget.causeTitle,
              amount: widget.amount,
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.gutter + AppSpacing.unit),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POPULAR UPI APPS',
                      style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: AppSpacing.gutter),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _upiApps.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSpacing.gutter,
                        mainAxisSpacing: AppSpacing.gutter,
                        childAspectRatio: 2.4,
                      ),
                      itemBuilder: (context, index) {
                        final app = _upiApps[index];
                        return _UpiAppTile(
                          app: app,
                          selected: _selectedApp == app.name,
                          onTap: () => setState(() => _selectedApp = app.name),
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.sectionGap - AppSpacing.unit),

                    Text(
                      'OR ENTER UPI ID',
                      style: AppTextStyles.labelCaps.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: AppSpacing.unit),
                    TextField(
                      controller: _upiIdController,
                      decoration: const InputDecoration(
                        hintText: 'username@bank',
                        suffixIcon: Icon(Icons.alternate_email_rounded),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sectionGap - AppSpacing.unit),

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.secondaryContainer,
                          child: Icon(
                            _isAnonymous ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            size: 18,
                            color: AppColors.onSecondaryContainer,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.gutter),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Anonymous donation', style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                              Text(
                                'Hide your name from the public list',
                                style: AppTextStyles.bodyMd.copyWith(fontSize: 13, color: AppColors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _isAnonymous,
                          activeThumbColor: AppColors.primary,
                          onChanged: (value) => setState(() => _isAnonymous = value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onConfirm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.lock_rounded, size: 18),
                    SizedBox(width: AppSpacing.unit),
                    Text('Confirm & Donate'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shield_outlined, size: 14, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text('SSL ENCRYPTED', style: AppTextStyles.labelCaps.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant)),
                    const SizedBox(width: AppSpacing.gutter),
                    Icon(Icons.verified_user_outlined, size: 14, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text('SECURE PAYMENT', style: AppTextStyles.labelCaps.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: AppSpacing.unit),
                Text(
                  'Your contribution goes directly to the selected cause. We use industry-standard encryption to protect your sensitive information.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd.copyWith(fontSize: 12, color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedCauseCard extends StatelessWidget {
  final String causeCategory;
  final String causeTitle;
  final double amount;

  const _SelectedCauseCard({
    required this.causeCategory,
    required this.causeTitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.gutter + AppSpacing.unit),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    causeCategory.toUpperCase(),
                    style: AppTextStyles.labelCaps.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    causeTitle,
                    style: AppTextStyles.headlineMd.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'TOTAL GIFT',
                  style: AppTextStyles.labelCaps.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: AppTextStyles.headlineMd,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UpiApp {
  final String name;
  final IconData icon;
  const _UpiApp({required this.name, required this.icon});
}

class _UpiAppTile extends StatelessWidget {
  final _UpiApp app;
  final bool selected;
  final VoidCallback onTap;

  const _UpiAppTile({required this.app, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter, vertical: AppSpacing.unit),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.outlineVariant,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          color: selected ? AppColors.primaryContainer.withValues(alpha: 0.15) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(app.icon, size: 20, color: AppColors.onSurface),
            const SizedBox(width: AppSpacing.unit),
            Flexible(
              child: Text(
                app.name,
                style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}