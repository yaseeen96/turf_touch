import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/providers/home_screen_provider.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeScreenProvider);

    return homeData.when(
        data: (data) => Scaffold(
              backgroundColor: CTheme.of(context).theme.backgroundColor,
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: CTheme.of(context).theme.primaryColor,
                    foregroundColor: CTheme.of(context).theme.backgroundColor,
                    onPressed: () async {
                      final uri = Uri(
                          scheme: "google.navigation",
                          // host: '"0,0"',  {here we can put host}
                          queryParameters: {
                            'q': '${data.latitude}, ${data.longitude}'
                          });
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        debugPrint('An error occurred');
                      }
                    },
                    child: const Icon(Icons.directions),
                  ),
                  const Gap(10),
                  FloatingActionButton(
                    backgroundColor: CTheme.of(context).theme.backgroundInverse,
                    foregroundColor: CTheme.of(context).theme.backgroundColor,
                    onPressed: () async {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: data.phoneNo,
                      );
                      await launchUrl(launchUri);
                    },
                    child: const Icon(Icons.call),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1,
                      ),
                      items: data.sliderImages!.map((imageUrl) {
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
                                    image: NetworkImage(imageUrl),
                                  )),
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
                      data.description!,
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
                          for (String i in data.amenities!)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                label: Text(
                                  i,
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
              ),
            ),
        error: (error, stackTrace) => Center(
              child: Text(
                  (error is TurfTouchException) ? "$error" : "Unknown Error"),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
