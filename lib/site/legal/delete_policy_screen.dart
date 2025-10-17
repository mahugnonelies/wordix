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


'fr': {

'dp_title': 'Politique de suppression des données',
'dp_heading': 'Politique de suppression des données — {app}',

'dp_s1_title': '1. Données concernées',
'dp_s1_intro': 'La suppression de compte entraîne la suppression des données suivantes :',
'dp_s1_li1': 'Identifiant anonyme généré par l’application.',
'dp_s1_li2': 'Progression des niveaux et statistiques de jeu.',
'dp_s1_li3': 'Token de notifications push.',
'dp_s1_li4': 'Historique technique minimal lié à votre session de jeu.',

'dp_s2_title': '2. Procédure de demande',
'dp_s2_intro': 'Pour demander la suppression de vos données :',
'dp_s2_step1': 'Envoyez un e-mail à {contactEmail} avec pour objet : « Suppression de compte ».',
'dp_s2_step2': 'Indiquez l’adresse e-mail ou l’identifiant associé à votre compte.',
'dp_s2_step3': 'Une confirmation vous sera envoyée une fois la suppression effectuée.',

'dp_s3_title': '3. Délais de suppression',
'dp_s3_li1': 'Vos données sont supprimées dans un délai maximum de 30 jours à compter de la réception de votre demande.',
'dp_s3_li2': 'Certaines données techniques (ex. journaux de sécurité) peuvent être conservées temporairement pour des raisons légales, mais elles sont dissociées de votre identité.',

'dp_s4_title': '4. Données non supprimées immédiatement',
'dp_s4_intro': 'Conformément à la réglementation, certaines données peuvent être conservées temporairement :',
'dp_s4_li1': 'Données de sécurité : jusqu’à 90 jours maximum.',
'dp_s4_li2': 'Obligations légales : certaines informations peuvent être conservées plus longtemps si la loi l’exige.',

'dp_s5_title': '5. Irréversibilité',
'dp_s5_p1': '⚠️ La suppression est définitive et irréversible. Une fois vos données supprimées, il ne sera plus possible de les restaurer.',

'dp_s6_title': '6. Contact',
'dp_s6_intro': 'Pour toute question concernant cette politique ou vos droits :',
'dp_s6_email': '📧 {contactEmail}',
'dp_s6_address': '🏢 {company} – {companyAddress}',
}

'en': {

'dp_title': 'Data deletion policy',
'dp_heading': 'Data deletion policy — {app}',

'dp_s1_title': '1. Data concerned',
'dp_s1_intro': 'Account deletion results in removal of the following data:',
'dp_s1_li1': 'Anonymous identifier generated by the app.',
'dp_s1_li2': 'Level progress and gameplay statistics.',
'dp_s1_li3': 'Push notification token.',
'dp_s1_li4': 'Minimal technical history related to your game session.',

'dp_s2_title': '2. Request procedure',
'dp_s2_intro': 'To request deletion of your data:',
'dp_s2_step1': 'Send an email to {contactEmail} with the subject: “Account deletion”.',
'dp_s2_step2': 'Provide the email address or identifier associated with your account.',
'dp_s2_step3': 'A confirmation will be sent once the deletion is completed.',

'dp_s3_title': '3. Deletion timelines',
'dp_s3_li1': 'Your data will be deleted within a maximum of 30 days from receipt of your request.',
'dp_s3_li2': 'Some technical data (e.g., security logs) may be retained temporarily for legal reasons, but are dissociated from your identity.',

'dp_s4_title': '4. Data not deleted immediately',
'dp_s4_intro': 'In accordance with regulations, certain data may be retained temporarily:',
'dp_s4_li1': 'Security data: up to 90 days maximum.',
'dp_s4_li2': 'Legal obligations: some information may be kept longer if required by law.',

'dp_s5_title': '5. Irreversibility',
'dp_s5_p1': '⚠️ Deletion is final and irreversible. Once your data is deleted, it cannot be restored.',

'dp_s6_title': '6. Contact',
'dp_s6_intro': 'For any questions about this policy or your rights:',
'dp_s6_email': '📧 {contactEmail}',
'dp_s6_address': '🏢 {company} – {companyAddress}',

}