import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/services/cloud_services.dart';

final cloudServiceProvider = StateProvider<CloudService>((ref) {
  return CloudService();
});
