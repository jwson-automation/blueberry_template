class DogProfileModel {
  final String name;
  final String gender;
  final String breed;
  final String bio;
  final String imageUrl;
  final String location;

  DogProfileModel({
    required this.name,
    required this.gender,
    required this.breed,
    required this.bio,
    required this.imageUrl,
    required this.location,
  });
}

final List<DogProfileModel> dogProfiles = [
  DogProfileModel(
    name: '멍멍이',
    gender: '수컷',
    breed: '골든 리트리버',
    location: '서울',
    bio: '산책을 좋아하는 활발한 강아지예요!',
    imageUrl: 'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcY8RCd%2FbtsC31gfzPL%2FbSnADONPu66xPesaWHmW00%2Fimg.jpg',
  ),
  DogProfileModel(
    name: '뭉치',
    gender: '암컷',
    breed: '푸들',
    location: '부산',
    bio: '애교 많고 사랑스러운 강아지입니다.',
    imageUrl: 'https://image.dongascience.com/Photo/2017/07/14994185580021.jpg',
  ),
  DogProfileModel(
    name: '초코',
    gender: '수컷',
    breed: '비글',
    location: '대구',
    bio: '장난기 많고 활발한 성격이에요.',
    imageUrl: 'https://cdn.newscj.com/news/photo/201309/170126_122268_2013.jpg',
  ),
];