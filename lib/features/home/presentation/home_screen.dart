import 'package:flutter/material.dart';

import '../../../app/responsive.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) => HomeView(
        content: _viewModel.content,
        hasStarted: _viewModel.hasStarted,
        onGetStarted: _viewModel.startExperience,
      ),
    );
  }
}
