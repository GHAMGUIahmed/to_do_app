import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController(); // Crée un nouveau contrôleur
});
final descControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController(); // Crée un nouveau contrôleur
});
