import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class CommentListTile extends StatelessWidget {
  CommentPresentation comment;
  CommentListTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundImage: AssetImage(comment.userImageUrl),
            ),
            const HorizontalSpacing(of: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    comment.userNickname,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 13),
                  ),
                ),
                Text(
                  comment.body,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      comment.createdAt,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    //const Text('   \u{00B7}'),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        //padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        primary: Colors.black.withOpacity(0.4),
                      ),
                      child: const Text(
                        '답글달기',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
