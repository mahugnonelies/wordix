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

  // ====== Dictionnaires =====
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

      'not_found_title': 'Page not found',
      'not_found_body': 'The requested page could not be found.',
      'back_home': 'Back to home',
    },
  };
}