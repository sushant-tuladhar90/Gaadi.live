import 'package:flutter/material.dart';

import '../../../app/responsive.dart';
import '../data/routes_content.dart';
import '../model/route_search_model.dart';

class RouteProfileCard extends StatelessWidget {
  const RouteProfileCard({
    required this.route,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final RouteProfile route;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = isSelected
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final textColor = isSelected
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurface;
    final iconColor = isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Responsive.radius(15)),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          Responsive.width(3.2),
          Responsive.height(1.8),
          Responsive.width(3.2),
          Responsive.height(2),
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(Responsive.radius(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (route.badgeLabel != null)
                  _Tag(
                    label: route.badgeLabel!,
                    color: route.badgeColor ?? route.accentColor,
                  ),
                const SizedBox(width: 8),
                const Spacer(),
                Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: iconColor,
                  size: 26,
                ),
              ],
            ),
            SizedBox(height: Responsive.height(1.2)),
            Text(
              route.title,
              style: TextStyle(
                color: textColor,
                fontSize: Responsive.font(21),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: Responsive.height(1.5)),
          ],
        ),
      ),
    );
  }
}

// class _Metric extends StatelessWidget {
//   const _Metric({
//     required this.label,
//     required this.value,
//     required this.accent,
//   });

//   final String label;
//   final String value;
//   final Color accent;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               color: const Color(0xFFB7C2CE),
//               fontSize: Responsive.font(11),
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 3),
//           Text(
//             value,
//             style: TextStyle(
//               color: value == '92%' || value == 'REC' || value == '1.2 gal'
//                   ? accent
//                   : const Color(0xFFE5EAF2),
//               fontSize: Responsive.font(21),
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class RouteSearchSuggestionList extends StatelessWidget {
  const RouteSearchSuggestionList({
    required this.items,
    required this.onSelected,
    super.key,
  });

  final List<RouteSearchItem> items;
  final ValueChanged<RouteSearchItem> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.height(1.5)),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(2.5),
        vertical: Responsive.height(1),
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Responsive.radius(16)),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.width(2),
              vertical: Responsive.height(0.8),
            ),
            child: Text(
              'Search results',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: Responsive.font(12),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...items.map(
            (item) => InkWell(
              onTap: () => onSelected(item),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(2),
                  vertical: Responsive.height(1.3),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.route_rounded,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.width(2.5)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: Responsive.font(16),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (item.cities.isNotEmpty)
                            Text(
                              item.cities.join(' • '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: Responsive.font(12),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF07151D),
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}

// class _TrafficTag extends StatelessWidget {
//   const _TrafficTag({required this.label, required this.color});

//   final String label;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2C3039),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 7,
//             height: 7,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//           const SizedBox(width: 5),
//           Text(
//             label,
//             style: TextStyle(
//               color: color,
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RoutesBottomBar extends StatelessWidget {
//   const RoutesBottomBar({required this.onScan, super.key});

//   final VoidCallback onScan;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: Responsive.height(1.5),
//         bottom: Responsive.height(1),
//       ),
//       color: const Color(0xFF0C111A),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           const _NavItem(
//             icon: Icons.alt_route,
//             label: 'ROUTES',
//             selected: true,
//           ),
//           const _NavItem(icon: Icons.navigation_outlined, label: 'NAV HUD'),
//           _NavItem(icon: Icons.qr_code_scanner, label: 'SCAN', onTap: onScan),
//         ],
//       ),
//     );
//   }
// }

