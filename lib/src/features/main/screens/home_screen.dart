import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            child: Text(
              "Upcoming Bookings",
              style: CTheme.of(context).theme.bodyText,
            ),
          ),
          const Gap(20),
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
            ),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/turf/$i.jpg"))),
                  );
                },
              );
            }).toList(),
          ),
          const Gap(10),
          Text(
            "What Will You Get?",
            style: CTheme.of(context).theme.heading,
          ),
          const Gap(10),
          Text(
            "Lorem ipsum dolor sit amet consectetur. Adipiscing felis egestas fermentum molestie. Gravida porttitor sit tincidunt sapien commo pellentesque. Lacinia quis pharetra feugiat eu scelerisque amet pulvinar. Fermentum pulvinar purus sed enim volutpat.",
            style: CTheme.of(context).theme.bodyText,
          ),
          const Gap(10),
          Text(
            "Amenities",
            style: CTheme.of(context).theme.heading,
          ),
          const Gap(10),
          SizedBox(
            height: 75,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                for (int i = 0; i <= 7; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      label: const Text(
                        "Parking",
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      backgroundColor: Colors.grey[400],
                    ),
                  ),
              ],
            ),
          ),
          const Gap(20),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: CTheme.of(context).theme.buttonStyle,
                  onPressed: () {
                    context.push("/booking_wrapper");
                  },
                  child: const Text("Get Started")),
            ),
          ),
          const Gap(50),
        ],
      ),
    );
  }
}