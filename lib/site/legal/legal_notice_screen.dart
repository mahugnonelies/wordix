import 'package:flutter/material.dart';
import '../../i18n.dart';

class LegalNoticeScreen extends StatelessWidget {
  const LegalNoticeScreen({super.key});

  // 🔧 Renseigne ces constantes une fois
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
      appBar: AppBar(title: Text(I18n.t('legal_title'))),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('legal_header', params: _p), style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),

                _Section(
                  title: I18n.t('legal_editor_title'),
                  children: [
                    _pText(I18n.t('legal_editor_body_1', params: _p)),
                    _li(I18n.t('legal_editor_item_company', params: _p)),
                    _li(I18n.t('legal_editor_item_uk')),
                    _li(I18n.t('legal_editor_item_number', params: _p)),
                    _li(I18n.t('legal_editor_item_address', params: _p)),
                    _li(I18n.t('legal_editor_item_contact', params: _p)),
                  ],
                ),

                _Section(
                  title: I18n.t('legal_hosting_title'),
                  children: [
                    _pText(I18n.t('legal_hosting_body_1')),
                    _li(I18n.t('legal_hosting_item_play')),
                    _li(I18n.t('legal_hosting_item_appstore')),
                    const SizedBox(height: 8),
                    _pText(I18n.t('legal_hosting_body_2')),
                    _li(I18n.t('legal_hosting_item_supabase')),
                    _li(I18n.t('legal_hosting_item_firebase')),
                  ],
                ),

                _Section(
                  title: I18n.t('legal_ip_title'),
                  children: [_pText(I18n.t('legal_ip_body', params: _p))],
                ),

                _Section(
                  title: I18n.t('legal_liability_title'),
                  children: [_pText(I18n.t('legal_liability_body', params: _p))],
                ),

                _Section(
                  title: I18n.t('legal_privacy_title'),
                  children: [
                    _pText(I18n.t('legal_privacy_body_1', params: _p)),
                    _pText(I18n.t('legal_privacy_body_2', params: _p)),
                    _pText(I18n.t('legal_privacy_body_3', params: _p)),
                  ],
                ),

                _Section(
                  title: I18n.t('legal_cookies_title'),
                  children: [_pText(I18n.t('legal_cookies_body'))],
                ),

                _Section(
                  title: I18n.t('legal_law_title'),
                  children: [_pText(I18n.t('legal_law_body'))],
                ),

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
