import 'package:data_visualization/data/breed_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppModule extends StatelessWidget {
  final Widget child;

  const AppModule({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => BreedRepository()),
      ],
      child: child,
    );
  }
}
