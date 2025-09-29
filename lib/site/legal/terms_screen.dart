import 'package:flutter/material.dart';
import '../../i18n.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const _appName = 'Wordix';
  static const _companyName = 'MAHUGNON SERVICES LTD';
  static const _contactEmail = 'support@wordixapp.com';
  static const _privacyEmail = 'support@wordixapp.com';

  Map<String, String> get _p => {
    'app': _appName,
    'company_name': _companyName,
    'contact_email': _contactEmail,
    'privacy_email': _privacyEmail,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = _fmtDate(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('terms_title'))),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('terms_h1'), style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),

                _Section(title: I18n.t('terms_accept_title'), children: [_pText(I18n.t('terms_accept_body', params: _p))]),
                _Section(title: I18n.t('terms_access_title'), children: [_pText(I18n.t('terms_access_body'))]),
                _Section(title: I18n.t('terms_license_title'), children: [_pText(I18n.t('terms_license_body', params: _p))]),
                _Section(title: I18n.t('terms_conduct_title'), children: [_pText(I18n.t('terms_conduct_body'))]),
                _Section(title: I18n.t('terms_features_title'), children: [_pText(I18n.t('terms_features_body', params: _p))]),
                _Section(title: I18n.t('terms_data_title'), children: [_pText(I18n.t('terms_data_body', params: _p))]),
                _Section(title: I18n.t('terms_updates_title'), children: [_pText(I18n.t('terms_updates_body'))]),
                _Section(title: I18n.t('terms_liability_title'), children: [_pText(I18n.t('terms_liability_body', params: _p))]),
                _Section(title: I18n.t('terms_termination_title'), children: [_pText(I18n.t('terms_termination_body'))]),
                _Section(title: I18n.t('terms_changes_title'), children: [_pText(I18n.t('terms_changes_body'))]),
                _Section(title: I18n.t('terms_law_title'), children: [_pText(I18n.t('terms_law_body'))]),
                _Section(title: I18n.t('terms_contact_title'), children: [_pText(I18n.t('terms_contact_body', params: _p))]),

                const SizedBox(height: 24),
                Text(I18n.t('last_update', params: {'date': date}), style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  static Widget _pText(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: SelectableText(text),
  );
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}
