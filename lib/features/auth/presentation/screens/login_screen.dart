import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/household/presentation/providers/pending_invite_provider.dart';

import '../widgets/web_wrapper.dart' as web;

/// Login: a yerba-green hero with the app icon, what the app does, and the
/// Google button on paper below.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..forward();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authProvider.notifier).initializeGoogleSignIn();
    });
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  /// Fade and lift a piece in, starting at [start] (0..1 of the intro).
  Widget _enter(double start, Widget child) {
    final curve = CurvedAnimation(
      parent: _intro,
      curve: Interval(start, math.min(start + 0.45, 1), curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.12), end: Offset.zero).animate(curve),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthStateLoading;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    ref.listen<AuthState>(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          // A pending invite code (from the web invitation flow) goes first
          final pendingInviteCode = ref.read(pendingInviteCodeProvider);
          if (pendingInviteCode != null) {
            ref.read(pendingInviteCodeProvider.notifier).set(null);
            context.go('/join/$pendingInviteCode');
            return;
          }
          if (user.households?.isNotEmpty == true) {
            context.go(AppRoutes.home);
          } else {
            context.go(AppRoutes.householdSetup);
          }
        },
        unauthenticated: () {},
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: scheme.error),
          );
          ref.read(authProvider.notifier).clearError();
        },
      );
    });

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  _Hero(
                    icon: _enter(0, const _AppIcon()),
                    title: _enter(0.12, const _HeroTitle()),
                  ),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  for (final (i, f) in _features.indexed)
                                    _enter(0.3 + i * 0.1, _FeatureRow(feature: f)),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _enter(
                                0.55,
                                SafeArea(
                                  top: false,
                                  child: Column(
                                    children: [
                                      if (kIsWeb)
                                        web.renderButton()
                                      else
                                        _GoogleButton(
                                          loading: isLoading,
                                          onPressed: () => ref.read(authProvider.notifier).signInWithGoogle(),
                                        ),
                                      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) ...[
                                        const SizedBox(height: 12),
                                        _AppleButton(
                                          onPressed: isLoading
                                              ? null
                                              : () => ref.read(authProvider.notifier).signInWithApple(),
                                        ),
                                      ],
                                      const SizedBox(height: 14),
                                      Text(
                                        'Entrás con tu cuenta de Google. Si es la primera vez, '
                                        'después creás tu hogar o te sumás a uno.',
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: scheme.onSurfaceVariant,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------- hero

class _Hero extends StatelessWidget {
  final Widget icon;
  final Widget title;
  const _Hero({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ClipPath(
      clipper: _WaveClipper(),
      child: CustomPaint(
        painter: _HeroPainter(dark: dark),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 72),
            child: Center(
              child: Column(
                children: [icon, const SizedBox(height: 22), title],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.22), blurRadius: 24, offset: const Offset(0, 10)),
          BoxShadow(color: AppColors.accentOnDark.withValues(alpha: 0.25), blurRadius: 40, spreadRadius: -6),
        ],
      ),
      child: Image.asset('assets/images/app_icon_384.png', semanticLabel: 'Nuestra App'),
    );
  }
}

class _HeroTitle extends StatelessWidget {
  const _HeroTitle();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          AppStrings.appName,
          textAlign: TextAlign.center,
          style: text.displayMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(children: [
            const TextSpan(text: 'La casa en orden, '),
            TextSpan(
              text: 'entre todos.',
              style: text.titleLarge?.copyWith(
                color: AppColors.accentOnDark,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontFamily: text.displayMedium?.fontFamily,
              ),
            ),
          ]),
          textAlign: TextAlign.center,
          style: text.titleLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.86),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Deep yerba gradient, a honey glow behind the icon and soft leaves.
class _HeroPainter extends CustomPainter {
  final bool dark;
  _HeroPainter({required this.dark});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [Color(0xFF173A2A), Color(0xFF0E2219)]
              : const [Color(0xFF3A7D5D), AppColors.primaryDark],
        ).createShader(rect),
    );

    // Honey glow, centered behind the icon
    final glowCenter = Offset(size.width / 2, size.height * 0.32);
    canvas.drawCircle(
      glowCenter,
      size.width * 0.62,
      Paint()
        ..shader = RadialGradient(colors: [
          AppColors.accentOnDark.withValues(alpha: dark ? 0.18 : 0.26),
          AppColors.accentOnDark.withValues(alpha: 0),
        ]).createShader(Rect.fromCircle(center: glowCenter, radius: size.width * 0.62)),
    );

    // Leaves: yerba leaves drifting at the edges
    final leaf = Paint()..color = Colors.white.withValues(alpha: dark ? 0.045 : 0.07);
    void drawLeaf(Offset at, double length, double angle) {
      canvas.save();
      canvas.translate(at.dx, at.dy);
      canvas.rotate(angle);
      final w = length * 0.42;
      final path = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(length / 2, -w, length, 0)
        ..quadraticBezierTo(length / 2, w, 0, 0)
        ..close();
      canvas.drawPath(path, leaf);
      canvas.drawLine(
        Offset.zero,
        Offset(length, 0),
        Paint()
          ..color = Colors.white.withValues(alpha: dark ? 0.05 : 0.08)
          ..strokeWidth = 1.2,
      );
      canvas.restore();
    }

    drawLeaf(Offset(-20, size.height * 0.18), 150, 0.35);
    drawLeaf(Offset(size.width * 0.06, size.height * 0.62), 110, -0.55);
    drawLeaf(Offset(size.width + 18, size.height * 0.12), 170, math.pi - 0.5);
    drawLeaf(Offset(size.width * 0.96, size.height * 0.58), 120, math.pi + 0.45);
    drawLeaf(Offset(size.width * 0.93, size.height * 0.98), 90, -math.pi / 2 - 0.5);

    // A few honey drops
    final drop = Paint()..color = AppColors.accentOnDark.withValues(alpha: dark ? 0.35 : 0.5);
    canvas.drawCircle(Offset(size.width * 0.18, size.height * 0.3), 3.5, drop);
    canvas.drawCircle(Offset(size.width * 0.84, size.height * 0.4), 2.5, drop);
  }

  @override
  bool shouldRepaint(_HeroPainter old) => old.dark != dark;
}

