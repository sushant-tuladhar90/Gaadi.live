class ScannerContent {
  const ScannerContent({
    required this.title,
    required this.description,
    required this.status,
    required this.deviceName,
    required this.signalStrength,
  });

  final String title;
  final String description;
  final String status;
  final String deviceName;
  final String signalStrength;
}
