import 'package:data_visualization/data/storage/theme_config_storage.dart';
import 'package:data_visualization/domain/model/config/theme_config.dart';

class ConfigRepository {
  final ThemeConfigStorage _themeConfigStorage;

  ConfigRepository(this._themeConfigStorage);

  Stream<ThemeConfig> watchThemeConfig() => _themeConfigStorage.watch();

  void applyThemeConfig(ThemeConfig themeConfig) {
    _themeConfigStorage.put(themeConfig);
  }
}
