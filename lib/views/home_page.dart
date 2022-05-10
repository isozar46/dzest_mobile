import 'package:dzest_mobile/constants/app_colors.dart';
import 'package:dzest_mobile/models/offer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dzest_mobile/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offer>? offers;
  final String _q = "";
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getData(_q);
  }

  getData(value) async {
    offers = await RemoteService().getOffers(value);
    if (offers != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add Offer'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        //title: Text(widget.title),
        //leading: null, // 1
        title:
            Image.asset("assets/images/horizontal-logo.png", width: 110), // 2
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                  elevation: 0,
                ),
                child: Text('Login')),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (val) {
                  getData(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search Offers',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // initiate search on press
                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Latest Offers:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      getData(_q);
                    },
                    child: const Text(
                      'Refresh',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Visibility(
                visible: isLoaded,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: offers?.length,
                    itemBuilder: (context, index) {
                      return Container(
                          //padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          height: 160,
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
                          child: Row(children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/slideshow/02C.jpg?1590547607",
                                    fit: BoxFit.fill,
                                    height: 160,
                                    width: 160,
                                  ),
                                ),
                                SizedBox(
                                  height: 160,
                                  width: 160,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Text(
                                        offers![index].price.toString() + ' DA',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      offers![index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.titleColor,
                                      ),
                                    ),
                                    Text(
                                      'location',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    Text(
                                      offers![index].description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    Text(
                                      'on date ',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'published by ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                          TextSpan(
                                              text: offers![index].ownerName,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushNamed(context,
                                                      '/agencyprofile');
                                                }),
                                        ],
                                      ),
                                    ),
                                    /*Row(
                                      children: [
                                        Text(
                                          'published by ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                        Text(
                                          offers![index].ownerName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),*/
                                  ],
                                ),
                              ),
                            )
                          ]));
                    }),
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offers![index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    offers![index].description ?? '',
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

*/
