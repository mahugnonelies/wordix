// lib/i18n.dart
import 'dart:ui' show PlatformDispatcher, Locale;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class I18n {
  static const _prefKey = 'app_locale';
  static const supported = <String>['fr', 'en'];

  // Locale courante observable
  static final ValueNotifier<Locale> locale =
  ValueNotifier<Locale>(const Locale('en'));

  // Pays francophones courants pour auto-sélection FR
  static const Set<String> _frCountries = {
    'FR','BE','CH','CA','LU','MC','HT','CM','CI','BF','NE','SN','ML','TG','BJ','TD','CF','GA','GN',
    'CG','CD','RW','BI','DJ','KM','MG','MU','SC','RE','YT','MA','DZ','TN','MR','NC','PF','WF','GF','PM','LB','VU'
  };

  /// Initialise la langue depuis prefs ou système.
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey);
    if (saved != null && supported.contains(saved)) {
      locale.value = Locale(saved);
      return;
    }
    final sys = PlatformDispatcher.instance.locale;
    final lang = sys.languageCode.toLowerCase();
    final country = (sys.countryCode ?? '').toUpperCase();
    locale.value = (lang == 'fr' || _frCountries.contains(country))
        ? const Locale('fr')
        : const Locale('en');
  }

  /// Force une langue et la persiste.
  static Future<void> setLocale(String code) async {
    if (!supported.contains(code)) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, code);
    locale.value = Locale(code);
  }

  /// Traduction avec paramètres et **secours** (fallback) optionnel.
  static String t(String key, {Map<String, String>? params, String? fallback}) {
    final lang = locale.value.languageCode;
    final bundle = _strings[lang] ?? _strings['en']!;
    var text = bundle[key] ?? fallback ?? key;
    if (params != null) {
      params.forEach((k, v) {
        text = text.replaceAll('{$k}', v);
      });
    }
    return text;
  }

  // ====== Dictionnaires ======
  static final Map<String, Map<String, String>> _strings = {
    'fr': {
      'app_title': 'Wordix',
      'continue': 'Continuer',
      'language_french': 'Français',
      'language_english': 'English',
      'hero_title': 'Wordix — Puzzle de lettres',
      'hero_subtitle':
      'Cercle de lettres, niveaux, chrono et score. Bilingue FR/EN.',
      'cta_play': 'Jouer en ligne',
      'cta_download': 'Télécharger',
      'features_title': 'Fonctionnalités',
      'feature_i18n': 'Bilingue automatique',
      'feature_i18n_desc': 'Détection FR/EN + choix manuel intégré.',
      'feature_gameplay': 'Gameplay tactile',
      'feature_gameplay_desc': 'Cercle de lettres, glisser, validation rapide.',
      'feature_progress': 'Niveaux & score',
      'feature_progress_desc': 'Progression, pagination, sauvegarde, chrono.',
      'legal_title': 'Mentions légales',
      'legal_privacy': 'Politique de confidentialité',
      'legal_terms': 'Conditions d’utilisation',
      'legal_mentions': 'Mentions légales',
      'legal_about': 'À propos',
      'footer_rights': 'Tous droits réservés.',
      // Titres & intro
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

      'privacy_s12_title': '12. Modifications de cette politique',
      'privacy_s12_p1':
      'Nous pouvons mettre à jour cette politique pour refléter des changements légaux, techniques ou opérationnels. '
          'La version publiée dans l’app fait foi ; nous vous invitons à la consulter régulièrement.',

      'privacy_s13_title': '13. Contact',
      'privacy_s13_intro': 'Pour toute question ou demande relative à la confidentialité :',
      'privacy_s13_li1': 'E-mail support : {contactEmail}',
      'privacy_s13_li2': 'E-mail confidentialité : {privacyEmail}',
      'privacy_s13_li3': 'Adresse postale : {companyAddress}',

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

      // En-tête
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

      'hero_title': 'Wordix – Le jeu de lettres éducatif',
      'hero_subtitle': 'Amusez-vous en apprenant avec des puzzles de mots en français et en anglais.',
      'cta_play': 'Jouer maintenant',
      'cta_download': 'Télécharger',

      'screenshots_title': 'Captures d’écran',
      'features_title': 'Fonctionnalités principales',
      'feature_i18n': 'Traduction automatique',
      'feature_i18n_desc': 'Disponible en français et en anglais selon la langue du téléphone.',
      'feature_gameplay': 'Gameplay ludique',
      'feature_gameplay_desc': 'Des puzzles de mots dynamiques avec progression par niveaux.',
      'feature_progress': 'Suivi des progrès',
      'feature_progress_desc': 'Votre progression est sauvegardée et visible à tout moment.',

      'badge_secure': 'Sécurisé ({x})',
      'badge_updates': 'Mises à jour ({x})',
      'badge_rating': 'Note ({x})',

      'cta_banner_title': 'Prêt à entraîner votre esprit ?',
      'cta_banner_subtitle': 'Des puzzles progressifs, fun et éducatifs, accessibles partout.',

      'legal_title': 'Mentions légales & documents',
      'legal_privacy': 'Politique de confidentialité',
      'legal_terms': 'Conditions d’utilisation',
      'legal_mentions': 'Mentions légales',
      'dp_title': 'Suppression des données',
      'legal_about': 'À propos',
      'footer_rights': 'Tous droits réservés',

      // 404 / Not found (utilisé par onUnknownRoute)
      'not_found_title': 'Page introuvable',
      'not_found_body': 'La page demandée est introuvable.',
      'back_home': 'Retour à l’accueil',


    },

    'en': {
      'app_title': 'Wordix',
      'continue': 'Continue',
      'language_french': 'Français',
      'language_english': 'English',
      'hero_title': 'Wordix — Letter puzzle',
      'hero_subtitle':
      'Letter wheel, levels, timer and score. Bilingual FR/EN.',
      'cta_play': 'Play online',
      'cta_download': 'Download',
      'features_title': 'Features',
      'feature_i18n': 'Automatic bilingual',
      'feature_i18n_desc': 'FR/EN detection + manual selection.',
      'feature_gameplay': 'Touch gameplay',
      'feature_gameplay_desc': 'Letter wheel, swipe, quick validation.',
      'feature_progress': 'Levels & score',
      'feature_progress_desc': 'Progress, pagination, save, timer.',
      'legal_title': 'Legal',
      'legal_privacy': 'Privacy policy',
      'legal_terms': 'Terms of use',
      'legal_mentions': 'Legal notice',
      'legal_about': 'About',
      'footer_rights': 'All rights reserved.',

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

      'privacy_s12_title': '12. Policy changes',
      'privacy_s12_p1':
      'We may update this policy to reflect legal, technical, or operational changes. The version published in the app prevails; please review it regularly.',

      'privacy_s13_title': '13. Contact',
      'privacy_s13_intro': 'For any privacy question or request:',
      'privacy_s13_li1': 'Support email: {contactEmail}',
      'privacy_s13_li2': 'Privacy email: {privacyEmail}',
      'privacy_s13_li3': 'Postal address: {companyAddress}',

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

      // Header
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

      'hero_title': 'Wordix – The Educational Word Puzzle Game',
      'hero_subtitle': 'Have fun while learning with word puzzles in French and English.',
      'cta_play': 'Play Now',
      'cta_download': 'Download',

      'screenshots_title': 'Screenshots',
      'features_title': 'Key Features',
      'feature_i18n': 'Auto Translation',
      'feature_i18n_desc': 'Available in French and English depending on phone language.',
      'feature_gameplay': 'Fun Gameplay',
      'feature_gameplay_desc': 'Dynamic word puzzles with progressive levels.',
      'feature_progress': 'Track Progress',
      'feature_progress_desc': 'Your progress is saved and visible at any time.',

      'badge_secure': 'Secure ({x})',
      'badge_updates': 'Updates ({x})',
      'badge_rating': 'Rating ({x})',

      'cta_banner_title': 'Ready to train your mind?',
      'cta_banner_subtitle': 'Progressive, fun, and educational puzzles, accessible everywhere.',

      'legal_title': 'Legal & Documents',
      'legal_privacy': 'Privacy Policy',
      'legal_terms': 'Terms of Use',
      'legal_mentions': 'Legal Notice',
      'dp_title': 'Data Deletion Policy',
      'legal_about': 'About',
      'footer_rights': 'All rights reserved',

      // 404
      'not_found_title': 'Page not found',
      'not_found_body': 'The requested page could not be found.',
      'back_home': 'Back to home',


    },
  };
}