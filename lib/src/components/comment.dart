import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/offer.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  CommentBox({
    Key? key,
    required this.comment,
  }) : super(key: key);
  final Comment comment;

  double left_margin = 5.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(left_margin + comment.depth * 20, 5.0, 5.0, 5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 216, 214, 255),
            borderRadius: BorderRadius.circular(10),
            /*boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              //offset: Offset(0, 1), // changes position of shadow
                            ),
                            ],*/
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(comment.user),
              Text(comment.text),
            ],
          ),
        ),
        ListView.builder(
          //physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: comment.replies.length,
          itemBuilder: (context, index) {
            return CommentBox(
              comment: comment.replies[index],
            );
          },
        )
      ],
    );
  }
}
