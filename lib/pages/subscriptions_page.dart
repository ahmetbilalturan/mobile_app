import 'package:flutter/material.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

class SubscriptionsPage extends StatefulWidget {
  final int userID;

  const SubscriptionsPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPage();
}

class _SubscriptionsPage extends State<SubscriptionsPage> {
  OverlayEntry? entry;
  List mangas = [];
  bool isEmpty = false;
  List ids = [];

  void getSubscriptions() async {
    await AuthService().getsubscriptions(LoginPage.username).then((val) async {
      val.map((value) => {ids.add(value['_id'])}).toList();
      if (ids.isNotEmpty) {
        hideLoadingOverlay();
      }
      for (int i = 0; i < ids.length; i++) {
        mangas.add(await AuthService().getonefromallmangas(ids[i]));
      }
      setState(() {
        if (mangas.isEmpty) {
          isEmpty = true;
        } else {
          isEmpty = false;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getSubscriptions();
  }

  void showLoadingOverlay() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(
      builder: (context) => buildLoadingOverlay(),
    );

    overlay.insert(entry!);
  }

  void hideLoadingOverlay() {
    entry!.remove();
    entry = null;
  }

  Widget buildLoadingOverlay() => const Material(
        color: Colors.transparent,
        elevation: 8,
        child: Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 171, 192)),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidgetUser(),
      appBar: isEmpty
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              actions: const [
                SearchButton(), //pull userid and push search button
              ],
              title: const Text("Abonelikler",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            )
          : null,
      body: isEmpty
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFe699cb),
                    Color(0xFFf3ccfb),
                    Color(0xFFdce2f3),
                    Color(0xFFd4fbcc),
                    Color(0xFF73df99),
                  ],
                  stops: [
                    0.03,
                    0.25,
                    0.5,
                    0.85,
                    1.6,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: const Center(
                child: Text(
                  "Aboneliğiniz Bulunmamakta",
                  style: TextStyle(fontSize: 26),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFe699cb),
                    Color(0xFFf3ccfb),
                    Color(0xFFdce2f3),
                    Color(0xFFd4fbcc),
                    Color(0xFF73df99),
                  ],
                  stops: [
                    0.03,
                    0.25,
                    0.5,
                    0.85,
                    1.6,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  const SliverHeader(title: "Favoriler"),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 3,
                        childAspectRatio: .55,
                        mainAxisExtent: 200,
                      ),
                      delegate: SliverChildListDelegate.fixed(mangas
                          .map<Widget>(
                            (manga) => Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        color: const Color.fromARGB(
                                            255, 12, 12, 12),
                                        height: 200,
                                        width: 150,
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed("/content"),
                                          child: ShaderMask(
                                            shaderCallback: (rect) {
                                              return const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black,
                                                    Colors.transparent,
                                                  ],
                                                  stops: [
                                                    .45,
                                                    1,
                                                  ]).createShader(Rect.fromLTRB(
                                                  0,
                                                  0,
                                                  rect.width,
                                                  rect.height));
                                            },
                                            blendMode: BlendMode.dstIn,
                                            child: Image.network(
                                              manga['mangacoverurl'].toString(),
                                              fit: BoxFit.fill,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 15),
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      verticalDirection: VerticalDirection.down,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          manga['manganame'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        InkWell(
                                          onTap: () => {
                                            print('genre sayfasına gidildi')
                                          },
                                          child: Text(
                                            manga['mangagenre'].toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList()),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
