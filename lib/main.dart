// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:parcel/utils/app_colors.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpansionTile Collapse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          color: Colors.green,
          child: const Center(
            child: Text('amr', style: TextStyle(color: Colors.black),),
          ),
        ),
      ),
    );
  }
}



class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  TabController? _tabTripsController;
  ValueNotifier<int> selectedTabNotifier = ValueNotifier<int>(0);

  final List<Widget> _tripTabs = <Widget>[
    const Tab(text: 'UpComing'),
    const Tab(text: 'Post'),
  ];

  @override
  void dispose() {
    _tabTripsController!.removeListener(_handleTabSelection);
    _tabTripsController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabTripsController =
        TabController(length: 2, vsync: this, initialIndex: 0);
    _tabTripsController!.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    if (_tabTripsController!.indexIsChanging) {
      selectedTabNotifier.value = _tabTripsController!.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: .6,
                        blurRadius: 6,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    color: Colors.white),
                child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green),
                    controller: _tabTripsController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    indicatorColor: Colors.red,
                    unselectedLabelColor: Colors.green.withOpacity(.8),
                    // labelStyle: mediumTextStyle.copyWith(fontSize: 15.sp),
                    tabs: _tripTabs),
              ),
              SizedBox(height: 32),
              ValueListenableBuilder<int>(
                valueListenable: selectedTabNotifier,
                builder: (_, int selected, __) {
                  return Flexible(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: selected == 0
                            ? Stack(
                          children: [
                            // item container
                            Container(
                              width: size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                            ),

                            // date widget => 03 Apr
                            Positioned(
                              top: 0,
                              right: 30,
                              child: Container(
                                width: 30,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(7),
                                    bottomRight: Radius.circular(7),
                                  ),
                                ),
                                child: Column(
                                  children: const [
                                    Text(
                                      '03',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'Apr',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                            : const Text('post'),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


