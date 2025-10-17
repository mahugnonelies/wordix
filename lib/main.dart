// lib/main.dart
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'i18n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // URLs propres sur le web: https://domain/route  (sans #)
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
        final theme = buildSiteTheme();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: I18n.t('app_title'),
          theme: theme.copyWith(
            textTheme: GoogleFonts.interTextTheme(theme.textTheme),
          ),
          locale: locale,
          supportedLocales: const [Locale('fr'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // === Routes ===
          routes: {
            '/':              (_) => const LandingPage(),

            // Chaque page charge automatiquement privacy_fr.md / privacy_en.md
            '/privacy':       (_) => const _MarkdownPage.localized(
              titleKey: 'legal_privacy',
              baseName: 'privacy', // assets/legal/privacy_fr.md / _en.md
            ),
            '/terms':         (_) => const _MarkdownPage.localized(
              titleKey: 'legal_terms',
              baseName: 'terms',
            ),
            '/legal-notice':  (_) => const _MarkdownPage.localized(
              titleKey: 'legal_mentions',
              baseName: 'legal_notice',
            ),
            '/delete-policy': (_) => const _MarkdownPage.localized(
              titleKey: 'dp_title',
              baseName: 'delete_policy',
            ),
          },

          onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => const _NotFoundPage()),
        );
      },
    );
  }
}

/* -------------------------------------------------------
 *  PAGE MARKDOWN (multilingue auto)
 * -----------------------------------------------------*/
class _MarkdownPage extends StatelessWidget {
  final String titleKey;
  final String baseName;

  const _MarkdownPage.localized({
    required this.titleKey,
    required this.baseName,
    super.key,
  });

  Future<String> _load() async {
    final lang = I18n.locale.value.languageCode; // 'fr' ou 'en'
    // Ordre de recherche : _<lang>.md → _en.md → .md (sans suffixe)
    final candidates = <String>[
      'assets/legal/${baseName}_${lang}.md',
      'assets/legal/${baseName}_en.md',
      'assets/legal/${baseName}.md',
    ];
    for (final path in candidates) {
      try {
        return await rootBundle.loadString(path);
      } catch (_) {/* continue */}
    }
    // Message d'erreur friendly
    return '# Oups…\n\n'
        'Impossible de charger ce document.\n\n'
        'Fichiers attendus (dans l’ordre) :\n'
        '- assets/legal/${baseName}_${lang}.md\n'
        '- assets/legal/${baseName}_en.md\n'
        '- assets/legal/${baseName}.md\n\n'
        'Vérifie qu’ils existent et qu’ils sont listés dans **pubspec.yaml**.';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final title = I18n.t(titleKey);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<String>(
        future: _load(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          return Markdown(
            data: snap.data!,
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              h1: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
              h2: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              p: Theme.of(context).textTheme.bodyMedium,
              blockquoteDecoration: BoxDecoration(
                color: cs.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cs.primary.withOpacity(0.18)),
              ),
              codeblockDecoration: BoxDecoration(
                color: cs.surfaceVariant.withOpacity(0.35),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onTapLink: (text, href, title) {
              if (href != null) _launch(href);
            },
          );
        },
      ),
    );
  }
}

/* -------------------------------------------------------
 *  404 minimaliste
 * -----------------------------------------------------*/
