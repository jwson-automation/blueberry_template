import 'package:flutter/material.dart';

import '../../../dto/EventDto.dart';
import '../../../utils/ResponsiveLayoutBuilder.dart';

/**
 * EventDetailPage.dart
 *
 * Event Detail Page
 * - 이벤트 상세 페이지
 * - 이벤트 상세 정보를 보여주는 화면
 *
 * @jwson-automation
 */

class EventDetailPage extends StatelessWidget {
  final EventDTO event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      context,
      Scaffold(
        appBar: AppBar(
          title: Text(event.title),
          backgroundColor: Colors.red,
        ),
        body: ListView(
          children: [
            _buildTopBanner(),
            _buildCouponSection(),
            _buildRecommendationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBanner() {
    return Container(
      color: Colors.yellow[700],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            event.eventMainTitle,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            event.eventSubTitle,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          const SizedBox(height: 16.0),
          Image.network(
            event.imageUrl,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            '놓칠 수 없는 5월의 혜택!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '최대 10만원 할인 쿠폰순 쿠폰팩',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[700],
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'COUPON',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            child: const Text('쿠폰 받아보기'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationSection() {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.eventItemTitle,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            event.eventItemSubTitle,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildHotelCard('호텔1', '88,830원', '87%', '66,000원'),
          _buildHotelCard('호텔2', '111,300원', '79%', '52,000원'),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            child: const Text('자세히 보기'),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(
      String hotelName, String price, String discount, String originalPrice) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              'https://corsproxy.io/?https%3A%2F%2Foaidalleapiprodscus.blob.core.windows.net%2Fprivate%2Forg-TUBHLKYl2lBqM1b7iE99XgMQ%2Fuser-UjOypK7HRZS7bCpwDOO1UgLB%2Fimg-W90hwQTpRTFnl84lo9lDeziL.png%3Fst%3D2024-05-03T02%253A44%253A29Z%26se%3D2024-05-03T04%253A44%253A29Z%26sp%3Dr%26sv%3D2021-08-06%26sr%3Db%26rscd%3Dinline%26rsct%3Dimage%2Fpng%26skoid%3D6aaadede-4fb3-4698-a8f6-684d7786b067%26sktid%3Da48cca56-e6da-484e-a814-9c849652bcb3%26skt%3D2024-05-02T23%253A33%253A15Z%26ske%3D2024-05-03T23%253A33%253A15Z%26sks%3Db%26skv%3D2021-08-06%26sig%3DsIkyy3W9gxlFJC140lpDLOkqNBKj0H7hg6phUEIOrsw%253D',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '할인 $discount',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '정가 $originalPrice',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
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