/// Soft wave at the bottom of the hero.
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    return Path()
      ..lineTo(0, h - 36)
      ..cubicTo(w * 0.28, h + 4, w * 0.62, h - 62, w, h - 22)
      ..lineTo(w, 0)
      ..close();
  }

  @override
  bool shouldReclip(_WaveClipper old) => false;
}

// ---------------------------------------------------------------- features

class _Feature {
  final IconData icon;
  final String title;
  final String body;
  final bool honey;
  const _Feature(this.icon, this.title, this.body, {this.honey = false});
}

const _features = [
  _Feature(Icons.account_balance_wallet_outlined, 'Gastos compartidos',
      'Los fijos de cada mes se completan solos.'),
  _Feature(Icons.restaurant_menu, 'Menú de la semana',
      'Recetas, compras y lo que no les gusta.', honey: true),
  _Feature(Icons.auto_awesome_outlined, 'Un asistente en tu teléfono',
      'Te ayuda a anotar, planear y cocinar.'),
];

class _FeatureRow extends StatelessWidget {
  final _Feature feature;
  const _FeatureRow({required this.feature});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tileColor = feature.honey ? scheme.tertiaryContainer : scheme.primaryContainer;
    final iconColor = feature.honey ? scheme.onTertiaryContainer : scheme.onPrimaryContainer;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: tileColor, borderRadius: BorderRadius.circular(14)),
            child: Icon(feature.icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feature.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  feature.body,
                  style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------- buttons

class _GoogleButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;
  const _GoogleButton({required this.loading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: loading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: dark ? const Color(0xFF131314) : Colors.white,
          disabledBackgroundColor: dark ? const Color(0xFF131314) : Colors.white,
          foregroundColor: dark ? const Color(0xFFE3E3E3) : const Color(0xFF1F1F1F),
          side: BorderSide(color: dark ? const Color(0xFF8E918F) : scheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: loading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : Row(
                  key: const ValueKey('label'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 20, height: 20, child: CustomPaint(painter: _GoogleGPainter())),
                    const SizedBox(width: 12),
                    Text(
                      AppStrings.signInWithGoogle,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            color: dark ? const Color(0xFFE3E3E3) : const Color(0xFF1F1F1F),
                          ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

/// The four-color Google "G".
class _GoogleGPainter extends CustomPainter {
  const _GoogleGPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final stroke = s * 0.2;
    final center = Offset(size.width / 2, size.height / 2);
    final r = (s - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: r);
    double rad(double deg) => deg * math.pi / 180;
    Paint arc(Color c) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    canvas.drawArc(rect, rad(-140), rad(97), false, arc(const Color(0xFFEA4335))); // red
    canvas.drawArc(rect, rad(135), rad(86), false, arc(const Color(0xFFFBBC05))); // yellow
    canvas.drawArc(rect, rad(42), rad(94), false, arc(const Color(0xFF34A853))); // green
    canvas.drawArc(rect, rad(-2), rad(45), false, arc(const Color(0xFF4285F4))); // blue
    // Blue bar
    canvas.drawRect(
      Rect.fromLTRB(center.dx, center.dy - stroke / 2, center.dx + r + stroke / 2, center.dy + stroke / 2),
      Paint()..color = const Color(0xFF4285F4),
    );
  }

  @override
  bool shouldRepaint(_GoogleGPainter old) => false;
}

class _AppleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _AppleButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.apple, size: 22),
        label: const Text(AppStrings.signInWithApple),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
