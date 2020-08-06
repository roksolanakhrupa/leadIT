import 'package:flutter/material.dart';

class CommentsCard extends StatelessWidget {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentsCard({this.postId, this.id, this.name, this.email, this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(email,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic)),
          Text(name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold)),
          Text(body, style: TextStyle(color: Colors.grey, fontSize: 15.0)),
          Divider(color: Colors.grey,),
        ],
      ),
    );
  }
}
