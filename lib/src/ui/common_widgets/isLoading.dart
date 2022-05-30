import 'package:flutter/material.dart';

class IsLoading extends StatelessWidget {
  const IsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      //height: 150,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
