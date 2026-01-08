import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderItem extends StatefulWidget {
  final List<String> images;
  int length;
  
   SliderItem({Key? key, required this.length ,required this.images}) : super(key: key);

  @override
  State<SliderItem> createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  
  HomeController homeController = Get.find<HomeController>();
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CarouselSlider.builder(
                itemCount: widget.images.length,
                itemBuilder: (context, index, realIndex) {
                  return CustomImage.network(
                    widget.images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  autoPlay: false,
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
             homeController.activeIndex.value = index;
                  },
                ),
                carouselController: _controller,
              ),
            ),

            Positioned(
              right: 10,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 14),
                  color: Colors.black,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _controller.nextPage();
                  },
                ),
              ),
            ),


            Positioned(
              left: 10,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 14),
                  color: Colors.black,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _controller.previousPage();
                  },
                ),
              ),
            ),

          ],
        ),

        const SizedBox(height: 8),

     AnimatedSmoothIndicator(
          activeIndex:homeController.activeIndex.value,
          count: widget.images.length,
          effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.pinkAccent,
            dotColor: CustomColors.grey,
          ),
        )
      ],
    );
  }
}
