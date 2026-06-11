import 'package:flutter/foundation.dart';

class UserService {
  // Singleton Pattern
  static final UserService _instance = UserService._internal();
  static UserService get instance => _instance;
  UserService._internal();

  // Observable properties
  final ValueNotifier<String> usernameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> emailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> bioNotifier = ValueNotifier<String>('');

  // Helpers to get/set easily
  String get username => usernameNotifier.value;
  set username(String value) => usernameNotifier.value = value;

  String get email => emailNotifier.value;
  set email(String value) => emailNotifier.value = value;

  String get bio => bioNotifier.value;
  set bio(String value) => bioNotifier.value = value;

  void clear() {
    usernameNotifier.value = '';
    emailNotifier.value = '';
    bioNotifier.value = '';
  }
}
