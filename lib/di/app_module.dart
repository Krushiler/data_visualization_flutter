import 'package:data_visualization/data/repository/breed_repository.dart';
import 'package:data_visualization/data/repository/config_repository.dart';
import 'package:data_visualization/data/storage/breed_filter_storage.dart';
import 'package:data_visualization/data/storage/breeds_storage.dart';
import 'package:data_visualization/data/storage/theme_config_storage.dart';
import 'package:data_visualization/di/modules/provider_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppModule extends StatelessWidget {
  final WidgetBuilder builder;

  const AppModule({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => BreedFilterStorage()),
        RepositoryProvider(create: (context) => BreedsStorage()),
        RepositoryProvider(create: (context) => ThemeConfigStorage()),
        RepositoryProvider(create: (context) => ConfigRepository(context.read())),
        RepositoryProvider(create: (context) => BreedRepository(context.read(), context.read())),
      ],
      child: ProviderModule(builder: (context) => builder(context)),
    );
  }
}
