import 'package:flutter/material.dart';

import '../../../app/responsive.dart';
import '../data/routes_content.dart';

class RouteProfileCard extends StatelessWidget {
  const RouteProfileCard({required this.route, super.key});

  final RouteProfile route;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(Responsive.width(3.2), Responsive.height(1.8), Responsive.width(3.2), Responsive.height(2)),
      decoration: BoxDecoration(
        color: route.isSelected ? const Color(0xFF193E47) : const Color(0xFF181D26),
        borderRadius: BorderRadius.circular(Responsive.radius(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (route.badgeLabel != null)
                _Tag(label: route.badgeLabel!, color: route.badgeColor ?? route.accentColor),
              const SizedBox(width: 8),
              _TrafficTag(label: route.trafficLabel, color: route.trafficColor),
              const Spacer(),
              const Icon(Icons.check_circle, color: Color(0xFF263743), size: 26),
            ],
          ),
          SizedBox(height: Responsive.height(1.2)),
          Text(
            route.title,
            style: TextStyle(color: const Color(0xFFE7ECF5), fontSize: Responsive.font(21), fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Responsive.height(1.5)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(2.5), vertical: Responsive.height(1.2)),
            decoration: BoxDecoration(color: const Color(0xFF090E16), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                _Metric(label: 'ETA', value: route.eta, accent: route.accentColor),
                _Metric(label: 'DIST', value: route.distance, accent: route.accentColor),
                _Metric(label: 'TOLLS', value: route.tolls, accent: route.accentColor),
                _Metric(label: route.lastLabel, value: route.lastValue, accent: route.accentColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.accent});

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: const Color(0xFFB7C2CE), fontSize: Responsive.font(11), fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(color: value == '92%' || value == 'REC' || value == '1.2 gal' ? accent : const Color(0xFFE5EAF2), fontSize: Responsive.font(21), fontWeight: FontWeight.w700)),
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
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      child: Text(label, style: const TextStyle(color: Color(0xFF07151D), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.7)),
    );
  }
}

class _TrafficTag extends StatelessWidget {
  const _TrafficTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: const Color(0xFF2C3039), borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class RoutesBottomBar extends StatelessWidget {
  const RoutesBottomBar({required this.onScan, super.key});

  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Responsive.height(1.5), bottom: Responsive.height(1)),
      color: const Color(0xFF0C111A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const _NavItem(icon: Icons.alt_route, label: 'ROUTES', selected: true),
          const _NavItem(icon: Icons.navigation_outlined, label: 'NAV HUD'),
          _NavItem(icon: Icons.qr_code_scanner, label: 'SCAN', onTap: onScan),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, this.selected = false, this.onTap});

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selected ? const Color(0xFF00E5F2) : const Color(0xFFB8C2CC), size: 27),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: selected ? const Color(0xFF00E5F2) : const Color(0xFFB8C2CC), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
        ],
      ),
    );
  }
}
