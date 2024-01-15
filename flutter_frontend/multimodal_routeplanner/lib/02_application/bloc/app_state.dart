part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class LocaleChanged extends AppState {
  final Locale locale;

  LocaleChanged(this.locale);
}
