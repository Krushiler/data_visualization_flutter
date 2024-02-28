part of 'theme_picker_bloc.dart';

@freezed
class ThemePickerEvent with _$ThemePickerEvent {
  const factory ThemePickerEvent.themeChanged(ThemeConfig theme) = ThemeChanged;

  const factory ThemePickerEvent.remoteThemeUpdated(ThemeConfig theme) = _RemoteThemeUpdated;

  const factory ThemePickerEvent.updateThemeRequested(ThemeConfig theme) = _UpdateThemeRequested;
}
