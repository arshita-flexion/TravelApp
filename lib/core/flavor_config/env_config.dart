class EnvConfig {
  final String baseUrl;
  final String deviceId;
  final int deviceOs;
  final String localIdentifier;
  final String googleServerClientId;

  EnvConfig({
    required this.baseUrl,
    required this.deviceId,
    required this.deviceOs,
    required this.localIdentifier,
    required this.googleServerClientId,
  });
}
