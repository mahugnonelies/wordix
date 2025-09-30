import 'package:flutter/material.dart';
import '../../i18n.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  // 🔧 Constantes métier (utilisées comme placeholders dans i18n)
  static const _appName = 'Wordix';
  static const _companyName = 'MAHUGNON SERVICES LTD';
  static const _contactEmail = 'support@wordixapp.com';
  static const _privacyEmail = 'support@wordixapp.com';

  Map<String, String> get _params => {
    'app': _appName,
    'company': _companyName,
    'contactEmail': _contactEmail,
    'privacyEmail': _privacyEmail,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('legal_terms'))),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('terms_title'),
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),

                _Section(title: I18n.t('terms_s1_title'), children: [
                  _p(I18n.t('terms_s1_p1', params: _params)),
                ]),

                _Section(title: I18n.t('terms_s2_title'), children: [
                  _p(I18n.t('terms_s2_p1')),
                ]),

                _Section(title: I18n.t('terms_s3_title'), children: [
                  _p(I18n.t('terms_s3_p1', params: _params)),
                ]),

                _Section(title: I18n.t('terms_s4_title'), children: [
                  _p(I18n.t('terms_s4_p1')),
                ]),

                _Section(title: I18n.t('terms_s5_title'), children: [
                  _p(I18n.t('terms_s5_p1', params: _params)),
                ]),

                _Section(title: I18n.t('terms_s6_title'), children: [
                  _p(I18n.t('terms_s6_p1', params: _params)),
                ]),

                _Section(title: I18n.t('terms_s7_title'), children: [
                  _p(I18n.t('terms_s7_p1')),
                ]),

                _Section(title: I18n.t('terms_s8_title'), children: [
                  _p(I18n.t('terms_s8_p1', params: _params)),
                ]),

                _Section(title: I18n.t('terms_s9_title'), children: [
                  _p(I18n.t('terms_s9_p1', params: _params)),
                ]),

                _Section(title: I18n.t('terms_s10_title'), children: [
                  _p(I18n.t('terms_s10_p1')),
                ]),

                _Section(title: I18n.t('terms_s11_title'), children: [
                  _p(I18n.t('terms_s11_p1')),
                ]),

                _Section(title: I18n.t('terms_s12_title'), children: [
                  _p(I18n.t('terms_s12_p1', params: _params)),
                ]),

                const SizedBox(height: 24),
                Text('${I18n.t('privacy_last_update')} : ${_fmtDate(DateTime.now())}',
                    style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- helpers UI ---
  static String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  static Widget _p(String text) => Padding(
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
