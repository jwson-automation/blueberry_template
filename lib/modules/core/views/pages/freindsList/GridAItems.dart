class GridAitems {
  String id;
  String name;
  String price;
  String image;

  GridAitems(
      {required this.id,
      required this.name,
      required this.price,
      required this.image});

  //DB와 통신을 위해 필요한 코드
  //Json 데이터를 위의 객체로 변환 시키는 코드
  factory GridAitems.fromJson(Map<String, dynamic> json) {
    return GridAitems(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        image: json['image']);
  }

  //객체를 Json 데이터로 변환 시키는 코드(firebase에 데이터를 저장할 때는 필요 없음)
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'price': price, 'image': image};
}
