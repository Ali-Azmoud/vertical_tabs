import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: Scaffold(
        body: SafeArea(

          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: VerticalTabs(
                    tabsWidth: 150,
                    tabs: <VTab>[
                      VTab(Tab(child: Text('Flutter'), icon: Icon(Icons.phone))),
                      VTab(Tab(child: Text('Dart'))),
                      VTab(Tab(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 1),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.favorite),
                              SizedBox(width: 25),
                              Text('Javascript'),
                            ],
                          ),
                        ),
                      )),
                      VTab(Tab(child: Text('NodeJS'))),
                      VTab(Tab(child: Text('PHP'))),
                      VTab(Tab(child: Text('HTML 5'))),
                      VTab(Tab(child: Text('CSS 3'))),
                    ],
                    contents: <Widget>[
                      tabsContent('Flutter', 'Change page by scrolling content is disabled in settings. Changing contents pages is only available via tapping on tabs'),
                      tabsContent('Dart'),
                      tabsContent('Javascript'),
                      tabsContent('NodeJS'),
                      Container(
                          color: Colors.black12,
                          child: ListView.builder(
                              itemCount: 10,
                              itemExtent: 100,
                              itemBuilder: (context, index){
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.white30,
                                );
                              })
                      ),
                      tabsContent('HTML 5'),
                      Container(
                          color: Colors.black12,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemExtent: 100,
                              itemBuilder: (context, index){
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.white30,
                                );
                              })
                      ),
                    ],
                  ),



                ),
              ),

            ],
          ),



          /*child: Column(
            children: <Widget>[
              Container(
                height: 300,
                child: VerticalTabs(
                  tabsWidth: 150,
                  direction: TextDirection.ltr,
                  contentScrollAxis: Axis.vertical,
                  changePageDuration: Duration(milliseconds: 500),
                  tabs: <Tab>[
                    Tab(child: Text('Flutter'), icon: Icon(Icons.phone)),
                    Tab(child: Text('Dart')),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 1),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.favorite),
                            SizedBox(width: 25),
                            Text('Javascript'),
                          ],
                        ),
                      ),
                    ),
                    Tab(child: Text('NodeJS')),
                    Tab(child: Text('PHP')),
                  ],
                  contents: <Widget>[
                    tabsContent('Flutter', 'You can change page by scrolling content vertically'),
                    tabsContent('Dart'),
                    tabsContent('Javascript'),
                    tabsContent('NodeJS'),
                    Container(
                        color: Colors.black12,
                        child: ListView.builder(
                            itemCount: 10,
                            itemExtent: 100,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Container(
                                margin: EdgeInsets.all(10),
                                color: Colors.white30,
                              );
                            })
                    ),
                  ],
                ),
              ),
              Divider(height: 20, color: Colors.black87,),
              Container(
                height: 300,
                child: VerticalTabs(
                  tabsWidth: 150,
                  direction: TextDirection.ltr,
                  changePageDuration: Duration(milliseconds: 500),
                  tabs: <Tab>[
                    Tab(child: Text('Flutter'), icon: Icon(Icons.phone)),
                    Tab(child: Text('Dart')),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 1),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.favorite),
                            SizedBox(width: 25),
                            Text('Javascript'),
                          ],
                        ),
                      ),
                    ),
                    Tab(child: Text('NodeJS')),
                    Tab(child: Text('PHP')),
                  ],
                  contents: <Widget>[
                    tabsContent('Flutter', 'You can change page by scrolling content horizontally'),
                    tabsContent('Dart'),
                    tabsContent('Javascript'),
                    tabsContent('NodeJS'),
                    Container(
                        color: Colors.black12,
                        child: ListView.builder(
                            itemCount: 10,
                            itemExtent: 100,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index){
                              return Container(
                                margin: EdgeInsets.all(10),
                                color: Colors.white30,
                              );
                            })
                    ),
                  ],
                ),
              ),
            ],
          ),*/
        ),
      ),
    );
  }

  Widget tabsContent(String caption, [ String description = '' ] ) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(fontSize: 25),
          ),
          Divider(height: 20, color: Colors.black45,),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}