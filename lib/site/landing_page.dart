import 'package:flutter/material.dart';
import '../i18n.dart';
import 'components.dart';

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
          // HERO
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primary, cs.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Section(
              child: LayoutBuilder(
                builder: (context, c) {
                  final wide = c.maxWidth > 900;
                  return Flex(
                    direction: wide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: wide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                          children: [
                            Text(I18n.t('hero_title'),
                                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white)),
                            const SizedBox(height: 12),
                            Text(I18n.t('hero_subtitle'),
                                style: const TextStyle(color: Colors.white70, fontSize: 16)),
                            const SizedBox(height: 24),
                            Wrap(spacing: 12, runSpacing: 12, children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF111827),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  // TODO: lien vers le repo/app web (autre projet)
                                  // launchUrl(Uri.parse('https://<ton-user>.github.io/<repo-app>/'));
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
                                  // TODO: liens store (Google Play / App Store)
                                },
                                icon: const Icon(Icons.download_rounded),
                                label: Text(I18n.t('cta_download')),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(width: 28, height: 28),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: const Center(
                              child: Text('📸 Screenshots / Mockups', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // FEATURES
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
                  children: [
                    FeatureTile(icon: Icons.translate_rounded, title: I18n.t('feature_i18n'), subtitle: I18n.t('feature_i18n_desc')),
                    FeatureTile(icon: Icons.sports_esports_rounded, title: I18n.t('feature_gameplay'), subtitle: I18n.t('feature_gameplay_desc')),
                    FeatureTile(icon: Icons.star_rate_rounded, title: I18n.t('feature_progress'), subtitle: I18n.t('feature_progress_desc')),
                  ],
                ),
              ],
            ),
          ),

          // LEGAL LINKS (liens externes vers site ou docs)
          Section(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t('legal_title'), style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _legalButton(Icons.policy_outlined, I18n.t('legal_privacy'), () {
                    // launchUrl(Uri.parse('https://.../privacy.html'));
                  }),
                  _legalButton(Icons.rule_folder_outlined, I18n.t('legal_terms'), () {}),
                  _legalButton(Icons.article_outlined, I18n.t('legal_mentions'), () {}),
                  _legalButton(Icons.info_outline, I18n.t('legal_about'), () {}),
                ]),
              ],
            ),
          ),

          // FOOTER
          Section(
            child: Column(
              children: [
                const Divider(),
                const SizedBox(height: 12),
                Text('© ${DateTime.now().year} Wordix — ${I18n.t('footer_rights')}',
                    style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legalButton(IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
