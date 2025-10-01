import 'dart:async';
import 'package:flutter/material.dart';
import '../i18n.dart';
import 'components.dart';

// Légales .dart
import '../site/legal/privacy_policy_screen.dart';
import '../site/legal/terms_screen.dart';
import '../site/legal/legal_notice_screen.dart';
import '../site/legal/delete_policy_screen.dart';

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
              child: Row(
                children: const [Icon(Icons.language), SizedBox(width: 6), Icon(Icons.arrow_drop_down)],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: ListView(
        children: [
          // ----- HERO PREMIUM -----
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

          // ----- FEATURES (hauteur réduite) -----
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
                    _FeatureCard(
                      icon: Icons.translate_rounded,
                      titleKey: 'feature_i18n',
                      subtitleKey: 'feature_i18n_desc',
                    ),
                    _FeatureCard(
                      icon: Icons.sports_esports_rounded,
                      titleKey: 'feature_gameplay',
                      subtitleKey: 'feature_gameplay_desc',
                    ),
                    _FeatureCard(
                      icon: Icons.star_rate_rounded,
                      titleKey: 'feature_progress',
                      subtitleKey: 'feature_progress_desc',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ----- SCREENSHOTS / MOCKUPS -----
          Section(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _ScreenshotsTitle(),
                SizedBox(height: 12),
                _ResponsiveScreenshots(
                  images: [
                    'assets/screenshots/s1.png',
                    'assets/screenshots/s2.png',
                    'assets/screenshots/s3.png',
                  ],
                ),
              ],
            ),
          ),

          // ----- BANNIÈRE CTA -----
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
                    _footerLink(I18n.t('legal_privacy'), (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
                    }),
                    _dot(),
                    _footerLink(I18n.t('legal_terms'), (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen()));
                    }),
                    _dot(),
                    _footerLink(I18n.t('legal_mentions'), (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalNoticeScreen()));
                    }),
                    _dot(),
                    _footerLink(I18n.t('dp_title'), (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const DeletePolicyScreen()));
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '© ${DateTime.now().year} Wordix — ${I18n.t('footer_rights')}',
                  style: const TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Footer helpers ---
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

// ======================================================
// Widgets premium & responsives
// ======================================================

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isDesktop = width >= 1100;
    final bool isTablet = width >= 700 && width < 1100;
    final bool isPhone = width < 700;

    final double titleSize = isDesktop ? 64 : (isTablet ? 46 : 34);
    final double subtitleSize = isDesktop ? 18 : (isTablet ? 16 : 15);
    final double ctaSpacing = isPhone ? 10 : 12;

    final Axis dir = isDesktop ? Axis.horizontal : Axis.vertical;

    return Flex(
      direction: dir,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Texte + CTA
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
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: subtitleSize,
                    height: 1.45,
                  ),
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
                  _badge(Icons.security_rounded, I18n.t('badge_secure', params: {'x': 'TLS'})),
                  _badge(Icons.update_rounded, I18n.t('badge_updates', params: {'x': 'Weekly'})),
                  _badge(Icons.star_rounded, I18n.t('badge_rating', params: {'x': '4.9/5'})),
                ],
              ),
            ],
          ),
        ),

        SizedBox(width: isDesktop ? 28 : 0, height: isDesktop ? 0 : 28),

        // Image Hero (aucun crop, ratio natif)
        const Expanded(
          flex: 5,
          child: _HeroImage(),
        ),
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
          // fitMode: ImageFitMode.cover, // ← décommente si tu veux remplir quitte à rogner
        ),
      ),
    );
  }
}

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

// ------------------------------------------------------------------
// Screenshots adaptatifs :
//  - Carrousel UNIQUEMENT sur petits téléphones en portrait
//  - Grille sur tablette/desktop/grands téléphones/landscape
// ------------------------------------------------------------------

class _ScreenshotsTitle extends StatelessWidget {
  const _ScreenshotsTitle();

  @override
  Widget build(BuildContext context) {
    return Text(I18n.t('screenshots_title'), style: Theme.of(context).textTheme.displayMedium);
  }
}

class _ResponsiveScreenshots extends StatelessWidget {
  final List<String> images;
  const _ResponsiveScreenshots({required this.images});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // ✅ Stricte: uniquement téléphone compact ET portrait
    final bool isSmallPortraitPhone =
        mq.orientation == Orientation.portrait && mq.size.shortestSide < 600;

    if (isSmallPortraitPhone) {
      return _ScreenshotCarousel(images: images);
    }

