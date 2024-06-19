import 'package:fleet_tracker/Service/API/Original/comment_service.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  CommentService().getCommentList(warehouseId: 1);
                },
                child: const Text('getComment')),
            ElevatedButton(
                onPressed: () {
                  CommentService().postComment(uid: 'user1', warehouseId: 1, contents: 'contents');
                },
                child: const Text('postComment')),
            ElevatedButton(
                onPressed: () {
                  CommentService().deleteComment(commentId: 1);
                },
                child: const Text('deleteComment')),
            ElevatedButton(
                onPressed: () {
                  WarehouseService().searchWarehouseList(userLatitude: 1.0, userLongitude: 1.0);
                },
                child: const Text('searchWarehouseList')),
            ElevatedButton(
                onPressed: () {
                  WarehouseService().getWarehouseList(1);
                },
                child: const Text('getWarehouseList')),
          ],
        ),
      ),
    );
  }
}
