import 'dart:math';
import 'package:flutter/material.dart';

/**
 * EventRulletPage.dart
 *
 * Event Rullet Page
 * - 이벤트 룰렛 페이지
 * - 이벤트 룰렛을 보여주는 화면
 *
 * @jwson-automation
 */

class EventRulletPage extends StatefulWidget {
  @override
  _EventRulletPageState createState() => _EventRulletPageState();
}

class _EventRulletPageState extends State<EventRulletPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _angle = 2 * pi * _animation.value;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startRotation() {
    _controller.reset();
    _controller.forward();
  }

  void _shareEvent() {
    // Placeholder for sharing functionality
    // Implement sharing to KakaoTalk and Line here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE9EC),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                '두근두근\n봄맞이 이벤트',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              '두근두근 많은 고객님을 초대하는 이벤트',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'Spring Event',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            Text(
              '단 한번의 기회를 놓치지마세요!',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 48.0),
            GestureDetector(
              onTap: _startRotation,
              child: Transform.rotate(
                angle: _angle,
                child: Icon(
                  Icons.ac_unit,
                  size: 200.0,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              width: 500,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Image.network(
                      'https://corsproxy.io/?https%3A%2F%2Foaidalleapiprodscus.blob.core.windows.net%2Fprivate%2Forg-TUBHLKYl2lBqM1b7iE99XgMQ%2Fuser-UjOypK7HRZS7bCpwDOO1UgLB%2Fimg-CqG3XQ7EnMcTMWz37aAndnok.png%3Fst%3D2024-05-03T23%253A25%253A13Z%26se%3D2024-05-04T01%253A25%253A13Z%26sp%3Dr%26sv%3D2021-08-06%26sr%3Db%26rscd%3Dinline%26rsct%3Dimage%2Fpng%26skoid%3D6aaadede-4fb3-4698-a8f6-684d7786b067%26sktid%3Da48cca56-e6da-484e-a814-9c849652bcb3%26skt%3D2024-05-03T21%253A10%253A03Z%26ske%3D2024-05-04T21%253A10%253A03Z%26sks%3Db%26skv%3D2021-08-06%26sig%3D7SyiRFtU8DvXWjwOnuQ0fRl05oAdMIXvOBWpPMiKQj8%253D',
                      width: 100,
                    ),
                    onPressed: _shareEvent,
                  ),
                  IconButton(
                    icon: Image.network(
                      'https://corsproxy.io/?https%3A%2F%2Foaidalleapiprodscus.blob.core.windows.net%2Fprivate%2Forg-TUBHLKYl2lBqM1b7iE99XgMQ%2Fuser-UjOypK7HRZS7bCpwDOO1UgLB%2Fimg-skcDKyzRvNrDbvttwhBK8DQF.png%3Fst%3D2024-05-03T23%253A25%253A16Z%26se%3D2024-05-04T01%253A25%253A16Z%26sp%3Dr%26sv%3D2021-08-06%26sr%3Db%26rscd%3Dinline%26rsct%3Dimage%2Fpng%26skoid%3D6aaadede-4fb3-4698-a8f6-684d7786b067%26sktid%3Da48cca56-e6da-484e-a814-9c849652bcb3%26skt%3D2024-05-03T21%253A13%253A55Z%26ske%3D2024-05-04T21%253A13%253A55Z%26sks%3Db%26skv%3D2021-08-06%26sig%3DKAyuzSMzb7oOGa1Dbt0vR3VRfNvvz84BPA0ETCzORmw%253D',
                      width: 100,
                    ),
                    onPressed: _shareEvent,
                  ),
                  IconButton(
                    icon: Image.network(
                      'https://corsproxy.io/?https%3A%2F%2Foaidalleapiprodscus.blob.core.windows.net%2Fprivate%2Forg-TUBHLKYl2lBqM1b7iE99XgMQ%2Fuser-UjOypK7HRZS7bCpwDOO1UgLB%2Fimg-vgPshu1cYGY6mqZOxfwRnxFm.png%3Fst%3D2024-05-03T23%253A25%253A15Z%26se%3D2024-05-04T01%253A25%253A15Z%26sp%3Dr%26sv%3D2021-08-06%26sr%3Db%26rscd%3Dinline%26rsct%3Dimage%2Fpng%26skoid%3D6aaadede-4fb3-4698-a8f6-684d7786b067%26sktid%3Da48cca56-e6da-484e-a814-9c849652bcb3%26skt%3D2024-05-03T21%253A14%253A47Z%26ske%3D2024-05-04T21%253A14%253A47Z%26sks%3Db%26skv%3D2021-08-06%26sig%3DtjZ6bJKStx5WnZvUNJuST0pcb9xzINE4F4dX%252Bhag0mA%253D',
                      width: 100,
                    ),
                    onPressed: _shareEvent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
