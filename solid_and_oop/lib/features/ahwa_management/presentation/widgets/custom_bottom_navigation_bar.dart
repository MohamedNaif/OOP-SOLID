import 'package:flutter/material.dart';
import 'package:solid_and_oop/config/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color barBackground = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.white;
    final Color shadowColor = Colors.black.withValues(
      alpha: isDark ? 0.20 : 0.08,
    );

    final items = const [
      _NavItem(icon: Icons.list_alt, label: 'الرئيسية'),
      _NavItem(icon: Icons.assessment, label: 'التقارير'),
    ];

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: barBackground,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 20,
              offset: const Offset(0, -4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = constraints.maxWidth / items.length;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(items.length, (int index) {
                    final _NavItem item = items[index];
                    final bool isSelected = index == selectedIndex;
                    return _NavItemWidget(
                      width: itemWidth,
                      index: index,
                      item: item,
                      isSelected: isSelected,
                      onTap: onItemTapped,
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

class _NavItemWidget extends StatelessWidget {
  final double width;
  final int index;
  final _NavItem item;
  final bool isSelected;
  final ValueChanged<int> onTap;

  const _NavItemWidget({
    required this.width,
    required this.index,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  static const Duration _animationDuration = Duration(milliseconds: 220);
  static const Curve _animationCurve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected
        ? AppColors.primary
        : const Color(0xFF9CA3AF);

    return RepaintBoundary(
      child: SizedBox(
        width: width,
        child: InkResponse(
          onTap: () => onTap(index),
          radius: 36,
          highlightShape: BoxShape.rectangle,
          containedInkWell: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.12 : 1.0,
                  duration: _animationDuration,
                  curve: _animationCurve,
                  child: Icon(item.icon, color: color, size: 24),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: color,
                  ),
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: isSelected ? 1.0 : 0.85,
                    child: Text(
                      item.label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
