import 'package:flutter/material.dart';
import '../../i18n.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('delpol.appbar'))),
      body: SafeArea(
        child: SelectionArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              Text(
                context.tr('delpol.heading'),
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                context.tr('delpol.updated'),
                style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
              ),
              const SizedBox(height: 16),
              _p(context.tr('delpol.intro')),

              _h(context.tr('delpol.s1_title')),
              _ul([
                context.tr('delpol.s1_1'),
                context.tr('delpol.s1_2'),
                context.tr('delpol.s1_3'),
                context.tr('delpol.s1_4'),
              ]),

              _h(context.tr('delpol.s2_title')),
              _ol([
                context.tr('delpol.s2_1'),
               // context.tr('delpol.s2_2'),
                context.tr('delpol.s2_3'),
              ]),

              _h(context.tr('delpol.s3_title')),
              _p(context.tr('delpol.s3_body')),

              _h(context.tr('delpol.s4_title')),
              _ul([
                context.tr('delpol.s4_1'),
                context.tr('delpol.s4_2'),
              ]),

              _h(context.tr('delpol.s5_title')),
              _p(context.tr('delpol.s5_body')),

              _h(context.tr('delpol.s6_title')),
              _p(context.tr('delpol.s6_body')),
            ],
          ),
        ),
      ),
    );
  }

  // --- helpers UI ---
  static Widget _h(String text) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
  );

  static Widget _p(String text) =>
      Padding(padding: const EdgeInsets.only(top: 2), child: Text(text, style: const TextStyle(height: 1.4)));

  static Widget _ul(List<String> items) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((e) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('•  '),
            Expanded(child: Text(e)),
          ],
        ),
      ))
          .toList(),
    ),
  );

  static Widget _ol(List<String> items) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${i + 1}.  '),
                Expanded(child: Text(items[i])),
              ],
            ),
          ),
      ],
    ),
  );
}
