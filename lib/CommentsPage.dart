import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Comment.dart';
import 'CommentsList.dart';

class CommentsPage extends StatelessWidget {

  int id;
  CommentsPage({this.id});


  List<Comment> parseComments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
  }

  Future<List<Comment>> fetchComments(http.Client client) async {
    String url='https://jsonplaceholder.typicode.com/posts/'+id.toString()+'/comments';
    final response = await client.get(url);

    return parseComments(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35.0,10.0,35.0,10.0),
      child: FutureBuilder(
          future: fetchComments(http.Client()),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? CommentsList(comments: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
      ),
    );
  }
}
