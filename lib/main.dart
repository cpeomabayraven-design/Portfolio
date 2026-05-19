import 'package:flutter/material.dart';
import 'run_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class Spacing {
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

// ─── Theme notifier ──────────────────────────────────────────────────────────

class ThemeNotifier extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

// ─── App ─────────────────────────────────────────────────────────────────────

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeNotifier,
      builder: (context, _) {
        return MaterialApp(
          title: 'Raven Omabay — Portfolio',
          debugShowCheckedModeBanner: false,
          themeMode: _themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Georgia',
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Georgia',
            useMaterial3: true,
          ),
          home: PortfolioHome(themeNotifier: _themeNotifier),
        );
      },
    );
  }
}

// ─── Data ────────────────────────────────────────────────────────────────────

const List<String> stackTags = [
  'Flutter',
  'Dart',
  'PostgreSQL',
  'Go Language',
  'HTML',
  'C++',
  'Python',
  'Java',
  'Dockerfile',
  'SQL',
];
const List<Map<String, String>> aboutItems = [
  {'label': 'Location', 'value': 'Laguna, PH', 'sub': 'Open to remote'},
  {'label': 'Experience', 'value': '4 months', 'sub': 'Web development'},
  {'label': 'Education', 'value': 'B.S. Computer Eng.', 'sub': 'PLSP'},
  {
    'label': 'Interests',
    'value': 'Open source, DX',
    'sub': '& clean architecture',
  },
];

// ─── Tokens ───────────────────────────────────────────────────────────────────

class AppColors {
  final Color ink;
  final Color muted;
  final Color faint;
  final Color surface;
  final Color surfaceHover;
  final Color bg;
  final Color border;
  final Color borderHover;
  final Color green;
  final Color greenBg;
  final Color primaryBtnBg;
  final Color primaryBtnFg;

  const AppColors({
    required this.ink,
    required this.muted,
    required this.faint,
    required this.surface,
    required this.surfaceHover,
    required this.bg,
    required this.border,
    required this.borderHover,
    required this.green,
    required this.greenBg,
    required this.primaryBtnBg,
    required this.primaryBtnFg,
  });

  static const light = AppColors(
    ink: Color(0xFF1A1A1A),
    muted: Color(0xFF6B6B6B),
    faint: Color(0xFFAAAAAA),
    surface: Color(0xFFF5F5F3),
    surfaceHover: Color(0xFFEDEDEB),
    bg: Color(0xFFFFFFFF),
    border: Color(0xFFE2E2DF),
    borderHover: Color(0xFFCCCCC8),
    green: Color(0xFF15803D),
    greenBg: Color(0xFFDCFCE7),
    primaryBtnBg: Color(0xFF1A1A1A),
    primaryBtnFg: Color(0xFFFFFFFF),
  );

  static const dark = AppColors(
    ink: Color(0xFFF0F0EE),
    muted: Color(0xFF9A9A9A),
    faint: Color(0xFF666666),
    surface: Color(0xFF242422),
    surfaceHover: Color(0xFF2E2E2C),
    bg: Color(0xFF161614),
    border: Color(0xFF2E2E2C),
    borderHover: Color(0xFF444442),
    green: Color(0xFF4ADE80),
    greenBg: Color(0xFF14532D),
    primaryBtnBg: Color(0xFFF0F0EE),
    primaryBtnFg: Color(0xFF1A1A1A),
  );
}

AppColors _c(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? AppColors.dark : AppColors.light;
}

