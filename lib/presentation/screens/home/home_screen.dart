import 'package:data_visualization/presentation/screens/home/bloc/home_cubit.dart';
import 'package:data_visualization/presentation/screens/home/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeCubit(context.read())..init(), child: HomeWidget(child: child));
  }
}
