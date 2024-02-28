import 'package:data_visualization/data/storage/base/base_storage.dart';
import 'package:data_visualization/domain/model/config/theme_config.dart';

class ThemeConfigStorage extends BaseStorage<ThemeConfig> {
  ThemeConfigStorage() : super(initialData: ThemeConfig.defaultTheme());
}
