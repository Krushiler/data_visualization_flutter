import 'package:data_visualization/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBlocProvider extends StatelessWidget {
  final Widget child;

  const DashboardBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(context.read()),
      child: child,
    );
  }
}
