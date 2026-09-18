import 'package:flutter/material.dart';

import '../../../app/responsive.dart';
import '../data/routes_content.dart';
import 'routes_components.dart';

class RoutesView extends StatefulWidget {
  const RoutesView({required this.content, required this.onScan, super.key});

  final RoutesContent content;
  final VoidCallback onScan;

  @override
  State<RoutesView> createState() => _RoutesViewState();
}

class _RoutesViewState extends State<RoutesView> {
  int? selectedRouteIndex;

  @override
  void initState() {
    super.initState();
    selectedRouteIndex = widget.content.routes.indexWhere(
      (route) => route.isSelected,
    );
    if (selectedRouteIndex == -1) {
      selectedRouteIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  Responsive.width(4),
                  Responsive.height(2),
                  Responsive.width(4),
                  Responsive.height(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RoutesHeader(),
                    SizedBox(height: Responsive.height(2)),
                    // _VehicleStatus(vehicleId: content.vehicleId),
                    SizedBox(height: Responsive.height(1.5)),
                    _SearchBar(),
                    SizedBox(height: Responsive.height(2)),
                    // const _TargetBayCard(),
                    SizedBox(height: Responsive.height(2.5)),
                    Row(
                      children: [
                        Icon(
                          Icons.alt_route,
                          color: colorScheme.primary,
                          size: 25,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Recommended Route',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        // const Spacer(),
                        // Text(
                        //   '${content.routes.length} LIVE VARIANTS',
                        //   style: const TextStyle(
                        //     color: Color(0xFFB7C2CC),
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w800,
                        //     letterSpacing: 0.8,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: Responsive.height(1.5)),
                    for (
                      var index = 0;
                      index < widget.content.routes.length;
                      index++
                    ) ...[
                      RouteProfileCard(
                        route: widget.content.routes[index],
                        isSelected: selectedRouteIndex == index,
                        onTap: () {
                          setState(() {
                            selectedRouteIndex = index;
                          });
                        },
                      ),
                      SizedBox(height: Responsive.height(1.5)),
                    ],
                    // const _TrafficSpectrum(),
                    SizedBox(height: Responsive.height(2)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.navigation_outlined, size: 28, color: colorScheme.onPrimary),
                        label: Text(
                          'Start Driving',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          minimumSize: Size.fromHeight(Responsive.height(9)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // RoutesBottomBar(onScan: widget.onScan),
          ],
        ),
      ),
    );
  }
}

class _RoutesHeader extends StatelessWidget {
  const _RoutesHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 47,
          height: 47,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.local_shipping_outlined,
            color: colorScheme.primary,
            size: 28,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Routes',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            // Row(children: [Icon(Icons.circle, color: Color(0xFF61E9BA), size: 10), SizedBox(width: 6), Text('GPS LIVE', style: TextStyle(color: Color(0xFFB7C2CC), fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1))]),
          ],
        ),
        const Spacer(),
        // Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9), decoration: BoxDecoration(color: const Color(0xFF202936), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.sensors, color: Color(0xFF61E9BA), size: 17), SizedBox(width: 6), Text('98%', style: TextStyle(color: Color(0xFFE8EDF5), fontWeight: FontWeight.w700))])),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.surfaceContainerHighest,
          child: Icon(Icons.account_circle_outlined, color: colorScheme.primary),
        ),
      ],
    );
  }
}

// class _VehicleStatus extends StatelessWidget {
//   const _VehicleStatus({required this.vehicleId});

//   final String vehicleId;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
//       decoration: BoxDecoration(color: const Color(0xFF191F29), borderRadius: BorderRadius.circular(15)),
//       child: Row(children: [
//         const Icon(Icons.circle, color: Color(0xFF61E9BA), size: 14),
//         const SizedBox(width: 10),
//         // const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('OBD-II LINKED', style: TextStyle(color: Color(0xFFB7C2CC), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)), Text('Vehicle #', style: TextStyle(color: Color(0xFF00E5F2), fontSize: 16, fontWeight: FontWeight.w800))]),
//         Text(vehicleId, style: const TextStyle(color: Color(0xFF00E5F2), fontSize: 16, fontWeight: FontWeight.w800)),
//         const Spacer(),
//         const _SyncPill(),
//       ]),
//     );
//   }
// }

