import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// A small, reusable surface for the translucent, layered desktop treatment.
/// It deliberately stays theme-aware so the same component works in light and
/// dark mode without hard-coded text or icon colors.
class PremiumSurface extends StatelessWidget {
  const PremiumSurface({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.color,
    this.blur = 18,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;
  final Color? color;
  final double blur;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fill = color ?? scheme.surface.withValues(alpha: 0.68);
    final border = scheme.outline.withValues(alpha: 0.14);

    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Material(
            color: fill,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  border: Border.all(color: border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 30,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
