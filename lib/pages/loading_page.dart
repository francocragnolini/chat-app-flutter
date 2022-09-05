import "package:flutter/material.dart";

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text("Loading Page"),
      ),
    );
  }
}