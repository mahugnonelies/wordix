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

          // ----- FEATURES (cartes moins hautes) -----
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
              children: [
                Text(I18n.t('screenshots_title'), style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 12),
                const _ScreenshotsResponsive(
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

                // Mentions légales dans le footer (au-dessus des droits)
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

/// Image d’asset qui **calcule le ratio réel** et **adapte le cadre** à l’image.
/// Résultat : aucune coupe, aucune barre noire, pas de distorsion.
class _AdaptiveAssetImage extends StatefulWidget {
  final String path;
  final double borderRadius;
  final EdgeInsets padding; // padding interne facultatif
  final bool showOverlay;   // overlay dégradé (pour le hero)

  const _AdaptiveAssetImage({
    required this.path,
    this.borderRadius = 20,
    this.padding = EdgeInsets.zero,
    this.showOverlay = false,
  });

  @override
  State<_AdaptiveAssetImage> createState() => _AdaptiveAssetImageState();
}

class _AdaptiveAssetImageState extends State<_AdaptiveAssetImage> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  double? _ratio;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(covariant _AdaptiveAssetImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) _resolveImage();
  }

  void _resolveImage() {
    _stream?.removeListener(_listener!);
    final provider = AssetImage(widget.path);
    final config = createLocalImageConfiguration(context);
    _stream = provider.resolve(config);
    _listener = ImageStreamListener((info, _) {
      final w = info.image.width.toDouble();
      final h = info.image.height.toDouble();
      if (mounted) setState(() => _ratio = (h == 0 ? 1.0 : w / h));
    });
    _stream!.addListener(_listener!);
  }

  @override
  void dispose() {
    if (_listener != null) {
      _stream?.removeListener(_listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fallback si pas encore chargé.
    final ratio = _ratio ?? (16 / 9);

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.04),
          border: Border.all(color: Colors.black12),
        ),
        child: AspectRatio(
          aspectRatio: ratio, // ← cadre = même ratio que l’image -> pas de crop/letterbox
          child: Stack(
            fit: StackFit.expand,
            children: [
              // L’image remplit exactement le cadre (ratio identique)
              Image.asset(widget.path, fit: BoxFit.cover),
              if (widget.showOverlay)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(.25)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Breakpoints
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
              // Badges confiance
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

        // Image Hero (cadre qui s’ajuste au ratio de l’image)
        Expanded(
          flex: 5,
          child: _AdaptiveAssetImage(
            path: 'assets/images/hero_wordix.png',
            showOverlay: true,
          ),
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
      onPressed: () {
        // TODO: lien vers l’app web (autre projet)
      },
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
      onPressed: () {
        // TODO: liens store
      },
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
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
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

/// Affiche un carrousel **uniquement** en téléphone portrait.
/// Sinon, affiche une **grille responsive**.
/// Chaque vignette s’adapte au ratio réel de l’image (pas de coupe, pas de bandes).
class _ScreenshotsResponsive extends StatelessWidget {
  final List<String> images;
  const _ScreenshotsResponsive({required this.images});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isPhonePortrait = size.width < 700 && orientation == Orientation.portrait;

    if (isPhonePortrait) {
      return _ScreenshotCarousel(images: images);
    } else {
      // Grille sur tablette/desktop
      final cols = size.width >= 1200 ? 3 : (size.width >= 900 ? 3 : 2);
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 6),
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 16 / 10, // ratio moyen; le cadre final sera ajusté par _AdaptiveAssetImage
        ),
        itemBuilder: (_, i) => _AdaptiveAssetImage(path: images[i]),
      );
    }
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

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: .92);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _to(int i) {
    _controller.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chaque page contient une _AdaptiveAssetImage qui calcule et applique le bon ratio
        PageView.builder(
          controller: _controller,
          itemCount: widget.images.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _AdaptiveAssetImage(path: widget.images[i]),
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
            onPressed: () {
              // TODO: action primaire (jouer/essayer)
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(I18n.t('cta_play')),
          ),
        ],
      );
    });
  }
}
