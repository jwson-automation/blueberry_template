import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'GridAItems.dart';

class FriendsListPage extends StatelessWidget {
  FriendsListPage({super.key});

  // GridAitems 리스트 정의
  final List<GridAitems> gridAitems = [
    GridAitems(
      image: "https://images.unsplash.com/photo-1571566882372-1598d88abd90?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Item 1",
      price: "\$10", id: '1',
    ),
    GridAitems(
      image: "https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Item 2",
      price: "\$20", id: '2',
    ),
    GridAitems(
      image: "https://images.unsplash.com/photo-1574144611937-0df059b5ef3e?q=80&w=2864&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Item 3",
      price: "\$30", id: '3',
    ),
    GridAitems(
      image: "https://images.unsplash.com/photo-1503256207526-0d5d80fa2f47?q=80&w=2848&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Item 4",
      price: "\$40", id: '4',
    ),
    GridAitems(
      image: "https://images.unsplash.com/photo-1530281700549-e82e7bf110d6?q=80&w=2788&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Item 5",
      price: "\$50", id: '5',
    ),
    GridAitems(
      image: "https://images.unsplash.com/photo-1517849845537-4d257902454a?q=80&w=2835&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Item 6",
      price: "\$60", id: '6',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Friends List'),
      // ),
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Friends List'),
        ),
        centerTitle: false, // 타이틀을 왼쪽으로 정렬
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridA(gridAitems: gridAitems), // 여기에 gridAitems 리스트를 전달
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GridA extends StatelessWidget {
  const GridA({super.key, required this.gridAitems});

  final List<GridAitems> gridAitems;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 320, // 그리드 아이템 박스 높이
      ),
      itemCount: gridAitems.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(gridAitems[index].image,
                    height: 200, width: double.infinity, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/default_image.png', // 에러 발생 시 대체할 이미지
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    Text(
                      gridAitems[index].name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(gridAitems[index].price),
                    const SizedBox(
                      height: 2,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: null, // '좋아요' 기능 구현
                            icon: Icon(
                              CupertinoIcons.heart,
                            )),
                        IconButton(
                            onPressed: null, // '장바구니에 추가' 기능 구현
                            icon: Icon(
                              CupertinoIcons.cart,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
