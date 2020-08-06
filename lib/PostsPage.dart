import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterleadit/PostsList.dart';
import 'package:http/http.dart' as http;

import 'Post.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future<List<Post>> fetchPosts(http.Client client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts');

    return parsePosts(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? PostsList(posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PostsList.scroll();
        },
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}
