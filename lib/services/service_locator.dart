import 'package:get_it/get_it.dart';
import 'package:safety/services/calls_and_messages_service.dart';
import 'package:safety/utils/navigation_service.dart';

GetIt locator = GetIt.instance;

/// setting up locator
void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
  locator.registerLazySingleton(() => NavigationService());
}

/// global variable to get the current [NavigationService] object
NavigationService appNavigator = locator<NavigationService>();
