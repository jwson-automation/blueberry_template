import 'package:flutter/material.dart';

import '../../model/DogProfileModel.dart';

class SwiperCardWidget extends StatelessWidget {
  final DogProfileModel dogProfiles;

  const SwiperCardWidget(
    this.dogProfiles, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(dogProfiles.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.8), Colors.transparent],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.03, horizontal: width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dogProfiles.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      '${dogProfiles.gender} • ${dogProfiles.breed} • ${dogProfiles.location}',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.005),
                Text(
                  dogProfiles.bio,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
