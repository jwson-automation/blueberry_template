import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatListWidget extends StatefulWidget {
  final List chatList;
  final String recentMesssage;
  final DateTime recentChatTime;
  final String? chatPhotoPath;
  const ChatListWidget({super.key, required this.chatList, required this.recentMesssage, required this.recentChatTime, this.chatPhotoPath});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.chatList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(index.toString()), // 각 항목에 고유한 키 부여
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: const Color(0xff910c1b),
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(CupertinoIcons.delete_simple, color: Colors.white, size: 16,),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                widget.chatList.removeAt(index);
              });
            },
            child: GestureDetector(
              // 채팅화면으로 넘어가는 로직
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(child: Row(
                      children: [
                        buildProfileImage(widget.chatPhotoPath),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.chatList[index], style: const TextStyle(color: Colors.black, fontSize: 15)),
                            Text(widget.recentMesssage, style: const TextStyle(color: Colors.grey, fontSize: 12), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ],
                    )),
                  Text(DateFormat('a h:mm', 'ko_KR').format(widget.recentChatTime), style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  buildProfileImage(String? path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: path != null && path.isNotEmpty
          ? Image.asset(
        path,
        fit: BoxFit.cover,
        width: 45,
        height: 45,
      )
          : Container(
        width: 45,
        height: 45,
        color: Colors.grey,
      ),
    );
  }
}
