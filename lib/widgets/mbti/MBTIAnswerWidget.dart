import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MBTIAnswerWidget extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref){
    return _buildListView(["INTJ", "치킨"]);
  }
}

Widget _buildListView(List<String> data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(data[index]),
      );
    },
  );
}