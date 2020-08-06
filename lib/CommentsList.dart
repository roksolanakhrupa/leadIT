import 'package:flutter/material.dart';
import 'package:flutterleadit/Comment.dart';

import 'CommentsCard.dart';
import 'DatabaseHelper.dart';

class CommentsList extends StatelessWidget {
  final List<Comment> comments;
  final dbHelper = DatabaseHelper.instance;

  CommentsList({Key key, this.comments}) : super(key: key);

  addCommentsToDatabase()async
  {
    for(Comment c in comments) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnCommentPostId : c.postId,
        DatabaseHelper.columnCommentName : c.name,
        DatabaseHelper.columnCommentEmail : c.email,
        DatabaseHelper.columnCommentBody : c.body
      };
      await dbHelper.insertComment(row);
    }

//    final allRows = await dbHelper.queryAllComments();
//    print('query all comments:');
//    allRows.forEach((row) => print(row));
  }


  @override
  Widget build(BuildContext context) {
    addCommentsToDatabase();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentsCard(
            name: comments[index].name,
            email: comments[index].email,
            body: comments[index].body);
      },
    );
  }
}
