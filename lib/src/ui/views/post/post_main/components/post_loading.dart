import 'package:flutter/material.dart';

class PostLoading extends StatelessWidget {
  const PostLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 400,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
