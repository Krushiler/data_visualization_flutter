import 'package:data_visualization/data/repository/breed_repository.dart';
import 'package:data_visualization/data/storage/breed_filter_storage.dart';
import 'package:data_visualization/data/storage/breeds_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDi extends StatelessWidget {
  final Widget child;

  const AppDi({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => BreedFilterStorage()),
        RepositoryProvider(create: (context) => BreedsStorage()),
        RepositoryProvider(create: (context) => BreedRepository(context.read(), context.read())),
      ],
      child: child,
    );
  }
}
