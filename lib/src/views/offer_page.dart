import 'package:carousel_slider/carousel_slider.dart';
import 'package:dzest_mobile/src/components/comment.dart';
import 'package:dzest_mobile/src/components/icon_text.dart';
import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/offer.dart';
import 'package:dzest_mobile/src/services/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final CarouselController _controller = CarouselController();
  List<String> images = [];

  final _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

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
                        margin:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
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
                                  text: ' ' +
                                      (offer?.created.toString() ?? 'no date'),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                    Row(
                      children: [
                        const Text(
                          'Agence :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          offer?.ownerName.toString() ?? 'no agency',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                          icon: Icons.local_offer_outlined,
                          text: 'Offer Type : Apartement',
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
            ],
          ),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "email",
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.email,
              size: 30,
            ),
            onPressed: () {
              launch(
                  'mailto:rajatrrpalankar@gmail.com?subject=This is Subject Title&body=This is Body of Email');
            },
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "phone",
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.phone,
              size: 30,
            ),
            onPressed: () {
              launch('tel:+91 88888888888');
              // launch('mailto:rajatrrpalankar@gmail.com?subject=This is Subject Title&body=This is Body of Email');
            },
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "comment",
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              Icons.comment,
              size: 30,
            ),
            onPressed: () {
              showBarModalBottomSheet(
                enableDrag: true,
                backgroundColor: Colors.transparent,
                expand: false,
                context: context,
                builder: (context) => FractionallySizedBox(
                  heightFactor: 0.8,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Comments :',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Add Comment',
                              floatingLabelStyle: TextStyle(
                                color: AppColors.primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.primaryColor,
                            style: const TextStyle(color: AppColors.textColor),

                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'this field cant be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
