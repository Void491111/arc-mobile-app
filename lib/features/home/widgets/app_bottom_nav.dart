import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Bottom nav 3 item dengan:
/// - Underline merah yang SLIDE smooth pas pindah index
/// - Icon scale up + color fade pas active
class AppBottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNav({
    super.key,
    required this.activeIndex,
    this.onTap,
  });

  static const List<IconData> _icons = [
    Icons.gamepad_outlined,
    Icons.home_rounded,
    Icons.swap_vert_rounded,
  ];

  static const double _underlineWidth = 26;
  static const Duration _slideDuration = Duration(milliseconds: 320);
  static const Duration _iconDuration = Duration(milliseconds: 280);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 6,
      ),
      decoration: const BoxDecoration(color: AppColors.bottomNavBg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / _icons.length;
          final underlineLeft =
              itemWidth * activeIndex + (itemWidth - _underlineWidth) / 2;

          return SizedBox(
            height: 50,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Row of icons
                Row(
                  children: List.generate(_icons.length, (i) {
                    return Expanded(
                      child: _NavItem(
                        icon: _icons[i],
                        isActive: activeIndex == i,
                        onTap: () => onTap?.call(i),
                      ),
                    );
                  }),
                ),

                // Floating underline yang slide
                AnimatedPositioned(
                  duration: _slideDuration,
                  curve: Curves.easeOutCubic,
                  bottom: 0,
                  left: underlineLeft,
                  child: Container(
                    width: _underlineWidth,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.accentRed,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        // Icon scale animation
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: isActive ? 1.15 : 1.0),
          duration: AppBottomNav._iconDuration,
          curve: Curves.easeOutBack,
          builder: (context, scale, _) {
            return Transform.scale(
              scale: scale,
              // Color transition animation
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  begin: AppColors.bottomNavInactive,
                  end: isActive
                      ? AppColors.accentRed
                      : AppColors.bottomNavInactive,
                ),
                duration: AppBottomNav._iconDuration,
                builder: (context, color, _) {
                  return Icon(icon, size: 28, color: color);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}