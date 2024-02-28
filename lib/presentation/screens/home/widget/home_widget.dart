import 'package:data_visualization/presentation/common/widgets/filter/breed_filter_view.dart';
import 'package:data_visualization/presentation/common/widgets/theme/theme_picker_view.dart';
import 'package:data_visualization/presentation/navigation/navigation.dart';
import 'package:data_visualization/presentation/screens/home/bloc/home_cubit.dart';
import 'package:data_visualization/presentation/style/kit/dimens.dart';
import 'package:data_visualization/presentation/style/kit/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  final Widget child;

  const HomeWidget({super.key, required this.child});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  bool showMenu = false;

  late final AnimationController menuAnimationController;
  late final Animation<double> rotationAnimation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(menuAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Column(
              children: [
                ListTile(
                  title: const Icon(Icons.arrow_back_ios_new),
                  onTap: () {
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text("Dashboard"),
                  onTap: () {
                    context.navigation.navigateToDashboard();
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.line_axis),
                    title: const Text("Line Chart"),
                    onTap: () {
                      context.navigation.navigateToLineChart();
                      _scaffoldKey.currentState?.closeDrawer();
                    }),
                ListTile(
                    leading: const Icon(Icons.scatter_plot),
                    title: const Text("Scatter Chart"),
                    onTap: () {
                      context.navigation.navigateToScatterChart();
                      _scaffoldKey.currentState?.closeDrawer();
                    }),
                ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: const Text("Top Chart"),
                  onTap: () {
                    context.navigation.navigateToTopChart();
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
              ],
            ),
          ),
          body: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SafeArea(
                child: InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: Dimens.md),
                    child: SizedBox(
                      height: double.infinity,
                      width: Dimens.lg,
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),
              Expanded(child: widget.child),
              SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          showMenu = !showMenu;
                          showMenu ? menuAnimationController.forward() : menuAnimationController.reverse();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: Dimens.md),
                        child: RotationTransition(
                          turns: rotationAnimation,
                          child: const SizedBox(
                            height: double.infinity,
                            width: Dimens.lg,
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      ),
                    ),
                    SizeTransition(
                      sizeFactor: menuAnimationController,
                      axis: Axis.horizontal,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(Dimens.md),
                        child: Column(
                          children: [
                            const BreedFilterView(),
                            Gap.md,
                            const ThemePickerView(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