class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();
  String _l(String fr, String en) => (I18n.locale.value.languageCode == 'fr') ? fr : en;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_l('Page introuvable', 'Page not found'),
                  style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text(_l('La page demandée est introuvable.', 'The requested page could not be found.'),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false),
                child: Text(_l("Retour à l'accueil", 'Back to home')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ======================================================
 *  LANDING (contenu existant)
 * ====================================================*/
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.t('app_title')),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Language',
            onSelected: (code) => I18n.setLocale(code),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'fr', child: Text(I18n.t('language_french'))),
              PopupMenuItem(value: 'en', child: Text(I18n.t('language_english'))),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: const [Icon(Icons.language), SizedBox(width: 6), Icon(Icons.arrow_drop_down)]),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: ListView(
        children: [
          // ----- HERO -----
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF0F172A), cs.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Section(child: _HeroHeader()),
          ),

          // ----- FEATURES -----
          Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('features_title'), style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3.2,
                  children: const [
                    _FeatureCard(icon: Icons.translate_rounded,      titleKey: 'feature_i18n',     subtitleKey: 'feature_i18n_desc'),
                    _FeatureCard(icon: Icons.sports_esports_rounded, titleKey: 'feature_gameplay', subtitleKey: 'feature_gameplay_desc'),
                    _FeatureCard(icon: Icons.star_rate_rounded,      titleKey: 'feature_progress', subtitleKey: 'feature_progress_desc'),
                  ],
                ),
              ],
            ),
          ),

          // ----- SCREENSHOTS -----
          Section(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _ScreenshotsTitle(),
                SizedBox(height: 12),
                _ResponsiveScreenshots(images: [
                  'assets/screenshots/s1.png',
                  'assets/screenshots/s2.png',
                  'assets/screenshots/s3.png',
                ]),
              ],
            ),
          ),

          // ----- CTA -----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0EA5E9), Color(0xFF6366F1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const _CtaBanner(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ----- FOOTER -----
          Section(
            child: Column(
              children: [
                const Divider(),
                const SizedBox(height: 12),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    _footerLink(I18n.t('legal_privacy'),   (ctx) => Navigator.of(ctx).pushNamed('/privacy')),
                    _dot(),
                    _footerLink(I18n.t('legal_terms'),     (ctx) => Navigator.of(ctx).pushNamed('/terms')),
                    _dot(),
                    _footerLink(I18n.t('legal_mentions'),  (ctx) => Navigator.of(ctx).pushNamed('/legal-notice')),
                    _dot(),
                    _footerLink(I18n.t('dp_title'),        (ctx) => Navigator.of(ctx).pushNamed('/delete-policy')),
                  ],
                ),

                const SizedBox(height: 10),
                Text('© ${DateTime.now().year} Wordix — ${I18n.t('footer_rights')}',
                    style: const TextStyle(color: Colors.black54), textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helpers footer
  static Widget _footerLink(String label, void Function(BuildContext) onTap) {
    return Builder(
      builder: (ctx) => TextButton(
        onPressed: () => onTap(ctx),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
  static Widget _dot() => const Text('•', style: TextStyle(color: Colors.black38));
}

/* ------------------ Composants ------------------ */
class Section extends StatelessWidget {
  final Widget child;
  final Color? color;
  const Section({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: child,
        ),
      ),
    );
  }
}

/* ------------------ HERO ------------------ */
class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1100;
    final bool isTablet  = width >= 700 && width < 1100;
    final bool isPhone   = width < 700;

    final double titleSize    = isDesktop ? 64 : (isTablet ? 46 : 34);
    final double subtitleSize = isDesktop ? 18 : (isTablet ? 16 : 15);
    final double ctaSpacing   = isPhone ? 10 : 12;
    final Axis dir = isDesktop ? Axis.horizontal : Axis.vertical;

    return Flex(
      direction: dir,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 720 : 560),
                child: Text(
                  I18n.t('hero_title'),
                  textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                    fontSize: titleSize,
                    height: 1.05,
                    letterSpacing: .2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 640 : 560),
                child: Text(
                  I18n.t('hero_subtitle'),
                  textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: subtitleSize, height: 1.45),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
                spacing: ctaSpacing,
                runSpacing: ctaSpacing,
                children: [
                  _primaryCta(context),
                  _secondaryCta(context),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  _badge(Icons.security_rounded, I18n.t('badge_secure',  params: {'x': 'TLS'})),
                  _badge(Icons.update_rounded,   I18n.t('badge_updates', params: {'x': 'Weekly'})),
                  _badge(Icons.star_rounded,     I18n.t('badge_rating',  params: {'x': '4.9/5'})),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: isDesktop ? 28 : 0, height: isDesktop ? 0 : 28),
        const Expanded(flex: 5, child: _HeroImage()),
      ],
    );
  }

  static Widget _primaryCta(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF111827),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      icon: const Icon(Icons.play_arrow_rounded),
      label: Text(I18n.t('cta_play')),
    );
  }

  static Widget _secondaryCta(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withOpacity(.8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      icon: const Icon(Icons.download_rounded),
      label: Text(I18n.t('cta_download')),
    );
  }

  static Widget _badge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white)),
      ]),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isPhone = width < 700;
    final double maxCardWidth = isPhone ? width * 0.92 : 820;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxCardWidth),
        child: _SmartImage(
          'assets/images/hero_wordix.png',
          borderRadius: 20,
          background: Colors.white.withOpacity(.08),
          showOverlay: true,
        ),
      ),
    );
  }
}

