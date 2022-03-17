import 'package:flutter/material.dart';

import 'package:zamongcampus/src/ui/views/post/post_create/components/check_options.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/components/tag_category.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/components/text_input_space.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 5), //이부분 간격 체크,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextInputSpace(),
            CheckOptions(),
            TagCategory(),
          ],
        ),
      ),
    );
  }
}
