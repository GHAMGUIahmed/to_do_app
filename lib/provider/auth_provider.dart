import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/services/auth_services.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
