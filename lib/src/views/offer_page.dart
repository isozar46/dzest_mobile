import 'package:carousel_slider/carousel_slider.dart';
import 'package:dzest_mobile/src/components/comment.dart';
import 'package:dzest_mobile/src/components/icon_text.dart';
import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/offer.dart';
import 'package:dzest_mobile/src/services/remote_service.dart';
import 'package:flutter/material.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({
    Key? key,
    required this.offerID,
  }) : super(key: key);
  final int offerID;

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  Offer? offer;
  int _current = 0;
  var isLoaded = false;
  // offers![index].images[0].imageUrl,
  final CarouselController _controller = CarouselController();
  List<String> images = [];
  /*final List<String> images = [
    "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/slideshow/02C.jpg?1590547607",
    "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/slideshow/02C.jpg?1590547607",
    "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/slideshow/02C.jpg?1590547607",
    "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/slideshow/02C.jpg?1590547607",
    "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/slideshow/02C.jpg?1590547607"
  ];*/

  @override
  void initState() {
    super.initState();

    getData(widget.offerID);
  }

  getData(value) async {
    offer = await RemoteService().getOffer(value);
    if (offer != null) {
      setState(() {
        isLoaded = true;
        for (var i = 0; i < offer!.images.length; i++) {
          images.add(offer!.images[i].imageUrl);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer details"),
      ),
      body: SafeArea(
        child: Visibility(
          visible: isLoaded,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 1.5,
                    //enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                        //padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              //offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            i,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : AppColors.primaryColor)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      //offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer?.title ?? 'no title',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconText(
                                  icon: Icons.access_time,
                                  text: ' ' + (offer?.created.toString() ?? 'no date'),
                                ),
                                SizedBox(width: 10),
                                IconText(
                                  icon: Icons.location_on_outlined,
                                  text: offer?.state.toString() ?? 'no state',
                                ),
                              ],
                            ),
                            Text(
                              (offer?.price.toString() ?? 'no price') + ' DA',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.favorite_rounded,
                          color: Colors.pink,
                          size: 35,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      //offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Property info :',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: const [
                        IconText(
                          icon: Icons.rectangle_outlined,
                          text: ' Area : 135 m2',
                        ),
                        SizedBox(width: 10),
                        IconText(
                          icon: Icons.water_drop_outlined,
                          text: 'Water',
                        ),
                        SizedBox(width: 10),
                        IconText(
                          icon: Icons.fiber_manual_record_outlined,
                          text: 'Gas',
                        ),
                        SizedBox(width: 10),
                        IconText(
                          icon: Icons.flash_on_rounded,
                          text: 'Electrisity',
                        ),
                        SizedBox(width: 10),
                        IconText(
                          icon: Icons.signal_cellular_alt_rounded,
                          text: ' internet',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      //offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description :',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      offer?.description ?? 'no description',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      //offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Comments :',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      //physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: offer?.comments.length,
                      itemBuilder: (context, index) {
                        return CommentBox(
                          comment: offer!.comments[index],
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
