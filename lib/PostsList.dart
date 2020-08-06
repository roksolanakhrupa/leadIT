import 'package:flutter/material.dart';
import 'package:flutterleadit/PostCard.dart';

import 'DatabaseHelper.dart';
import 'Post.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;
  final dbHelper = DatabaseHelper.instance;

  static ScrollController _scrollController=ScrollController();

  PostsList({Key key, this.posts}) : super(key: key);

 static scroll()
  {
    _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
    );
  }


  addPostsToDatabase()async
  {
    for(Post p in posts) {
    Map<String, dynamic> row = {
      DatabaseHelper.columnTableUserId : p.userId,
      DatabaseHelper.columnTableTitle : p.title,
      DatabaseHelper.columnTableBody : p.body
    };
    await dbHelper.insertPost(row);
    }

//    final allRows = await dbHelper.queryAllPosts();
//    print('query all posts:');
//    allRows.forEach((row) => print(row));
  }

  @override
  Widget build(BuildContext context) {
    addPostsToDatabase();

    return ListView.builder(
      controller: _scrollController,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(title: posts[index].title, body: posts[index].body, id: posts[index].id);
      },
    );
  }
}