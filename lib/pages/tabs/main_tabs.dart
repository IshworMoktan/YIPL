import 'package:hexcolor/hexcolor.dart';
import 'package:yipl/pages/tabs/post_tabs.dart';
import 'package:yipl/pages/tabs/user_tabs.dart';
import 'package:flutter/material.dart';

class MainTabbedPage extends StatelessWidget {
  const MainTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      HexColor('#e14c1f').withOpacity(0.1),
                      Colors.white.withOpacity(0.2)
                    ],
                    stops: [0, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                // centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/images/YI_Logomark.png',
                        )),
                  ],
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: Colors.orange.withOpacity(0.2)),
                  tabs: const [
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.people), Text('  Users')],
                        ),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.message), Text('  Posts')],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [UserTabbedPage(), PostTabbedPage()],
          ),
        ),
      ),
    );
  }
}
