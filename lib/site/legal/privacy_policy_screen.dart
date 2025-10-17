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

'fr': {
'legal_privacy': 'Politique de confidentialité',
'privacy_title': 'Politique de confidentialité',
'privacy_intro':
'Cette politique décrit comment {company} traite vos données lors de l’utilisation de {app}. '
'Elle est conforme au UK GDPR (Data Protection Act 2018) et, le cas échéant, au RGPD (UE).',
'privacy_last_update': 'Dernière mise à jour',

// Sections
'privacy_s1_title': '1. Responsable du traitement',
'privacy_s1_p1': '{company} (Company number: {companyNumber})',
'privacy_s1_p2': 'Adresse : {companyAddress}',
'privacy_s1_p3': 'Contact : {privacyEmail}',

'privacy_s2_title': '2. Données que nous collectons',
'privacy_s2_li1': 'Identifiants techniques : identifiant d’appareil, token de notification (FCM).',
'privacy_s2_li2': 'Données d’usage : niveaux atteints, score, temps de jeu, événements (install, open, play, levelFinished).',
'privacy_s2_li3': 'Données de communication facultatives : adresse e-mail si vous nous contactez.',
'privacy_s2_p4': 'Nous ne collectons pas de contenu sensible ni de données de localisation précises.',

'privacy_s3_title': '3. Finalités et bases légales',
'privacy_s3_li1': 'Fournir le service et les fonctionnalités de jeu (exécution du contrat / intérêt légitime).',
'privacy_s3_li2': 'Envoyer des notifications push (ex. rappel après 24h d’inactivité) : sur la base de votre consentement aux notifications de l’appareil.',
'privacy_s3_li3': 'Améliorer l’expérience (statistiques internes, correction d’anomalies) : intérêt légitime.',
'privacy_s3_li4': 'Communication et support : intérêt légitime / exécution du contrat.',

'privacy_s4_title': '4. Conservation des données',
'privacy_s4_p1': 'Nous conservons les données pendant la durée nécessaire à la finalité :',
'privacy_s4_li1': 'Événements de jeu et progression : tant que le compte/appareil est actif et pour une période raisonnable d’inactivité.',
'privacy_s4_li2': 'Tokens de notification : jusqu’à révocation/renouvellement ou désactivation des notifications.',
'privacy_s4_li3': 'Logs techniques : durées courtes nécessaires au diagnostic et à la sécurité.',

'privacy_s5_title': '5. Destinataires & sous-traitants',
'privacy_s5_p1': 'Nous pouvons partager des données avec :',
'privacy_s5_li1': 'Fournisseurs d’hébergement et backend (Supabase – Edge Functions & DB).',
'privacy_s5_li2': 'Fournisseur de notifications (Google Firebase Cloud Messaging).',
'privacy_s5_li3': 'Google Apps Script / Sheets pour la journalisation opérationnelle (installations, événements).',
'privacy_s5_p2': 'Ces tiers agissent comme sous-traitants selon des conditions contractuelles appropriées.',

'privacy_s6_title': '6. Transferts internationaux',
'privacy_s6_p1':
'Vos données peuvent être traitées et stockées hors du Royaume-Uni/UE. Lorsque cela se produit, nous utilisons des mécanismes de transfert '
'valides (ex. Clauses Contractuelles Types) et des garanties appropriées.',

'privacy_s7_title': '7. Vos droits',
'privacy_s7_p1':
'Conformément au UK GDPR / RGPD, vous disposez des droits suivants : accès, rectification, effacement, limitation, opposition, portabilité (le cas échéant). '
'Vous pouvez exercer vos droits en nous contactant : {privacyEmail}.',
'privacy_s7_p2':
'Vous pouvez également retirer votre consentement aux notifications dans les réglages de votre appareil. Selon votre juridiction, '
'vous pouvez introduire une réclamation auprès de l’autorité compétente (ex. ICO au Royaume-Uni).',

'privacy_s8_title': '8. Sécurité',
'privacy_s8_p1':
'Nous mettons en œuvre des mesures techniques et organisationnelles raisonnables pour protéger vos données (chiffrement en transit, contrôle d’accès, journalisation). '
'Aucune mesure n’offrant une sécurité absolue, nous vous recommandons de protéger votre appareil et vos accès.',

'privacy_s9_title': '9. Mineurs',
'privacy_s9_p1':
'{app} est destiné à un public général et ne cible pas spécifiquement les enfants. '
'Si vous pensez qu’un mineur nous a fourni des données sans consentement approprié, contactez-nous pour suppression.',

'privacy_s10_title': '10. Cookies / analytics',
'privacy_s10_p1':
'{app} n’utilise pas de cookies de navigateur. Des métriques techniques et anonymisées peuvent être collectées via Firebase Analytics à des fins statistiques internes.',

'privacy_s11_title': '11. Notifications push',
'privacy_s11_p1':
'Nous utilisons des notifications pour vous rappeler de revenir jouer (ex. après 24h d’inactivité). '
'Vous pouvez les désactiver dans les réglages système de votre appareil à tout moment.',

'privacy_c_title': '12. Informations collectées pour les publicités',
'privacy_c_intro': 'Nous ne collectons aucune information personnelle (comme le nom, l’adresse e-mail, le numéro de téléphone ou la localisation précise). Cependant, certaines données peuvent être collectées automatiquement par des services tiers intégrés pour faire fonctionner et améliorer l’application :',
'privacy_c_admob_title': 'a. Google AdMob (publicités)',
'privacy_c_admob_p1': 'Nous utilisons Google AdMob pour diffuser des bannières et des annonces interstitielles. AdMob peut collecter et utiliser des identifiants publicitaires anonymes (par exemple, l’ID publicitaire Android) afin de :',
'privacy_c_admob_b1': '• diffuser des annonces pertinentes ;',
'privacy_c_admob_b2': '• mesurer la performance des publicités ;',
'privacy_c_admob_b3': '• limiter le nombre d’affichages d’une même publicité.',
'privacy_c_admob_note': 'Ces données ne permettent pas de vous identifier personnellement.',
'privacy_c_admob_link': 'En savoir plus : https://policies.google.com/privacy',
'privacy_c_usage_title': 'b. Données d’utilisation et de diagnostic',
'privacy_c_usage_p1': 'Nous pouvons recevoir automatiquement des informations techniques anonymes (ex. : plantages, erreurs, performance de l’app) afin d’améliorer la stabilité et l’expérience utilisateur.',

'privacy_share_title': '13. Partage des informations',
'privacy_share_p1': 'Nous ne partageons pas de données personnelles. Les seules données éventuellement partagées le sont de manière anonyme et agrégée via les services tiers mentionnés ci-dessus (AdMob / Google Play Services).',

'privacy_security_title': '14. Sécurité des données',
'privacy_security_p1': 'Toutes les données transmises sont chiffrées via HTTPS. Aucune donnée sensible (mot de passe, fichier personnel, photo, localisation précise, etc.) n’est collectée ni stockée.',

'privacy_ads_title': '15. Publicités',
'privacy_ads_p1': 'Les publicités affichées dans Wordix proviennent de Google AdMob, un réseau publicitaire certifié par Google Play. Elles respectent les politiques familiales de Google Play et ne contiennent pas de contenu inapproprié.',
'privacy_ads_link': 'Gérez vos préférences publicitaires : https://adssettings.google.com',

'privacy_rights_title': '16. Droits de l’utilisateur',
'privacy_rights_p1': 'Comme aucune donnée personnelle n’est collectée directement par Wordix, nous n’avons pas besoin de procédures de suppression ou d’accès aux données. Toute demande liée à AdMob peut être adressée à Google via sa page de confidentialité.',

'privacy_s12_title': '17. Modifications de cette politique',
'privacy_s12_p1':
'Nous pouvons mettre à jour cette politique pour refléter des changements légaux, techniques ou opérationnels. '
'La version publiée dans l’app fait foi ; nous vous invitons à la consulter régulièrement.',

'privacy_s13_title': '18. Contact',
'privacy_s13_intro': 'Pour toute question ou demande relative à la confidentialité :',
'privacy_s13_li1': 'E-mail support : {contactEmail}',
'privacy_s13_li2': 'E-mail confidentialité : {privacyEmail}',
'privacy_s13_li3': 'Adresse postale : {companyAddress}',

},

