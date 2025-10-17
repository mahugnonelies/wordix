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


'fr': {
'legal_terms': 'Conditions d’utilisation',

'terms_title': 'Conditions d’utilisation',

'terms_s1_title': '1. Acceptation',
'terms_s1_p1':
'En installant, accédant ou utilisant {app}, vous acceptez sans réserve les présentes Conditions d’utilisation. '
'Si vous n’êtes pas d’accord, veuillez ne pas utiliser l’application.',

'terms_s2_title': '2. Accès et compte',
'terms_s2_p1':
'L’accès au service peut nécessiter une connexion Internet et, selon les fonctionnalités, un identifiant d’appareil ou un compte. '
'Vous êtes responsable de la confidentialité de vos informations et de l’usage qui en est fait.',

'terms_s3_title': '3. Licence d’utilisation',
'terms_s3_p1':
'Nous vous concédons une licence personnelle, non exclusive, non transférable et révocable pour utiliser {app} à des fins personnelles et non commerciales. '
'Toute utilisation contraire (reproduction, modification, ingénierie inverse, revente) est interdite.',

'terms_s4_title': '4. Contenus et comportement',
'terms_s4_p1':
'Vous vous engagez à ne pas perturber le bon fonctionnement du service ni utiliser l’application à des fins illicites. '
'Nous pouvons retirer tout contenu inapproprié et suspendre l’accès en cas de violation.',

'terms_s5_title': '5. Fonctionnalités (notifications, progression)',
'terms_s5_p1':
'{app} peut envoyer des notifications (par exemple, rappels après 24h d’inactivité). '
'Vous pouvez gérer ces notifications dans les réglages de votre appareil. '
'La progression (niveaux, scores) peut être stockée localement et/ou côté serveur pour améliorer l’expérience et la continuité de jeu.',

'terms_s6_title': '6. Données personnelles',
'terms_s6_p1':
'Certaines données techniques et d’usage (ID appareil, niveau, temps de jeu, token push) peuvent être traitées conformément à nos Mentions légales '
'et à la politique de confidentialité. Vous pouvez exercer vos droits (accès, rectification, effacement, opposition) à l’adresse : {privacyEmail}.',

'terms_s7_title': '7. Mises à jour et disponibilité',
'terms_s7_p1':
'Nous pouvons apporter des mises à jour (correctifs, nouvelles fonctionnalités). Le service peut être temporairement indisponible pour maintenance ou raisons techniques.',

'terms_s8_title': '8. Limitation de responsabilité',
'terms_s8_p1':
'Dans les limites permises par la loi, {company} ne saurait être tenue responsable des dommages indirects, pertes de données ou préjudices résultant '
'de l’utilisation ou de l’impossibilité d’utiliser {app}.',

'terms_s9_title': '9. Résiliation',
'terms_s9_p1':
'Nous pouvons suspendre ou résilier l’accès à {app} en cas de violation des présentes Conditions. '
'Vous pouvez cesser d’utiliser l’application à tout moment et demander la suppression de vos données en nous contactant.',

'terms_s10_title': '10. Modifications',
'terms_s10_p1':
'Nous pouvons modifier ces Conditions à tout moment. La poursuite de l’utilisation après publication vaut acceptation. '
'Nous vous invitons à consulter régulièrement cette page.',

'terms_s11_title': '11. Droit applicable & litiges',
'terms_s11_p1':
'Ces Conditions sont régies par le droit britannique (UK). Tout litige sera soumis aux juridictions compétentes de Londres.',

'terms_s12_title': '12. Contact',
'terms_s12_p1': 'Pour toute question : {contactEmail}',

}

'en': {
'legal_terms': 'Terms of use',
'terms_title': 'Terms of use',

'terms_s1_title': '1. Acceptance',
'terms_s1_p1':
'By installing, accessing or using {app}, you unconditionally agree to these Terms of Use. '
'If you do not agree, please do not use the application.',

'terms_s2_title': '2. Access & account',
'terms_s2_p1':
'Access to the service may require an Internet connection and, depending on the features, a device ID or an account. '
'You are responsible for keeping your information confidential and for its use.',

'terms_s3_title': '3. Licence',
'terms_s3_p1':
'We grant you a personal, non-exclusive, non-transferable and revocable licence to use {app} for personal, non-commercial purposes. '
'Any contrary use (reproduction, modification, reverse engineering, resale) is prohibited.',

'terms_s4_title': '4. Content & conduct',
'terms_s4_p1':
'You agree not to disrupt the proper functioning of the service nor use the app for unlawful purposes. '
'We may remove inappropriate content and suspend access in case of violation.',

'terms_s5_title': '5. Features (notifications, progress)',
'terms_s5_p1':
'{app} may send notifications (e.g., reminders after 24h of inactivity). You can manage them in your device settings. '
'Progress (levels, scores) may be stored locally and/or server-side to improve experience and continuity.',

'terms_s6_title': '6. Personal data',
'terms_s6_p1':
'Certain technical and usage data (device ID, level, play time, push token) may be processed in accordance with our Legal Notice '
'and Privacy Policy. You can exercise your rights (access, rectification, erasure, objection) at: {privacyEmail}.',

'terms_s7_title': '7. Updates & availability',
'terms_s7_p1':
'We may deliver updates (bug fixes, new features). The service may be temporarily unavailable for maintenance or technical reasons.',

'terms_s8_title': '8. Limitation of liability',
'terms_s8_p1':
'To the extent permitted by law, {company} shall not be liable for indirect damages, data loss or harm resulting from the use of, '
'or inability to use, {app}.',

'terms_s9_title': '9. Termination',
'terms_s9_p1':
'We may suspend or terminate access to {app} in case of breach of these Terms. '
'You may stop using the app at any time and request deletion of your data by contacting us.',

'terms_s10_title': '10. Changes',
'terms_s10_p1':
'We may amend these Terms at any time. Continued use after publication constitutes acceptance. Please review this page regularly.',

'terms_s11_title': '11. Governing law & disputes',
'terms_s11_p1':
'These Terms are governed by UK law. Any dispute will be submitted to the competent courts of London.',

'terms_s12_title': '12. Contact',
'terms_s12_p1': 'For any question: {contactEmail}',

}