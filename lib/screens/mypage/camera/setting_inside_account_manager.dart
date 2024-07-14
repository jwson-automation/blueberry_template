import 'package:blueberry_flutter_template/widgets/CustomDivider.dart';
import 'package:blueberry_flutter_template/widgets/MiniAvatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixSettingAccountManager extends ConsumerStatefulWidget {
  const FixSettingAccountManager({super.key});

  @override
  ConsumerState<FixSettingAccountManager> createState() => _FixSettingAccountManagerState();
}

class _FixSettingAccountManagerState extends ConsumerState<FixSettingAccountManager> {
  bool showNumber = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("나의 계정 관리"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                MiniAvatar(),
                SizedBox(
                  width: 20,
                ),
                Text("홍길동"),
              ],
            ),
          ),
          const Divider(),
            ListTile(
                leading: Icon(Icons.call),
                title: showNumber ? Text("010-1234-5678") : Text("010-**34-56**"),
                trailing: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      showNumber = !showNumber;
                    });
                  },
                  child: Container(
                    child: Text("보이기"),
                  ),
                ),
              ),

             ListTile(
                leading: Icon(Icons.person),
                title: Text("로그 아웃"),
                trailing: ElevatedButton(
                  onPressed: (){

                  },
                  child: Container(
                    child: Text("Log out"),
                  ),
                ),
              )
        ],
      ),
    );
  }
}