/* ------------------ Features ------------------ */
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String titleKey;
  final String subtitleKey;
  const _FeatureCard({required this.icon, required this.titleKey, required this.subtitleKey});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(.05)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40, width: 40,
            decoration: BoxDecoration(color: cs.primary.withOpacity(.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: cs.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t(titleKey), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: 4),
                Text(I18n.t(subtitleKey), style: const TextStyle(color: Colors.black54, height: 1.25)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------ Screenshots ------------------ */
class _ScreenshotsTitle extends StatelessWidget {
  const _ScreenshotsTitle();
  @override
  Widget build(BuildContext context) =>
      Text(I18n.t('screenshots_title'), style: Theme.of(context).textTheme.displayMedium);
}

class _ResponsiveScreenshots extends StatelessWidget {
  final List<String> images;
  const _ResponsiveScreenshots({required this.images});
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: _ScreenshotCarousel(images: images),
    ),
  );
}

class _ScreenshotCarousel extends StatefulWidget {
  final List<String> images;
  const _ScreenshotCarousel({required this.images});
  @override
  State<_ScreenshotCarousel> createState() => _ScreenshotCarouselState();
}

class _ScreenshotCarouselState extends State<_ScreenshotCarousel> {
  PageController? _controller;
  int _pageIndex = 0;
  final Map<String, double> _ratios = {};

  @override
  void initState() {
    super.initState();
    for (final p in widget.images) {
      _measureRatio(p).then((r) => mounted ? setState(() => _ratios[p] = r) : null);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width;
    final viewport = (width >= 900) ? 1.0 : .95;
    _controller ??= PageController(viewportFraction: viewport);
  }

  Future<double> _measureRatio(String path) async {
    final c = Completer<double>();
    final provider = AssetImage(path);
    final stream = provider.resolve(const ImageConfiguration());
    late final ImageStreamListener l;
    l = ImageStreamListener((info, _) {
      c.complete(info.image.width / info.image.height);
      stream.removeListener(l);
    }, onError: (e, s) {
      c.complete(9 / 16);
      stream.removeListener(l);
    });
    stream.addListener(l);
    return c.future;
  }

  double _ratioOf(String path) => _ratios[path] ?? (9 / 16);

  void _to(int i) {
    final pages = _pageCount(context);
    if (i < 0 || i >= pages) return;
    _controller?.animateToPage(i, duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
  }

  int _itemsPerPage(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    if (w >= 1200) return 3;
    if (w >= 900)  return 2;
    return 1;
  }

  int _pageCount(BuildContext ctx) {
    final ipp = _itemsPerPage(ctx);
    return ((widget.images.length + ipp - 1) / ipp).floor();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;
    final ipp = _itemsPerPage(context);
    final pages = _pageCount(context);

    return LayoutBuilder(builder: (_, constraints) {
      final pageWidth = constraints.maxWidth * (isWide ? 1.0 : .95);

      double calcHeightForPage(int page) {
        final start = page * ipp;
        final paths = List.generate(ipp, (k) => start + k)
            .where((i) => i < widget.images.length)
            .map((i) => widget.images[i])
            .toList();
        if (paths.isEmpty) return 300.0;

        if (ipp == 1) {
          final r = _ratioOf(paths.first);
          return (pageWidth / r).clamp(220.0, 600.0);
        } else {
          const gap = 12.0;
          final cardW = (pageWidth - gap * (paths.length - 1)) / paths.length;
          final heights = paths.map((p) => cardW / _ratioOf(p)).toList();
          final h = heights.reduce(math.max);
          final minH = (ipp == 3) ? 220.0 : 260.0;
          final maxH = (ipp == 3) ? 460.0 : 520.0;
          return h.clamp(minH, maxH);
        }
      }

      final targetHeight = calcHeightForPage(_pageIndex);

      return Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: double.infinity,
                height: targetHeight,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages,
                  onPageChanged: (i) => setState(() => _pageIndex = i),
                  itemBuilder: (_, page) {
                    final start = page * ipp;

                    if (ipp == 1) {
                      final path = widget.images[start];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _SmartImage(path, borderRadius: 16, background: Colors.white),
                        ),
                      );
                    } else {
                      final paths = List.generate(ipp, (k) => start + k)
                          .where((i) => i < widget.images.length)
                          .map((i) => widget.images[i])
                          .toList();

                      const gap = 12.0;
                      final children = <Widget>[];
                      for (int i = 0; i < paths.length; i++) {
                        if (i > 0) children.add(const SizedBox(width: gap));
                        children.add(Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _SmartImage(paths[i], borderRadius: 16, background: Colors.white),
                          ),
                        ));
                      }
                      return Row(children: children);
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: List.generate(pages, (i) {
                  final active = i == _pageIndex;
                  return GestureDetector(
                    onTap: () => _to(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 8,
                      width: active ? 28 : 10,
                      decoration: BoxDecoration(
                        color: active ? const Color(0xFF0EA5E9) : Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
          if (isWide) ...[
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 36),
                color: Colors.black54,
                onPressed: () => _to(_pageIndex - 1),
                splashRadius: 24,
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.chevron_right_rounded, size: 36),
                color: Colors.black54,
                onPressed: () => _to(_pageIndex + 1),
                splashRadius: 24,
              ),
            ),
          ],
        ],
      );
    });
  }
}

