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
  int lenght = 5;

  void getSubscriptions() async {
    await AuthService().getsubscriptions(LoginPage.username).then((val) {
      setState(() {
        mangas = val;
        hideLoadingOverlay();
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
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidgetUser(),
      body: CustomScrollView(
        slivers: [
          const SliverHeader(title: "Abonelikler"),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 225,
                mainAxisSpacing: 10,
                crossAxisSpacing: 15,
                childAspectRatio: .55,
                mainAxisExtent: 400,
              ),
              delegate: SliverChildListDelegate.fixed(mangas
                  .map<Widget>((manga) => Container(
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pushNamed("/artist"),
                              child: Text(manga['manganame'].toString(),
                                  style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height: 300,
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed("/content"),
                                    child: Image.network(
                                      manga['mangacoverurl'].toString(),
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
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
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed("/artist"),
                                  child: Text(
                                    manga['mangaartist'].toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("/genre"),
                                  child: Text(
                                    manga['mangagenre'].toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ))
                  .toList()),
            ),
          ),
        ],
      ),
    );
  }
}
