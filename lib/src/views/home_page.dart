import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/offer_list.dart';
import 'package:dzest_mobile/src/services/sharedpref_manager.dart';
import 'package:dzest_mobile/src/views/offer_page.dart';
import 'package:flutter/material.dart';
import 'package:dzest_mobile/src/services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OfferList? offers;
  final String _q = "";
  var isLoaded = false;

  /* ************** pagination-load-more ************** */

  int page = 1;

  // There is next page or not
  bool hasNextPage = true;

  // Used to display loading indicators when _loadMore function is running
  bool isLoadMoreRunning = false;

  void loadMore() async {
    if (hasNextPage == true &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 300) {
      setState(() {
        isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      page += 1;

      if (offers?.next != null) {
        OfferList? moreOffers = await RemoteService().getOffers(page);
        setState(() {
          offers?.results.addAll(moreOffers!.results);
        });
      } else {
        setState(() {
          hasNextPage = false;
        });
      }

      setState(() {
        isLoadMoreRunning = false; // Display a progress indicator at the bottom
      });
    }
  }

  late ScrollController scrollController;

  bool is_agency = false;

  loadPref() async {
    is_agency = (await getAgency())!;
  }

  @override
  void initState() {
    super.initState();
    getData(page);
    scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    scrollController.removeListener(loadMore);
    super.dispose();
  }

  getData(value) async {
    offers = await RemoteService().getOffers(value);
    if (offers != null) {
      setState(() {
        isLoaded = true;
        loadPref();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            /*Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'For Rent',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'For Sale',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),*/
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
                      page = 1;
                      hasNextPage = true;
                      isLoadMoreRunning = false;
                      getData(page);
                      scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 100), curve: Curves.linear);
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
                    controller: scrollController,
                    itemCount: offers?.results.length,
                    itemBuilder: (context, index) {
                      return Container(
                          //padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          height: 160,
                          decoration: BoxDecoration(
                            //color: Colors.white,
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
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                //Navigator.pushNamed(context, '/offer');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OfferPage(offerID: offers!.results[index].id),
                                  ),
                                );
                              },
                              child: Row(children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        offers!.results[index].images[0].imageUrl,
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
                                            offers!.results[index].price.toString() + ' DA',
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
                                          offers!.results[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.titleColor,
                                          ),
                                        ),
                                        Text(
                                          'à ' + offers!.results[index].state,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          offers!.results[index].description,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                        Text(
                                          offers!.results[index].created,
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
                                                text: offers!.results[index].ownerName,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
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
                                              offers!.results[index].ownerName,
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
                              ]),
                            ),
                          ));
                    }),
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: is_agency
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              child: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/addoffer');
              },
            )
          : null,
    );
  }
}
