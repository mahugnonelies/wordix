import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i18n.dart';
import 'site/landing_page.dart';
import 'site/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await I18n.init();
  runApp(const WordixSite());
}

class WordixSite extends StatelessWidget {
  const WordixSite({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: I18n.locale,
      builder: (_, locale, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: I18n.t('app_title'),
          locale: locale,
          supportedLocales: const [Locale('fr'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: buildSiteTheme(),
          home: const LandingPage(),
        );
      },
    );
  }
}