// class _SyncPill extends StatelessWidget {
//   const _SyncPill();

//   @override
//   Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: BoxDecoration(color: const Color(0xFF292F3A), borderRadius: BorderRadius.circular(18)), child: const Row(children: [Icon(Icons.sync, color: Color(0xFF61E9BA), size: 16), SizedBox(width: 5), Text('Auto-Sync', style: TextStyle(color: Color(0xFFE8EDF5), fontSize: 15))]));
// }

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: colorScheme.onSurfaceVariant, size: 27),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search Location',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 16,
              ),
            ),
          ),
          Icon(Icons.tune, color: colorScheme.primary, size: 25),
        ],
      ),
    );
  }
}

// class _TargetBayCard extends StatelessWidget {
//   const _TargetBayCard();

//   @override
//   Widget build(BuildContext context) {
//     final cardHeight = Responsive.height(21) < 220 ? 220.0 : Responsive.height(21);

//     return Container(
//       height: cardHeight,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFF151936),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//             decoration: BoxDecoration(
//               color: const Color(0xFF272D4A),
//               borderRadius: BorderRadius.circular(7),
//             ),
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.link, color: Color(0xFF00E5F2), size: 17),
//                 SizedBox(width: 6),
//                 Text('CORRIDOR HUD', style: TextStyle(color: Color(0xFFE8EDF5), fontSize: 12, fontWeight: FontWeight.w800)),
//               ],
//             ),
//           ),
//           const Spacer(),
//           const Center(child: Icon(Icons.image_outlined, color: Color(0xFF5F55C8), size: 54)),
//           const Spacer(),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             decoration: BoxDecoration(color: const Color(0xFF262C38), borderRadius: BorderRadius.circular(11)),
//             child: const Row(
//               children: [
//                 Icon(Icons.location_on_outlined, color: Color(0xFFFFB51B), size: 23),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('TARGET BAY', style: TextStyle(color: Color(0xFFB7C2CC), fontSize: 12, fontWeight: FontWeight.w800)),
//                       Text('Logistics Hub B, Bay 14', style: TextStyle(color: Color(0xFFE8EDF5), fontSize: 20, fontWeight: FontWeight.w700)),
//                     ],
//                   ),
//                 ),
//                 Text('G-4 GATE', style: TextStyle(color: Color(0xFF61E9BA), fontSize: 15, fontWeight: FontWeight.w800)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TrafficSpectrum extends StatelessWidget {
//   const _TrafficSpectrum();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: const Color(0xFF151B25),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Text(
//                 'TRAFFIC SPECTRUM MATRIX',
//                 style: TextStyle(
//                   color: Color(0xFFB7C2CC),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w800,
//                   letterSpacing: 1,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 'LIVE RADAR',
//                 style: TextStyle(
//                   color: Color(0xFF00E5F2),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           Row(
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: const Row(
//                     children: [
//                       Expanded(
//                         flex: 65,
//                         child: SizedBox(
//                           height: 10,
//                           child: ColoredBox(color: Color(0xFF61E9BA)),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 25,
//                         child: SizedBox(
//                           height: 10,
//                           child: ColoredBox(color: Color(0xFFFFB51B)),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 10,
//                         child: SizedBox(
//                           height: 10,
//                           child: ColoredBox(color: Color(0xFFFFB5B5)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 '65% Clear',
//                 style: TextStyle(
//                   color: Color(0xFFE8EDF5),
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('● Express', style: TextStyle(color: Color(0xFF61E9BA))),
//               Text('● Surface', style: TextStyle(color: Color(0xFFFFB51B))),
//               Text(
//                 '● Loading Bay Choke',
//                 style: TextStyle(color: Color(0xFFFFB5B5), fontSize: 12),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
