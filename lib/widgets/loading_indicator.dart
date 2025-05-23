import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool loading;
  final Widget child;
  const LoadingIndicator({
    super.key, 
    required this.loading, 
    required this.child,
  });

  @override
  Widget build(BuildContext c) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: loading
        ? const Center(child: CircularProgressIndicator())
        : child,
    );
  }
}
