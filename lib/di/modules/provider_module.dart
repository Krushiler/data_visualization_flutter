import 'package:data_visualization/data/storage/breed_filter_storage.dart';
import 'package:data_visualization/data/storage/theme_config_storage.dart';
import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/domain/model/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderModule extends StatelessWidget {
  final WidgetBuilder builder;

  const ProviderModule({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<BreedFilter>.value(
          value: context.read<BreedFilterStorage>().watch(),
          initialData: const BreedFilter(),
        ),
        StreamProvider<ThemeConfig>.value(
          value: context.read<ThemeConfigStorage>().watch(),
          initialData: ThemeConfig.defaultTheme(),
        ),
      ],
      builder: (context, _) => builder(context),
    );
  }
}
