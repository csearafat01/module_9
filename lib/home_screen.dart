import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Constructor
/// CreateState
/// InitState

/// DidChangeDependencies - dependency change
/// build - setState
/// didUpdateWidget - Parent er configuration change

/// deactivate
/// dispose

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;

  // 1
  @override
  void initState() {
    if (kDebugMode) {
      print('init state');
    }
    /// Task when screen start
    super.initState();
  }

  // 2
  @override
  void didChangeDependencies() {
    if (kDebugMode) {
      print('Did change dependency');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    if (kDebugMode) {
      print('did update widget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Build method');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text('$count', style: const TextStyle(
            fontSize: 32
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // count = count + 1;
          count++;
          setState(() {}); // rebuild
        },
      ),
    );
  }

  // 5
  @override
  void deactivate() {
    if (kDebugMode) {
      print('deactivated');
    }
    super.deactivate();
  }

  // 6
  @override
  void dispose() {
    if (kDebugMode) {
      print('dispose');
    }
    super.dispose();
  }
}