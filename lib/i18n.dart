import 'dart:ui' show PlatformDispatcher, Locale;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class I18n {
  static const _prefKey = 'app_locale';
  static const supported = <String>['fr', 'en'];

  static final ValueNotifier<Locale> locale =
  ValueNotifier<Locale>(const Locale('en'));

  static const Set<String> _frCountries = {
    'FR','BE','CH','CA','LU','MC','HT','CM','CI','BF','NE','SN','ML','TG','BJ','TD','CF','GA','GN',
    'CG','CD','RW','BI','DJ','KM','MG','MU','SC','RE','YT','MA','DZ','TN','MR','NC','PF','WF','GF','PM','LB','VU'
  };

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
        ? const Locale('fr') : const Locale('en');
  }

  static Future<void> setLocale(String code) async {
    if (!supported.contains(code)) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, code);
    locale.value = Locale(code);
  }

  static String t(String key, {Map<String, String>? params}) {
    final lang = locale.value.languageCode;
    final bundle = _strings[lang] ?? _strings['en']!;
    var value = bundle[key] ?? key;
    params?.forEach((k, v) => value = value.replaceAll('{$k}', v));
    return value;
  }

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
    },
  };
}
