import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:provider/provider.dart';
import 'src/nav_button.dart';
import 'src/nav_custom_painter.dart';

class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Color color;
  final Color buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int> onTap;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final List<Text> itemTitles;
  final double titleMarginBottom;

  CurvedNavigationBar({
    Key key,
    @required this.items,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.onTap,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 75.0,
    this.itemTitles,
    this.titleMarginBottom,
  })  : assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  double _startingPos;
  int _endingIndex = 0;
  double _pos;
  double _buttonHide = 0;
  Widget _icon;
  AnimationController _animationController;
  int _length;

  @override
  void initState() {
    super.initState();
    changeButton();
  }

  void changeButton() {
    _icon = widget.items[widget.index];
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }
  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: -40 - (75.0 - widget.height),
            left: Directionality.of(context) == TextDirection.rtl
                ? null
                : _pos * size.width,
            right: Directionality.of(context) == TextDirection.rtl
                ? _pos * size.width
                : null,
            width: size.width / _length,
            child: Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  -(1 - _buttonHide) * 80,
                ),
                child: Material(
                  color: widget.buttonBackgroundColor ?? widget.color,
                  type: MaterialType.circle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _icon,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 - (75.0 - widget.height),
            child: CustomPaint(
              painter: NavCustomPainter(
                  _pos, _length, widget.color, Directionality.of(context)),
              child: Container(
                height: 75.0,
              ),
            ),
          ),
          Positioned(
            left: -10,
            right: -10,
            bottom: 5 - (75.0 - widget.height),
            child: SizedBox(
                height: 60.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _buttonTap(0);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NavButton(
                                onTap: _buttonTap,
                                position: _pos,
                                length: _length,
                                index: widget.items.indexOf(widget.items[0]),
                                child: Center(child: widget.items[0]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widget.titleMarginBottom),
                                child: widget.itemTitles[0],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                       child: InkWell(
                          onTap: () {
                            _buttonTap(1);
                          },
                                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NavButton(
                                onTap: _buttonTap,
                                position: _pos,
                                length: _length,
                                index: widget.items.indexOf(widget.items[1]),
                                child: Center(child: widget.items[1]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widget.titleMarginBottom),
                                child: widget.itemTitles[1],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _buttonTap(2);
                          },
                                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NavButton(
                                onTap: _buttonTap,
                                position: _pos,
                                length: _length,
                                index: widget.items.indexOf(widget.items[2]),
                                child: Center(child: widget.items[2]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widget.titleMarginBottom),
                                child: widget.itemTitles[2],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                     child: InkWell(
                          onTap: () {
                            _buttonTap(3);
                          },
                                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NavButton(
                                onTap: _buttonTap,
                                position: _pos,
                                length: _length,
                                index: widget.items.indexOf(widget.items[3]),
                                child: Center(child: widget.items[3]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widget.titleMarginBottom),
                                child: widget.itemTitles[3],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                         child: InkWell(
                          onTap: () {
                            _buttonTap(4);
                          },
                                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NavButton(
                                onTap: _buttonTap,
                                position: _pos,
                                length: _length,
                                index: widget.items.indexOf(widget.items[4]),
                                child: Center(child: widget.items[4]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widget.titleMarginBottom),
                                child: widget.itemTitles[4],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: widget.items.map((item) {
                  //         int index = widget.items.indexOf(item);
                  //         return Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             NavButton(
                  //               onTap: _buttonTap,
                  //               position: _pos,
                  //               length: _length,
                  //               index: widget.items.indexOf(item),
                  //               child: Center(child: item),
                  //             ),
                  //             Padding(
                  //               padding: EdgeInsets.only(
                  //                   bottom: widget.titleMarginBottom),
                  //               child: widget.itemTitles[index],
                  //             ),
                  //           ],
                  //         );
                  //       }).toList()),
                )),
          ),
        ],
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (index == 2 || index == 3) {
      var auth = Provider.of<Auth>(context, listen: false);
      if (auth.token == null) {
        Navigator.pushNamed(context, "/login");
        return null;
      }
    }

    if (widget.onTap != null) {
      widget.onTap(index);
    }

    double newPosition = index / _length;

    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}
