import 'package:flutter/material.dart';

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

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const FeatureTile({super.key, required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundColor: cs.primary.withOpacity(.12), child: Icon(icon, color: cs.primary)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ]),
          ),
        ],
      ),
    );
  }
}