// ─── Main Page ────────────────────────────────────────────────────────────────

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key, required this.themeNotifier});
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    final c = _c(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: c.bg,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // ─── MAIN CONTENT ───────────────────────────────
            SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroSection(themeNotifier: themeNotifier),
                        const SizedBox(height: Spacing.sm),
                        _SectionDivider(c: c),

                        _StackSection(c: c),
                        const SizedBox(height: Spacing.sm),
                        _SectionDivider(c: c),

                        _AboutSection(c: c),
                        const SizedBox(height: Spacing.sm),
                        _SectionDivider(c: c),

                        _ContactSection(c: c),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ─── CAT BUTTON (TOP-LEFT FLOATING) ─────────────
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PixelScene()),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: c.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: c.border),
                      ),
                      child: Image.asset(
                        'assets/cat.gif',
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ─── Hero ─────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.themeNotifier});
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    final c = _c(context);
    return Padding(
      padding: const EdgeInsets.only(top: 56, bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow + dark mode toggle
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 24,
                height: 0.5,
                color: c.muted,
              ),
              const SizedBox(height: Spacing.sm),
              Text(
                'WEB DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 11,
                  letterSpacing: 1.6,
                  color: c.muted,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              _ThemeToggle(notifier: themeNotifier, c: c),
            ],
          ),
          const SizedBox(height: Spacing.sm),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 52,
                height: 1.1,
                letterSpacing: -1,
                color: c.ink,
              ),
              children: [
                const TextSpan(text: 'Raven\n'),
                TextSpan(
                  text: 'Omabay',
                  style: TextStyle(fontStyle: FontStyle.italic, color: c.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            'I build thoughtful web products — from pixelated interfaces to resilient backend systems. Currently open to new opportunities.',
            style: TextStyle(fontSize: 15, color: c.muted, height: 1.65),
          ),
          const SizedBox(height: Spacing.sm),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _PrimaryButton(
                label: 'View resume',
                icon: Icons.description_outlined,
                c: c,
                onTap: () async {
                  final Uri url = Uri.parse(
                    'https://drive.google.com/drive/u/0/folders/1z08nqhW_CuHe4T2DGJCZuMK6HweAKqqk',
                  );

                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    debugPrint('Could not open resume: $e');
                  }
                },
              ),
              _GhostButton(
                label: 'Say hello',
                icon: Icons.mail_outline_rounded,
                c: c,
                onTap: () async {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'cpe.omabay.raven@gmail.com',
                    query: 'subject=Hello Raven',
                  );

                  try {
                    await launchUrl(emailUri);
                  } catch (e) {
                    debugPrint('Could not launch email app: $e');
                  }
                },
              ),
              _AvailBadge(c: c),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Theme toggle ─────────────────────────────────────────────────────────────

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.notifier, required this.c});
  final ThemeNotifier notifier;
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    final isDark = notifier.isDark;
    return GestureDetector(
      onTap: notifier.toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 52,
        height: 28,
        decoration: BoxDecoration(
          color: c.surface,
          border: Border.all(color: c.border),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: isDark ? 26 : 2,
              top: 2,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(color: c.ink, shape: BoxShape.circle),
                child: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  size: 13,
                  color: c.bg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Buttons ──────────────────────────────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.c,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final AppColors c;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: c.primaryBtnBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: c.primaryBtnFg),
            const SizedBox(height: Spacing.sm),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: c.primaryBtnFg,
                fontFamily: 'Georgia',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({
    required this.label,
    required this.icon,
    required this.c,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final AppColors c;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: c.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: c.muted),
            const SizedBox(height: Spacing.sm),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: c.muted,
                fontFamily: 'Georgia',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailBadge extends StatelessWidget {
  const _AvailBadge({required this.c});
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: c.greenBg,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: c.green, shape: BoxShape.circle),
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            'Available for work',
            style: TextStyle(
              fontSize: 12,
              color: c.green,
              fontFamily: 'Courier',
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stack ────────────────────────────────────────────────────────────────────

class _StackSection extends StatelessWidget {
  const _StackSection({required this.c});
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('Stack', c: c),
          const SizedBox(height: Spacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: stackTags
                .map((tag) => _StackTag(label: tag, c: c))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _StackTag extends StatelessWidget {
  const _StackTag({required this.label, required this.c});
  final String label;
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.all(color: c.border),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Courier',
          fontSize: 12,
          color: c.muted,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, required this.c});
  final Map<String, dynamic> project;
  final AppColors c;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool featured = widget.project['featured'] as bool;
    final c = widget.c;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _hovered ? c.surfaceHover : c.bg,
            border: Border.all(color: _hovered ? c.borderHover : c.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: featured
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ProjectCardContent(project: widget.project, c: c),
                    ),
                    const SizedBox(height: Spacing.sm),
                    Icon(Icons.north_east_rounded, size: 16, color: c.faint),
                  ],
                )
              : _ProjectCardContent(project: widget.project, c: c),
        ),
      ),
    );
  }
}

class _ProjectCardContent extends StatelessWidget {
  const _ProjectCardContent({required this.project, required this.c});
  final Map<String, dynamic> project;
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: c.surface,
            border: Border.all(color: c.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(project['icon'] as IconData, size: 18, color: c.muted),
        ),
        const SizedBox(height: Spacing.sm),
        Text(
          project['title'] as String,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: c.ink,
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: Spacing.sm),
        Text(
          project['desc'] as String,
          style: TextStyle(fontSize: 13, color: c.muted, height: 1.55),
        ),
        const SizedBox(height: Spacing.sm),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: (project['tags'] as List<String>)
              .map(
                (t) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: c.surface,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    t,
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 11,
                      color: c.faint,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// ─── About ────────────────────────────────────────────────────────────────────

class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.c});
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('About', c: c),
          const SizedBox(height: Spacing.sm),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3,
            children: aboutItems
                .map((item) => _AboutCard(item: item, c: c))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({required this.item, required this.c});
  final Map<String, String> item;
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item['label']!,
            style: TextStyle(fontSize: 11, color: c.faint, letterSpacing: 0.3),
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            item['value']!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: c.ink,
            ),
          ),
          Text(item['sub']!, style: TextStyle(fontSize: 11, color: c.muted)),
        ],
      ),
    );
  }
}

// ─── Contact ─────────────────────────────────────────────────────────────────

class _ContactSection extends StatelessWidget {
  const _ContactSection({required this.c});
  final AppColors c;

  static const List<Map<String, dynamic>> links = [
    {
      'label': 'Email',
      'icon': Icons.mail_outline_rounded,
      'url': 'mailto:cpe.omabay.raven@gmail.com',
    },
    {
      'label': 'GitHub',
      'icon': Icons.code_rounded,
      'url': 'https://github.com/cpeomabayraven-design',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: links
            .map(
              (l) => GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(l['url'] as String);

                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    debugPrint('Could not launch URL: $e');
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: c.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(l['icon'] as IconData, size: 15, color: c.muted),
                      const SizedBox(height: Spacing.sm),
                      Text(
                        l['label'] as String,
                        style: TextStyle(fontSize: 13, color: c.muted),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ─── Shared ───────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {required this.c});
  final String text;
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Courier',
        fontSize: 11,
        letterSpacing: 1.4,
        color: c.faint,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.c});
  final AppColors c;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 0.5,
      color: c.border,
    );
  }
}
