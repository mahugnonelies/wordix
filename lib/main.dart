// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'i18n.dart';
import 'site/theme.dart';
import 'site/landing_page.dart';

// --- Pages légales ---
import 'site/legal/privacy_policy_screen.dart';
import 'site/legal/terms_screen.dart';
import 'site/legal/legal_notice_screen.dart';
import 'site/legal/delete_policy_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // URLs propres sur le Web: https://domain.tld/route (sans #)
  setUrlStrategy(PathUrlStrategy());

  await I18n.init();
  runApp(const WordixSite());
}

class WordixSite extends StatelessWidget {
  const WordixSite({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: I18n.locale,
      builder: (_, locale, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: I18n.t('app_title'),
          theme: buildSiteTheme(),

          locale: locale,
          supportedLocales: const [Locale('fr'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // === Routes nommées ===
          routes: {
            '/':                 (_) => const LandingPage(),
            '/privacy':          (_) => const PrivacyPolicyScreen(),
            '/terms':            (_) => const TermsScreen(),
            '/legal-notice':     (_) => const LegalNoticeScreen(),
            '/delete-policy':    (_) => const DeletePolicyScreen(),
          },

          // Page 404 Flutter si l’URL ne correspond à aucune route
          onUnknownRoute: (_) => MaterialPageRoute(
            builder: (_) => const _NotFoundPage(),
          ),
        );
      },
    );
  }
}

// Petite page 404 (optionnelle)
class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(I18n.t('not_found_title', fallback: 'Page introuvable'),
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text(I18n.t('not_found_body',
                  fallback: 'La page demandée est introuvable.')),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false),
                child: Text(I18n.t('back_home', fallback: 'Retour à l’accueil')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