    // Grille (pas de carrousel côté ordinateur/tablette)
    final cross = mq.size.width >= 900 ? 3 : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cross,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: images.length,
      itemBuilder: (_, i) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.black.withOpacity(.04),
          padding: const EdgeInsets.all(6),
          child: _SmartImage(
            images[i],
            borderRadius: 12,
            background: Colors.white,
            // fitMode: ImageFitMode.cover, // optionnel
          ),
        ),
      ),
    );
  }
}

class _ScreenshotCarousel extends StatefulWidget {
  final List<String> images;
  const _ScreenshotCarousel({required this.images});

  @override
  State<_ScreenshotCarousel> createState() => _ScreenshotCarouselState();
}

class _ScreenshotCarouselState extends State<_ScreenshotCarousel> {
  late final PageController _controller;
  int _index = 0;
  final Map<String, double> _ratios = {}; // path -> ratio

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: .95);
    for (final p in widget.images) {
      _measureRatio(p).then((r) {
        if (mounted) setState(() => _ratios[p] = r);
      });
    }
  }

  Future<double> _measureRatio(String path) async {
    final completer = Completer<double>();
    final provider = AssetImage(path);
    final stream = provider.resolve(const ImageConfiguration());
    late final ImageStreamListener l;
    l = ImageStreamListener((info, _) {
      completer.complete(info.image.width / info.image.height);
      stream.removeListener(l);
    }, onError: (e, s) {
      completer.complete(9 / 16); // fallback
      stream.removeListener(l);
    });
    stream.addListener(l);
    return completer.future;
  }

  double _ratioFor(int i) => _ratios[widget.images[i]] ?? (9 / 16);

  void _to(int i) {
    _controller.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final pageWidth = constraints.maxWidth * .95; // viewportFraction
      final ratio = _ratioFor(_index);
      final targetHeight = pageWidth / ratio + 12; // +padding

      return Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: targetHeight,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Colors.black.withOpacity(.04),
                    padding: const EdgeInsets.all(6),
                    child: _SmartImage(
                      widget.images[i],
                      borderRadius: 12,
                      background: Colors.white,
                      // fitMode: ImageFitMode.cover, // optionnel
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: List.generate(widget.images.length, (i) {
              final isActive = i == _index;
              return GestureDetector(
                onTap: () => _to(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 8,
                  width: isActive ? 28 : 10,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF0EA5E9) : Colors.black26,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }),
          )
        ],
      );
    });
  }
}

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
                Text(
                  I18n.t('cta_banner_title'),
                  textAlign: wide ? TextAlign.start : TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  I18n.t('cta_banner_subtitle'),
                  textAlign: wide ? TextAlign.start : TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
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

/// =====================
///   SMART IMAGE
/// =====================
enum ImageFitMode { contain, cover, fill }

class _SmartImage extends StatefulWidget {
  final String path;
  final double borderRadius;
  final Color? background;
  final bool showOverlay;
  final ImageFitMode fitMode;

  const _SmartImage(
      this.path, {
        this.borderRadius = 16,
        this.background,
        this.showOverlay = false,
        this.fitMode = ImageFitMode.contain, // change en cover si tu veux remplir quitte à rogner
      });

  @override
  State<_SmartImage> createState() => _SmartImageState();
}

class _SmartImageState extends State<_SmartImage> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  double? _ratio; // width / height

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  @override
  void didUpdateWidget(covariant _SmartImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _disposeStream();
      _ratio = null;
      _resolve();
    }
  }

  void _resolve() {
    final provider = AssetImage(widget.path);
    _stream = provider.resolve(const ImageConfiguration());
    _listener = ImageStreamListener((info, _) {
      final w = info.image.width.toDouble();
      final h = info.image.height.toDouble();
      if (mounted) setState(() => _ratio = (h == 0) ? 1.0 : w / h);
    }, onError: (_, __) {
      if (mounted) setState(() => _ratio = 9 / 16);
    });
    _stream!.addListener(_listener!);
  }

  void _disposeStream() {
    if (_stream != null && _listener != null) {
      _stream!.removeListener(_listener!);
    }
    _stream = null;
    _listener = null;
  }

  @override
  void dispose() {
    _disposeStream();
    super.dispose();
  }

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

    // Choix du mode d'ajustement
    if (widget.fitMode == ImageFitMode.contain) {
      imageChild = FittedBox(fit: BoxFit.contain, alignment: Alignment.center, child: imageChild);
    } else if (widget.fitMode == ImageFitMode.cover) {
      imageChild = FittedBox(fit: BoxFit.cover, alignment: Alignment.center, child: imageChild);
    } else {
      imageChild = FittedBox(fit: BoxFit.fill, alignment: Alignment.center, child: imageChild);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(color: widget.background ?? Colors.transparent),
          AspectRatio(aspectRatio: _ratio!, child: imageChild),
          if (widget.showOverlay)
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(.08)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
