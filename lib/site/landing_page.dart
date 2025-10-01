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
            child: Section(
              child: _HeroHeader(),
            ),
          ),

          // ----- FEATURES (refonte visuelle) -----
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
                const _ScreenshotCarousel(
                  // 👉 remplace par tes propres images (voir notes assets)
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
                child: _CtaBanner(),
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
                    _dot(),
                    _footerLink(I18n.t('legal_about'), (context) {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
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
// Widgets premium
// ======================================================

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final wide = MediaQuery.of(context).size.width > 980;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Texte + CTA
        Expanded(
          child: Column(
            crossAxisAlignment: wide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Text(
                I18n.t('hero_title'),
                textAlign: wide ? TextAlign.start : TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.white,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                I18n.t('hero_subtitle'),
                textAlign: wide ? TextAlign.start : TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.45),
              ),
              const SizedBox(height: 22),
              Wrap(
                alignment: wide ? WrapAlignment.start : WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
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
                  ),
                  OutlinedButton.icon(
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
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Badges confiance (placeholders)
              Wrap(
                spacing: 16,
                runSpacing: 10,
                children: [
                  _badge(Icons.security_rounded, I18n.t('badge_secure', params: {'x': 'TLS'})),
                  _badge(Icons.update_rounded, I18n.t('badge_updates', params: {'x': 'Weekly'})),
                  _badge(Icons.star_rounded, I18n.t('badge_rating', params: {'x': '4.9/5'})),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 28, height: 28),

        // Image Hero (mockup)
        Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 👉 remplace par ton image hero
                    Image.asset(
                      'assets/images/hero_wordix.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Text('📸 Hero image', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    // Légère overlay
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
          ),
        ),
      ],
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(.05)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cs.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t(titleKey), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 6),
                Text(I18n.t(subtitleKey), style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
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

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: .9);
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
        AspectRatio(
          aspectRatio: 16 / 9,
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
                  child: Image.asset(
                    widget.images[i],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Text('🖼️ Screenshot', style: TextStyle(color: Colors.black54)),
                    ),
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
  }
}

class _CtaBanner extends StatelessWidget {
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
