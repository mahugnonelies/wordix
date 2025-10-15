import 'package:flutter/material.dart';
import '../../i18n.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  // 🔧 Renseigne ces constantes métier (elles alimentent les placeholders I18n)
  static const _appName = 'Wordix';
  static const _companyName = 'MAHUGNON SERVICES LTD';
  static const _companyNumber = '16010860';
  static const _companyAddress = '20 Wenlock Road, London, N1 7GU, United Kingdom';
  static const _contactEmail = 'support@wordixapp.com';
  static const _privacyEmail = 'support@wordixapp.com';

  Map<String, String> get _params => {
    'app': _appName,
    'company': _companyName,
    'companyNumber': _companyNumber,
    'companyAddress': _companyAddress,
    'contactEmail': _contactEmail,
    'privacyEmail': _privacyEmail,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('legal_privacy'))),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('privacy_title'),
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                SelectableText(I18n.t('privacy_intro', params: _params)),

                const SizedBox(height: 16),
                _Section(title: I18n.t('privacy_s1_title'), children: [
                  _p(I18n.t('privacy_s1_p1', params: _params)),
                  _p(I18n.t('privacy_s1_p2', params: _params)),
                  _p(I18n.t('privacy_s1_p3', params: _params)),
                ]),

                _Section(title: I18n.t('privacy_s2_title'), children: [
                  _li(I18n.t('privacy_s2_li1')),
                  _li(I18n.t('privacy_s2_li2')),
                  _li(I18n.t('privacy_s2_li3')),
                  _p(I18n.t('privacy_s2_p4')),
                ]),

                _Section(title: I18n.t('privacy_s3_title'), children: [
                  _li(I18n.t('privacy_s3_li1')),
                  _li(I18n.t('privacy_s3_li2')),
                  _li(I18n.t('privacy_s3_li3')),
                  _li(I18n.t('privacy_s3_li4')),
                ]),

                _Section(title: I18n.t('privacy_s4_title'), children: [
                  _p(I18n.t('privacy_s4_p1')),
                  _li(I18n.t('privacy_s4_li1')),
                  _li(I18n.t('privacy_s4_li2')),
                  _li(I18n.t('privacy_s4_li3')),
                ]),

                _Section(title: I18n.t('privacy_s5_title'), children: [
                  _p(I18n.t('privacy_s5_p1')),
                  _li(I18n.t('privacy_s5_li1')),
                  _li(I18n.t('privacy_s5_li2')),
                  _li(I18n.t('privacy_s5_li3')),
                  _p(I18n.t('privacy_s5_p2')),
                ]),

                _Section(title: I18n.t('privacy_s6_title'), children: [
                  _p(I18n.t('privacy_s6_p1')),
                ]),

                _Section(title: I18n.t('privacy_s7_title'), children: [
                  _p(I18n.t('privacy_s7_p1')),
                  _p(I18n.t('privacy_s7_p2')),
                ]),

                _Section(title: I18n.t('privacy_s8_title'), children: [
                  _p(I18n.t('privacy_s8_p1')),
                ]),

                _Section(title: I18n.t('privacy_s9_title'), children: [
                  _p(I18n.t('privacy_s9_p1', params: _params)),
                ]),

                _Section(title: I18n.t('privacy_s10_title'), children: [
                  _p(I18n.t('privacy_s10_p1', params: _params)),
                ]),

                _Section(title: I18n.t('privacy_s11_title'), children: [
                  _p(I18n.t('privacy_s11_p1')),
                ]),

                // --- Nouvelles sections (infos collectées / AdMob / partage / sécurité / pubs / droits)
                _Section(title: I18n.t('privacy_c_title'), children: [
                  _p(I18n.t('privacy_c_intro')),
                  const SizedBox(height: 4),
                  Text(I18n.t('privacy_c_admob_title'), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  _p(I18n.t('privacy_c_admob_p1')),
                  _li(I18n.t('privacy_c_admob_b1')),
                  _li(I18n.t('privacy_c_admob_b2')),
                  _li(I18n.t('privacy_c_admob_b3')),
                  _p(I18n.t('privacy_c_admob_note')),
                  _p(I18n.t('privacy_c_admob_link')),
                  const SizedBox(height: 8),
                  Text(I18n.t('privacy_c_usage_title'), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  _p(I18n.t('privacy_c_usage_p1')),
                ]),

                _Section(title: I18n.t('privacy_share_title'), children: [
                  _p(I18n.t('privacy_share_p1')),
                ]),

                _Section(title: I18n.t('privacy_security_title'), children: [
                  _p(I18n.t('privacy_security_p1')),
                ]),

                _Section(title: I18n.t('privacy_ads_title'), children: [
                  _p(I18n.t('privacy_ads_p1')),
                  _p(I18n.t('privacy_ads_link')),
                ]),

                _Section(title: I18n.t('privacy_rights_title'), children: [
                  _p(I18n.t('privacy_rights_p1')),
                ]),

                _Section(title: I18n.t('privacy_s12_title'), children: [
                  _p(I18n.t('privacy_s12_p1')),
                ]),

                _Section(title: I18n.t('privacy_s13_title'), children: [
                  _p(I18n.t('privacy_s13_intro')),
                  _li(I18n.t('privacy_s13_li1', params: _params)),
                  _li(I18n.t('privacy_s13_li2', params: _params)),
                  _li(I18n.t('privacy_s13_li3', params: _params)),
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
