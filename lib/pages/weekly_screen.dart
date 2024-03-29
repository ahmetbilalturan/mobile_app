import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/widgets/all_widgets.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/services/authservices.dart';

class WeeklyScreen extends StatefulWidget {
  final String day;
  const WeeklyScreen({Key? key, required this.day}) : super(key: key);

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 7, vsync: this);
  OverlayEntry? entry;
  List<Manga> allmangas = [];
  List<Manga> dummyMangas = [];
  String query = '';

  void getAllMangas() async {
    await AuthService().getallmangas().then((val) {
      setState(() {
        allmangas = val.map((json) => Manga.fromJson(json)).toList();
        dummyMangas = allmangas;
        hideLoadingOverlay();
      });
    });
  }

  void selectTab() {
    switch (widget.day) {
      case 'Pazartesi':
        _tabController.index = 0;
        break;
      case 'Salı':
        _tabController.index = 1;
        break;
      case 'Çarşamba':
        _tabController.index = 2;
        break;
      case 'Perşembe':
        _tabController.index = 3;
        break;
      case 'Cuma':
        _tabController.index = 4;
        break;
      case 'Cumartesi':
        _tabController.index = 5;
        break;
      case 'Pazar':
        _tabController.index = 6;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    selectTab();
    getAllMangas();
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

  Widget buildSearch() {
    return SearchWidget(
      text: query,
      hintText: 'Manga or Genre',
      onChanged: searchManga,
    );
  }

  void searchManga(String query) {
    final dummyMangas = allmangas.where((manga) {
      final titleLower = manga.title.toLowerCase();
      final genreLower = manga.genre.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.startsWith(searchLower) ||
          genreLower.startsWith(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.dummyMangas = dummyMangas;
    });
  }

  List<Manga> findDailyMangas(String day) {
    List<Manga> daily = [];
    Iterable<Manga> dailydummy = [];

    dailydummy =
        dummyMangas.where((element) => element.weeklyPublishDay == day);

    for (int i = 0; i < dailydummy.length; i++) {
      daily.add(dailydummy.elementAt(i));
    }
    return daily;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFd4fbcc),
        drawer: widget.day == ''
            ? (LoadingPage.isLogined
                ? const NavigationDrawerWidgetUser()
                : const NavigationDrawerWidget())
            : null,
        body: Container(
          color: ColorList.backgroundColor,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverTabHeader(
                  tabcontroller: _tabController,
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  sliver: SliverToBoxAdapter(
                    child: buildSearch(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                TabContent(mangalist: findDailyMangas('Pazartesi')),
                TabContent(mangalist: findDailyMangas('Salı')),
                TabContent(mangalist: findDailyMangas('Çarşamba')),
                TabContent(mangalist: findDailyMangas('Perşembe')),
                TabContent(mangalist: findDailyMangas('Cuma')),
                TabContent(mangalist: findDailyMangas('Cumartesi')),
                TabContent(mangalist: findDailyMangas('Pazar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final List<Manga> mangalist;
  const TabContent({Key? key, required this.mangalist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            sliver: ScreenBody(mangalist: mangalist)),
      ],
    );
  }
}

class SliverTabHeader extends StatelessWidget {
  final TabController tabcontroller;
  const SliverTabHeader({Key? key, required this.tabcontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      bottom: TabBar(
        labelColor: const Color.fromARGB(255, 126, 134, 159),
        labelStyle: TextStyle(
            shadows: ColorList.textShadows,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(
            fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: const Color.fromARGB(255, 219, 92, 105),
        isScrollable: true,
        controller: tabcontroller,
        tabs: const [
          Tab(
            child: Text(
              'Pazartesi',
            ),
          ),
          Tab(
            child: Text('Salı'),
          ),
          Tab(
            child: Text('Çarşamba'),
          ),
          Tab(
            child: Text('Perşembe'),
          ),
          Tab(
            child: Text('Cuma'),
          ),
          Tab(
            child: Text('Cumartesi'),
          ),
          Tab(
            child: Text('Pazar'),
          ),
        ],
      ),
      iconTheme: IconThemeData(
        color: ColorList.iconColor,
        shadows: ColorList.textShadows,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text('Haftalık',
          style: TextStyle(
              fontFamily: 'DynaPuff',
              shadows: ColorList.textShadows,
              color: ColorList.textColor,
              fontSize: 28,
              fontWeight: FontWeight.bold)),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      floating: false, //its
      pinned: false, //for
      snap: false, //floating
    );
  }
}
