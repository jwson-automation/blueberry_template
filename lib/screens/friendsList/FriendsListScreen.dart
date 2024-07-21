import 'package:flutter/material.dart';

class FriendsListScreen extends StatelessWidget {
  FriendsListScreen({super.key});

  final List<Friend> friends = [
    Friend(
      image: "https://images.unsplash.com/photo-1571566882372-1598d88abd90?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "CameraDog",
      lastConnect: "3 days ago",
      status: "Sometimes I wanna be...",
      likes: 32,
    ),
    Friend(
      image: "https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Piggy Pig",
      lastConnect: "3 months ago",
      status: "Stop Eating Me...",
      likes: 3,
    ),
    Friend(
      image: "https://images.unsplash.com/photo-1574144611937-0df059b5ef3e?q=80&w=2864&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Big Boss Hamster",
      lastConnect: "3 days ago",
      status: "Today work out is done...",
      likes: 120,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return FriendTile(friend: friends[index]);
        },
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  final Friend friend;

  const FriendTile({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(friend.image),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(friend.lastConnect),
                  const SizedBox(height: 5),
                  Text(friend.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(friend.status),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 16.0), // left padding added
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 5),
                  Text(friend.likes.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Friend {
  final String image;
  final String name;
  final String lastConnect;
  final String status;
  final int likes;

  Friend({
    required this.image,
    required this.name,
    required this.lastConnect,
    required this.status,
    required this.likes,
  });
}
