import 'package:get_it/get_it.dart';
import 'package:tentwenty_live_coding/core/services/api_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(ApiService());
}
