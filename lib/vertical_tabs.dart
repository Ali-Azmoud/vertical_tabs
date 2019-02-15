import 'package:flutter/material.dart';

/// A vertical tab widget for flutter
class VerticalTabs extends StatefulWidget {
  final Key key;
  final double tabsWidth;
  final double itemExtent;
  final double indicatorWidth;
  final List<Tab> tabs;
  final List<Widget> contents;
  final TextDirection direction;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color selectedTabBackgroundColor;
  final Color unselectedTabBackgroundColor;
  final Color dividerColor;
  final Duration changePageDuration;
  final Curve changePageCurve;
  final Color tabsShadowColor;
  final double tabsElevation;

  VerticalTabs(
      {this.key,
      @required this.tabs,
      @required this.contents,
      this.tabsWidth = 200,
      this.itemExtent = 50,
      this.indicatorWidth = 3,
      this.direction = TextDirection.ltr,
      this.indicatorColor = Colors.green,
      this.disabledChangePageFromContentView = false,
      this.contentScrollAxis = Axis.horizontal,
      this.selectedTabBackgroundColor = const Color(0x1100ff00),
      this.unselectedTabBackgroundColor = const Color(0xfff8f8f8),
      this.dividerColor = const Color(0xffe5e5e5),
      this.changePageCurve = Curves.easeInOut,
      this.changePageDuration = const Duration(milliseconds: 300),
      this.tabsShadowColor = Colors.black54,
      this.tabsElevation = 2.0})
      : assert(
            tabs != null && contents != null && tabs.length == contents.length),
        super(key: key);

  @override
  _VerticalTabsState createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _changePageByTapView;

  AnimationController animationController;
  Animation<double> animation;
  Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = AlwaysScrollableScrollPhysics();

  @override
  void initState() {
    for (int i = 0; i < widget.tabs.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    _selectTab(0);

    if (widget.disabledChangePageFromContentView == true)
      pageScrollPhysics = NeverScrollableScrollPhysics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    Border border = Border(
//        right: BorderSide(
//            width: 0.5, color: widget.dividerColor));
//    if (widget.direction == TextDirection.rtl) {
//      border = Border(
//          left: BorderSide(
//              width: 0.5, color: widget.dividerColor));
//    }

    return Directionality(
      textDirection: widget.direction,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  child: Container(
                    width: widget.tabsWidth,
                    child: ListView.builder(
                      itemExtent: widget.itemExtent,
                      itemCount: widget.tabs.length,
                      itemBuilder: (context, index) {
                        Tab tab = widget.tabs[index];

                        Alignment alignment = Alignment.centerLeft;
                        if (widget.direction == TextDirection.rtl) {
                          alignment = Alignment.centerRight;
                        }

                        Widget child;
                        if (tab.child != null) {
                          child = tab.child;
                        } else {
                          child = Row(
                            children: <Widget>[
                              (tab.icon != null)
                                  ? Row(
                                      children: <Widget>[
                                        tab.icon,
                                        SizedBox(
                                          width: 5,
                                        )
                                      ],
                                    )
                                  : Container(),
                              (tab.text != null) ? Text(tab.text) : Container(),
                            ],
                          );
                        }

                        Color itemBGColor = widget.unselectedTabBackgroundColor;
                        if (_selectedIndex == index)
                          itemBGColor = widget.selectedTabBackgroundColor;

                        return GestureDetector(
                          onTap: () {
                            _changePageByTapView = true;
                            setState(() {
                              _selectTab(index);
                            });

                            pageController.animateToPage(index,
                                duration: widget.changePageDuration,
                                curve: widget.changePageCurve);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: itemBGColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ScaleTransition(
                                  child: Container(
                                    width: widget.indicatorWidth,
                                    height: widget.itemExtent,
                                    color: widget.indicatorColor,
                                  ),
                                  scale: Tween(begin: 0.0, end: 1.0).animate(
                                    new CurvedAnimation(
                                      parent: animationControllers[index],
                                      curve: Curves.elasticOut,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: alignment,
                                    padding: EdgeInsets.all(5),
                                    child: child,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  elevation: widget.tabsElevation,
                  shadowColor: widget.tabsShadowColor,
                  shape: BeveledRectangleBorder(),
                ),
                Expanded(
                  child: PageView.builder(
                    scrollDirection: widget.contentScrollAxis,
                    physics: pageScrollPhysics,
                    onPageChanged: (index) {
                      if (_changePageByTapView == false ||
                          _changePageByTapView == null) {
                        _selectTab(index);
                      }
                      if (_selectedIndex == index) {
                        _changePageByTapView = null;
                      }
                      setState(() {});
                    },
                    controller: pageController,

                    // the number of pages
                    itemCount: widget.contents.length,

                    // building pages
                    itemBuilder: (BuildContext context, int index) {
                      return widget.contents[index];
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();
  }
}
