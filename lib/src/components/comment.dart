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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(left_margin + comment.depth * 20, 5.0, 5.0, 5.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/vecteurs-libre/homme-affaires-caractere-avatar-isole_24877-60111.jpg?w=2000'),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
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
                      Text(
                        comment.user,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(comment.text),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
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