'en': {
'legal_privacy': 'Privacy policy',
'privacy_title': 'Privacy policy',
'privacy_intro':
'This policy explains how {company} processes your data when using {app}. '
'It complies with the UK GDPR (Data Protection Act 2018) and, where applicable, the EU GDPR.',
'privacy_last_update': 'Last update',

'privacy_s1_title': '1. Controller',
'privacy_s1_p1': '{company} (Company number: {companyNumber})',
'privacy_s1_p2': 'Address: {companyAddress}',
'privacy_s1_p3': 'Contact: {privacyEmail}',

'privacy_s2_title': '2. Data we collect',
'privacy_s2_li1': 'Technical identifiers: device ID, push token (FCM).',
'privacy_s2_li2': 'Usage data: levels reached, score, play time, events (install, open, play, levelFinished).',
'privacy_s2_li3': 'Optional communication data: email address if you contact us.',
'privacy_s2_p4': 'We do not collect sensitive content nor precise geolocation.',

'privacy_s3_title': '3. Purposes & legal bases',
'privacy_s3_li1': 'Provide the service and game features (contract performance / legitimate interest).',
'privacy_s3_li2': 'Send push notifications (e.g., 24h inactivity reminder): based on your device notification consent.',
'privacy_s3_li3': 'Improve experience (internal stats, bug fixing): legitimate interest.',
'privacy_s3_li4': 'Communication & support: legitimate interest / contract performance.',

'privacy_s4_title': '4. Data retention',
'privacy_s4_p1': 'We keep data for the time necessary to fulfil the purpose:',
'privacy_s4_li1': 'Game events and progress: while the account/device is active and for a reasonable period of inactivity.',
'privacy_s4_li2': 'Push tokens: until revocation/renewal or notifications are disabled.',
'privacy_s4_li3': 'Technical logs: short periods needed for diagnostics and security.',

'privacy_s5_title': '5. Recipients & processors',
'privacy_s5_p1': 'We may share data with:',
'privacy_s5_li1': 'Hosting/backend providers (Supabase – Edge Functions & DB).',
'privacy_s5_li2': 'Push provider (Google Firebase Cloud Messaging).',
'privacy_s5_li3': 'Google Apps Script / Sheets for operational logging (installs, events).',
'privacy_s5_p2': 'These parties act as processors under appropriate contractual terms.',

'privacy_s6_title': '6. International transfers',
'privacy_s6_p1':
'Your data may be processed and stored outside the UK/EU. Where this happens, we use valid transfer mechanisms '
'(e.g., Standard Contractual Clauses) and appropriate safeguards.',

'privacy_s7_title': '7. Your rights',
'privacy_s7_p1':
'Under the UK GDPR / GDPR you have the following rights: access, rectification, erasure, restriction, objection, portability (where applicable). '
'You can exercise your rights by contacting us at: {privacyEmail}.',
'privacy_s7_p2':
'You may also withdraw your notification consent in your device settings. Depending on your jurisdiction, '
'you can lodge a complaint with the competent authority (e.g., the ICO in the UK).',

'privacy_s8_title': '8. Security',
'privacy_s8_p1':
'We implement reasonable technical and organisational measures to protect your data (in-transit encryption, access control, logging). '
'No measure is absolutely secure; please protect your device and credentials.',

'privacy_s9_title': '9. Minors',
'privacy_s9_p1':
'{app} targets a general audience and does not specifically address children. '
'If you believe a minor provided data without proper consent, contact us to remove it.',

'privacy_s10_title': '10. Cookies / analytics',
'privacy_s10_p1':
'{app} does not use browser cookies. Technical/aggregated metrics may be collected via Firebase Analytics for internal statistics.',

'privacy_s11_title': '11. Push notifications',
'privacy_s11_p1':
'We use notifications to remind you to come back and play (e.g., after 24h of inactivity). '
'You can disable them anytime in your device settings.',

'privacy_c_title': '12. Information collected for advertising',
'privacy_c_intro': 'We do not collect any personal information (such as name, email address, phone number, or precise location). However, some data may be collected automatically by integrated third-party services to operate and improve the app:',
'privacy_c_admob_title': 'a. Google AdMob (ads)',
'privacy_c_admob_p1': 'We use Google AdMob to serve banner and interstitial ads. AdMob may collect and use anonymous advertising identifiers (e.g., Android Advertising ID) in order to:',
'privacy_c_admob_b1': '• serve relevant ads;',
'privacy_c_admob_b2': '• measure ad performance;',
'privacy_c_admob_b3': '• limit the number of times the same ad is shown.',
'privacy_c_admob_note': 'This data does not personally identify you.',
'privacy_c_admob_link': 'Learn more: https://policies.google.com/privacy',
'privacy_c_usage_title': 'b. Usage and diagnostics data',
'privacy_c_usage_p1': 'We may automatically receive anonymous technical information (e.g., crashes, errors, app performance) to improve stability and user experience.',

'privacy_share_title': '13. Information sharing',
'privacy_share_p1': 'We do not share personal data. Any data that might be shared is anonymous and aggregated through the third-party services mentioned above (AdMob / Google Play Services).',

'privacy_security_title': '14. Data security',
'privacy_security_p1': 'All transmitted data is encrypted via HTTPS. No sensitive data (passwords, personal files, photos, precise location, etc.) is collected or stored.',

'privacy_ads_title': '15. Advertising',
'privacy_ads_p1': 'Ads shown in Wordix come from Google AdMob, a Google Play-certified ad network. They comply with Google Play Families policies and do not contain inappropriate content.',
'privacy_ads_link': 'Manage your ad preferences: https://adssettings.google.com',

'privacy_rights_title': '16. User rights',
'privacy_rights_p1': 'Since no personal data is collected directly by Wordix, we do not require data deletion or access procedures. Any request related to AdMob can be addressed to Google via its privacy page.',

'privacy_s12_title': '17. Policy changes',
'privacy_s12_p1':
'We may update this policy to reflect legal, technical, or operational changes. The version published in the app prevails; please review it regularly.',

'privacy_s13_title': '18. Contact',
'privacy_s13_intro': 'For any privacy question or request:',
'privacy_s13_li1': 'Support email: {contactEmail}',
'privacy_s13_li2': 'Privacy email: {privacyEmail}',
'privacy_s13_li3': 'Postal address: {companyAddress}',
}
