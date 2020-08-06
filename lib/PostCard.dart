import 'package:flutter/material.dart';

import 'CommentsPage.dart';

class PostCard extends StatefulWidget {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostCard({this.userId, this.id, this.title, this.body});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.0),
              color: Colors.grey[300],
              margin: EdgeInsets.all(5.0),
              child: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Text("${widget.id}. "+"${widget.title}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0)),
                      Text(widget.body, style: TextStyle(color: Colors.grey, fontSize: 15.0),)
                    ],
                  ),
                  onTap: () {
                    isVisible = !isVisible;
                    setState(() {});
                  }),
            ),
            Visibility(
              child: CommentsPage(id: widget.id),
              visible: isVisible,
            )
          ],
        ));
  }
}
