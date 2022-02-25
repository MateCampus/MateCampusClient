import 'package:flutter/material.dart';

class HorizontalDividerCustom extends StatelessWidget {
  final double of;

  const HorizontalDividerCustom({Key? key, this.of = 5.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey[300],
      thickness: of,
    );
  }
}
