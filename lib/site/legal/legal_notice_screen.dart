import 'package:flutter/material.dart';
import '../../i18n.dart';

class LegalNoticeScreen extends StatelessWidget {
  const LegalNoticeScreen({super.key});

  // 🔧 Renseigne ces constantes une fois pour toutes
  static const _appName = 'Wordix';
  static const _companyName = 'MAHUGNON SERVICES LTD';
  static const _companyNumber = '16010860';
  static const _companyAddress =
      '20 Wenlock Road, London, N1 7GU, United Kingdom';
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
      appBar: AppBar(title: Text(I18n.t('legal_mentions'))),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('ln_title', params: _params),
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),

                _Section(title: I18n.t('ln_s1_title'), children: [
                  _p(I18n.t('ln_s1_p0', params: _params)),
                  _li(I18n.t('ln_s1_li1', params: _params)),
                  _li(I18n.t('ln_s1_li2')),
                  _li(I18n.t('ln_s1_li3', params: _params)),
                  _li(I18n.t('ln_s1_li4', params: _params)),
                  _li(I18n.t('ln_s1_li5', params: _params)),
                ]),

                _Section(title: I18n.t('ln_s2_title'), children: [
                  _p(I18n.t('ln_s2_p_dist')),
                  _li(I18n.t('ln_s2_li_play')),
                  _li(I18n.t('ln_s2_li_appstore')),
                  const SizedBox(height: 8),
                  _p(I18n.t('ln_s2_p_backend')),
                  _li(I18n.t('ln_s2_li_supabase')),
                  _li(I18n.t('ln_s2_li_firebase')),
                ]),

                _Section(title: I18n.t('ln_s3_title', params: _params), children: [
                  _p(I18n.t('ln_s3_p1', params: _params)),
                ]),

                _Section(title: I18n.t('ln_s4_title'), children: [
                  _p(I18n.t('ln_s4_p1', params: _params)),
                ]),

                _Section(title: I18n.t('ln_s5_title'), children: [
                  _p(I18n.t('ln_s5_p_intro')),
                  _p(I18n.t('ln_s5_p_resp', params: _params)),
                  _p(I18n.t('ln_s5_p_basis')),
                  _p(I18n.t('ln_s5_p_rights', params: _params)),
                ]),

                _Section(title: I18n.t('ln_s6_title'), children: [
                  _p(I18n.t('ln_s6_p1')),
                ]),

                _Section(title: I18n.t('ln_s7_title'), children: [
                  _p(I18n.t('ln_s7_p1')),
                ]),

                const SizedBox(height: 24),
                Text('${I18n.t("privacy_last_update")} : ${_fmtDate(DateTime.now())}',
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

'fr': {
'legal_mentions': 'Mentions légales',
'ln_title': '{app} – Mentions légales',

// 1. Éditeur
'ln_s1_title': '1. Éditeur de l’application',
'ln_s1_p0': 'L’application {app} est éditée par :',
'ln_s1_li1': '{company}',
'ln_s1_li2': 'Société enregistrée au Royaume-Uni (UK)',
'ln_s1_li3': 'Company number : {companyNumber}',
'ln_s1_li4': 'Adresse du siège social : {companyAddress}',
'ln_s1_li5': 'E-mail : {contactEmail}',

// 2. Hébergement & services
'ln_s2_title': '2. Hébergement & services',
'ln_s2_p_dist': 'Distribution :',
'ln_s2_li_play':
'Google Play Store (Google Ireland Limited – Gordon House, Barrow Street, Dublin 4, Irlande)',
'ln_s2_li_appstore':
'Apple App Store (Apple Distribution International Ltd – Hollyhill Industrial Estate, Cork, Irlande)',
'ln_s2_p_backend': 'Backend & données :',
'ln_s2_li_supabase': 'Supabase (Edge Functions & DB)',
'ln_s2_li_firebase': 'Google Cloud / Firebase (notifications push, analytics)',

// 3. Propriété intellectuelle
'ln_s3_title': '3. Propriété intellectuelle',
'ln_s3_p1':
'L’ensemble des éléments de l’application ({app}) est protégé par le droit d’auteur et la propriété intellectuelle. '
'Toute reproduction, représentation ou adaptation, totale ou partielle, est interdite sans autorisation écrite préalable de {company}.',

// 4. Responsabilité
'ln_s4_title': '4. Responsabilité',
'ln_s4_p1':
'{app} est un jeu éducatif et ludique. L’éditeur ne saurait être tenu responsable en cas de dommages résultant d’un mauvais usage '
'ou d’interruptions temporaires de service (maintenance, pannes, mises à jour). L’utilisateur reste seul responsable de l’usage qu’il fait de l’application.',

// 5. Données personnelles & confidentialité
'ln_s5_title': '5. Données personnelles & confidentialité',
'ln_s5_p_intro':
'Des données peuvent être collectées (identifiant utilisateur, progression de jeu, tokens push, e-mail le cas échéant) '
'pour assurer le fonctionnement du service, envoyer des notifications et améliorer l’expérience.',
'ln_s5_p_resp': 'Responsable du traitement : {company} – {companyAddress}',
'ln_s5_p_basis':
'Base légale : consentement et intérêt légitime (UK GDPR / Data Protection Act 2018, RGPD UE).',
'ln_s5_p_rights':
'Droits : accès, rectification, effacement, opposition. Exercice des droits : {privacyEmail}',

// 6. Cookies
'ln_s6_title': '6. Cookies et traceurs',
'ln_s6_p1':
"L’application n’utilise pas de cookies de navigation. Des métriques techniques et anonymisées peuvent être collectées via Firebase Analytics à des fins de statistiques.",

// 7. Loi applicable
'ln_s7_title': '7. Loi applicable',
'ln_s7_p1':
'Les présentes mentions légales sont régies par le droit britannique (UK). En cas de litige, compétence exclusive des juridictions de Londres (Royaume-Uni).',

}

'en': {
'legal_mentions': 'Legal notice',
'ln_title': '{app} – Legal notice',

// 1. Publisher
'ln_s1_title': '1. App publisher',
'ln_s1_p0': 'The {app} application is published by:',
'ln_s1_li1': '{company}',
'ln_s1_li2': 'Company registered in the United Kingdom (UK)',
'ln_s1_li3': 'Company number: {companyNumber}',
'ln_s1_li4': 'Registered office address: {companyAddress}',
'ln_s1_li5': 'Email: {contactEmail}',

// 2. Hosting & services
'ln_s2_title': '2. Hosting & services',
'ln_s2_p_dist': 'Distribution:',
'ln_s2_li_play':
'Google Play Store (Google Ireland Limited – Gordon House, Barrow Street, Dublin 4, Ireland)',
'ln_s2_li_appstore':
'Apple App Store (Apple Distribution International Ltd – Hollyhill Industrial Estate, Cork, Ireland)',
'ln_s2_p_backend': 'Backend & data:',
'ln_s2_li_supabase': 'Supabase (Edge Functions & DB)',
'ln_s2_li_firebase': 'Google Cloud / Firebase (push notifications, analytics)',

// 3. Intellectual property
'ln_s3_title': '3. Intellectual property',
'ln_s3_p1':
'All elements of the application ({app}) are protected by copyright and intellectual property laws. '
'Any reproduction, representation or adaptation, in whole or in part, is prohibited without prior written authorisation from {company}.',

// 4. Liability
'ln_s4_title': '4. Liability',
'ln_s4_p1':
'{app} is an educational and entertainment game. The publisher cannot be held liable for damages resulting from misuse or from temporary service interruptions '
'(maintenance, outages, updates). The user remains solely responsible for his/her use of the app.',

// 5. Personal data & privacy
'ln_s5_title': '5. Personal data & privacy',
'ln_s5_p_intro':
'Data may be collected (user identifier, game progress, push tokens, email where applicable) to operate the service, send notifications and improve the experience.',
'ln_s5_p_resp': 'Controller: {company} – {companyAddress}',
'ln_s5_p_basis':
'Legal basis: consent and legitimate interest (UK GDPR / Data Protection Act 2018, EU GDPR).',
'ln_s5_p_rights':
'Rights: access, rectification, erasure, objection. Exercise of rights: {privacyEmail}',

// 6. Cookies
'ln_s6_title': '6. Cookies and trackers',
'ln_s6_p1':
'The application does not use browser cookies. Technical and aggregated metrics may be collected via Firebase Analytics for statistics purposes.',

// 7. Governing law
'ln_s7_title': '7. Governing law',
'ln_s7_p1':
'These legal notices are governed by UK law. In the event of a dispute, the courts of London (United Kingdom) shall have exclusive jurisdiction.',

}