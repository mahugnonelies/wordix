import 'package:flutter/material.dart';
import '../../i18n.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _appName = 'Wordix';
  static const _companyName = 'MAHUGNON SERVICES LTD';
  static const _companyNumber = '16010860';
  static const _companyAddress = '20 Wenlock Road, London, N1 7GU, United Kingdom';
  static const _contactEmail = 'support@wordixapp.com';
  static const _privacyEmail = 'support@wordixapp.com';

  Map<String, String> get _p => {
    'app': _appName,
    'company_name': _companyName,
    'company_number': _companyNumber,
    'company_address': _companyAddress,
    'contact_email': _contactEmail,
    'privacy_email': _privacyEmail,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = _fmtDate(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('privacy_title'))),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('privacy_h1'), style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                SelectableText(I18n.t('privacy_intro', params: _p)),
                const SizedBox(height: 16),

                _Section(title: I18n.t('privacy_controller_title'), children: [
                  _pText(I18n.t('privacy_controller_body_1', params: _p)),
                  _pText(I18n.t('privacy_controller_body_2', params: _p)),
                  _pText(I18n.t('privacy_controller_body_3', params: _p)),
                ]),

                _Section(title: I18n.t('privacy_data_title'), children: [
                  _li(I18n.t('privacy_data_item_1')),
                  _li(I18n.t('privacy_data_item_2')),
                  _li(I18n.t('privacy_data_item_3')),
                  _pText(I18n.t('privacy_data_note')),
                ]),

                _Section(title: I18n.t('privacy_purposes_title'), children: [
                  _li(I18n.t('privacy_purposes_item_1')),
                  _li(I18n.t('privacy_purposes_item_2')),
                  _li(I18n.t('privacy_purposes_item_3')),
                  _li(I18n.t('privacy_purposes_item_4')),
                ]),

                _Section(title: I18n.t('privacy_retention_title'), children: [
                  _li(I18n.t('privacy_retention_item_1')),
                  _li(I18n.t('privacy_retention_item_2')),
                  _li(I18n.t('privacy_retention_item_3')),
                ]),

                _Section(title: I18n.t('privacy_processors_title'), children: [
                  _li(I18n.t('privacy_processors_item_1')),
                  _li(I18n.t('privacy_processors_item_2')),
                  _li(I18n.t('privacy_processors_item_3')),
                ]),

                _Section(title: I18n.t('privacy_transfers_title'), children: [
                  _pText(I18n.t('privacy_transfers_body')),
                ]),

                _Section(title: I18n.t('privacy_rights_title'), children: [
                  _pText(I18n.t('privacy_rights_body_1', params: _p)),
                  _pText(I18n.t('privacy_rights_body_2')),
                ]),

                _Section(title: I18n.t('privacy_security_title'), children: [
                  _pText(I18n.t('privacy_security_body')),
                ]),

                _Section(title: I18n.t('privacy_minors_title'), children: [
                  _pText(I18n.t('privacy_minors_body', params: _p)),
                ]),

                _Section(title: I18n.t('privacy_analytics_title'), children: [
                  _pText(I18n.t('privacy_analytics_body', params: _p)),
                ]),

                _Section(title: I18n.t('privacy_push_title'), children: [
                  _pText(I18n.t('privacy_push_body')),
                ]),

                _Section(title: I18n.t('privacy_changes_title'), children: [
                  _pText(I18n.t('privacy_changes_body')),
                ]),

                _Section(title: I18n.t('privacy_contact_title'), children: [
                  _pText(I18n.t('privacy_contact_body', params: _p)),
                ]),

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

  static Widget _li(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, left: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  '),
        Expanded(child: SelectableText(text)),
      ],
    ),
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
