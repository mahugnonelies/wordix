import 'package:flutter/material.dart';
import '../../i18n.dart';

class DeletePolicyScreen extends StatelessWidget {
  const DeletePolicyScreen({super.key});

  // 🔧 Renseigne ces constantes une fois pour toutes
  static const _appName = 'Wordix';
  static const _companyName = 'MAHUGNON SERVICES LTD';
  static const _companyAddress =
      '20 Wenlock Road, London, N1 7GU, United Kingdom';
  static const _contactEmail = 'support@wordixapp.com';

  Map<String, String> get _params => {
    'app': _appName,
    'company': _companyName,
    'companyAddress': _companyAddress,
    'contactEmail': _contactEmail,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('dp_title'))),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('dp_heading', params: _params),
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(
                  '${I18n.t('privacy_last_update')} : ${_fmtDate(DateTime.now())}',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),

                // 1. Données concernées
                _Section(title: I18n.t('dp_s1_title'), children: [
                  _p(I18n.t('dp_s1_intro')),
                  _li(I18n.t('dp_s1_li1')),
                  _li(I18n.t('dp_s1_li2')),
                  _li(I18n.t('dp_s1_li3')),
                  _li(I18n.t('dp_s1_li4')),
                ]),

                // 2. Procédure de demande
                _Section(title: I18n.t('dp_s2_title'), children: [
                  _p(I18n.t('dp_s2_intro', params: _params)),
                  _li(I18n.t('dp_s2_step1', params: _params)),
                  _li(I18n.t('dp_s2_step2')),
                  _li(I18n.t('dp_s2_step3')),
                ]),

                // 3. Délais de suppression
                _Section(title: I18n.t('dp_s3_title'), children: [
                  _li(I18n.t('dp_s3_li1')),
                  _li(I18n.t('dp_s3_li2')),
                ]),

                // 4. Données non supprimées immédiatement
                _Section(title: I18n.t('dp_s4_title'), children: [
                  _p(I18n.t('dp_s4_intro')),
                  _li(I18n.t('dp_s4_li1')),
                  _li(I18n.t('dp_s4_li2')),
                ]),

                // 5. Irréversibilité
                _Section(title: I18n.t('dp_s5_title'), children: [
                  _p(I18n.t('dp_s5_p1')),
                ]),

                // 6. Contact
                _Section(title: I18n.t('dp_s6_title'), children: [
                  _p(I18n.t('dp_s6_intro')),
                  _li(I18n.t('dp_s6_email', params: _params)),
                  _li(I18n.t('dp_s6_address', params: _params)),
                ]),
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
          Text(title,
              style:
              theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}