/* ------------------ CTA ------------------ */
class _CtaBanner extends StatelessWidget {
  const _CtaBanner();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final wide = c.maxWidth > 720;
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: wide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Text(I18n.t('cta_banner_title'),
                    textAlign: wide ? TextAlign.start : TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 8),
                Text(I18n.t('cta_banner_subtitle'),
                    textAlign: wide ? TextAlign.start : TextAlign.center,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(width: 12, height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF111827),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(I18n.t('cta_play')),
          ),
        ],
      );
    });
  }
}

/* ------------------ SmartImage ------------------ */
enum ImageFitMode { contain, cover, fill }
class _SmartImage extends StatefulWidget {
  final String path;
  final double borderRadius;
  final Color? background;
  final bool showOverlay;
  final ImageFitMode fitMode;
  const _SmartImage(this.path, {this.borderRadius = 16, this.background, this.showOverlay = false, this.fitMode = ImageFitMode.contain});

  @override
  State<_SmartImage> createState() => _SmartImageState();
}

class _SmartImageState extends State<_SmartImage> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  double? _ratio;

  @override
  void initState() { super.initState(); _resolve(); }
  @override
  void didUpdateWidget(covariant _SmartImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) { _disposeStream(); _ratio = null; _resolve(); }
  }

  void _resolve() {
    final provider = AssetImage(widget.path);
    _stream = provider.resolve(const ImageConfiguration());
    _listener = ImageStreamListener((info, _) {
      if (mounted) setState(() => _ratio = info.image.width / info.image.height);
    }, onError: (_, __) {
      if (mounted) setState(() => _ratio = 9 / 16);
    });
    _stream!.addListener(_listener!);
  }

  void _disposeStream() {
    if (_stream != null && _listener != null) { _stream!.removeListener(_listener!); }
    _stream = null; _listener = null;
  }

  @override
  void dispose() { _disposeStream(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_ratio == null) {
      return Container(
        height: 220,
        decoration: BoxDecoration(
          color: (widget.background ?? Colors.black.withOpacity(.04)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: const Center(child: SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 2))),
      );
    }

    Widget imageChild = Image.asset(widget.path);
    if      (widget.fitMode == ImageFitMode.contain) imageChild = FittedBox(fit: BoxFit.contain, alignment: Alignment.center, child: imageChild);
    else if (widget.fitMode == ImageFitMode.cover)   imageChild = FittedBox(fit: BoxFit.cover,   alignment: Alignment.center, child: imageChild);
    else                                             imageChild = FittedBox(fit: BoxFit.fill,    alignment: Alignment.center, child: imageChild);

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(color: widget.background ?? Colors.transparent),
          AspectRatio(aspectRatio: _ratio!, child: imageChild),
          if (widget.showOverlay)
            IgnorePointer(child: Container(decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(.08)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ))),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------
 *  Thème
 * -----------------------------------------------------*/
ThemeData buildSiteTheme() {
  final seed = const Color(0xFF0EA5E9);
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seed),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    textTheme: const TextTheme(
      displayLarge:  TextStyle(fontSize: 48, fontWeight: FontWeight.w800),
      displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
      titleLarge:    TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      bodyLarge:     TextStyle(fontSize: 16),
      bodyMedium:    TextStyle(fontSize: 14),
    ),
  );
}

/* -------------------------------------------------------
 *  Utils
 * -----------------------------------------------------*/
Future<void> _launch(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
