import 'package:coffee/models/burger.dart';
import 'package:coffee/models/coffee.dart';
import 'package:coffee/models/item.dart';
import 'package:flutter/material.dart';

late AnimationController cartAnimationcontroller;

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.item});

  final Item item;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

enum Scale { small, medium, large }

class _DetailsScreenState extends State<DetailsScreen> {
  double scale = 0.0;
  double itemScale = 0.0;
  Scale itemScaleEnum = Scale.medium;
  int _toggleValue = 0;
  int count = 0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 300)).then((value) => setState(() {
            scale = 1.0;
          }));
    });
    setItemScale(itemScaleEnum);
    super.initState();
  }

  setItemScale(Scale size) {
    itemScaleEnum = size;

    switch (size) {
      case Scale.large:
        setState(() {
          itemScale = 1;
        });

        break;
      case Scale.medium:
        setState(() {
          itemScale = 0.7;
        });

        break;
      case Scale.small:
        setState(() {
          itemScale = 0.5;
        });

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Stack(
        children: [
          Hero(
            tag: "bgColor",
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: widget.item.color.withOpacity(0.3), // Shadow color
                    spreadRadius: 200, // Spread radius
                    blurRadius: 3000, // Blur radius
                    offset: Offset(0, 3), // Offset (x, y)
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: widget.item.name,
                child: Stack(
                  children: [
                      Positioned(
                        top: 00,
                        left: 0,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: widget.item.color,
                                      fontSize: 80, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.item.subTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      color: widget.item.color,
                                    fontSize: 60,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    AnimatedScale(
                      scale: itemScale,
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 500),
                      child: Image.asset(
                        widget.item.imagePath,
                        height: size.height * 0.5,
                      ),
                    ),
                    AnimatedAdd(
                      itemScale: itemScale,
                      widget: widget,
                      size: size,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedScale(
                    scale: itemScaleEnum == Scale.small ? 1.1 : scale,
                    duration: Duration(milliseconds: 500),
                    child: GestureDetector(
                      onTap: () {
                        setItemScale(Scale.small);
                        //  cartAnimationcontroller..reset()..forward();
                      },
                      child: CircleAvatar(
                        backgroundColor:  itemScaleEnum == Scale.small ? widget.item.color : Color.fromARGB(64, 168, 167, 167) ,
                        maxRadius: 30,
                        child: Text(
                          "S",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                
                                  fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  AnimatedScale(
                    scale: itemScaleEnum == Scale.medium ? 1.1 : scale,
                    duration: Duration(milliseconds: 500),
                    child: GestureDetector(
                      onTap: () {
                        setItemScale(Scale.medium);
                        //cartAnimationcontroller..reset()..forward();
                      },
                      child: CircleAvatar(
                        maxRadius: 30,
                                               backgroundColor:  itemScaleEnum == Scale.medium ? widget.item.color : Color.fromARGB(64, 168, 167, 167) ,
                        child: Text(
                          "M",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  AnimatedScale(
                    scale: itemScaleEnum == Scale.large ? 1.1 : scale,
                    duration: Duration(milliseconds: 500),
                    child: GestureDetector(
                      onTap: () {
                        setItemScale(Scale.large);
                        //  cartAnimationcontroller..reset()..forward();
                      },
                      child: CircleAvatar(
                          maxRadius: 30,
                                                  backgroundColor:  itemScaleEnum == Scale.large ? widget.item.color : Color.fromARGB(64, 168, 167, 167) ,
                          child: Text(
                            "L",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
              Hero(
                tag: "header",
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.item.subTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 10,
                                ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "₹ ${widget.item.price.toStringAsFixed(2)}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     if(widget.item is Burger)
                     Customizebutton(size: size, widget: widget),
                    if(widget.item is Coffee)
                    AnimatedToggle(
                      values: ['Hot', 'Cold'],
                      onToggleCallback: (value) {
                        setState(() {
                          _toggleValue = value;
                        });
                      },
                      buttonColor: _toggleValue == 0
                          ? Color.fromARGB(255, 227, 137, 95)
                          : const Color(0xFFD4E9E7),
                      backgroundColor:Color.fromARGB(64, 168, 167, 167) ,
                      textColor: const Color(0xFFFFFFFF),
                    ),
                    AnimatedScale(
                      scale: scale,
                      duration: Duration(milliseconds: 500),
                      child: ScaleEffectWidget(
                        onTap: () {
                          cartAnimationcontroller
                            ..reset()
                            ..forward();
                          count++;
                          setState(() {
                            
                          });
                        },
                        child: CircleAvatar(
                                                    backgroundColor:Color.fromARGB(64, 168, 167, 167) ,
                          maxRadius: 30,
                          child: Icon(Icons.add, color: widget.item.color,),
                        ),
                      ),
                    ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(count.toString(),style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: widget.item.color,
                                    fontSize: 30,
                                  ),),
                 ),
                    AnimatedScale(
                      scale: scale,
                      duration: Duration(milliseconds: 500),
                      child: ScaleEffectWidget(
                        onTap: () {
                          if(count>0){
                               count--;
                                setState(() {
                            
                          });
                          }
                          print('Widget tapped!');
                        },
                        child: CircleAvatar(
                             backgroundColor:Color.fromARGB(64, 168, 167, 167) ,
                          maxRadius: 30,
                          child: Icon(Icons.remove, color: widget.item.color,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Customizebutton extends StatelessWidget {
  const Customizebutton({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: size.width * 0.4,
                  height: size.width * 0.13,
                  decoration: ShapeDecoration(
                    color: Color.fromARGB(64, 168, 167, 167) ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(
     "Customize",
       style: TextStyle(
         fontSize: size.width * 0.045,
         fontWeight: FontWeight.bold,
         color: widget.item.color,
       ),
     ),
                  ),
                );
  }
}

class AnimatedAdd extends StatefulWidget {
  AnimatedAdd({
    super.key,
    required this.itemScale,
    required this.widget,
    required this.size,
  });

  final double itemScale;
  final DetailsScreen widget;
  final Size size;

  @override
  State<AnimatedAdd> createState() => _AnimatedAddState();
}

class _AnimatedAddState extends State<AnimatedAdd>
    with TickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    cartAnimationcontroller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    cartAnimationcontroller.addListener(() {
      if (cartAnimationcontroller.isCompleted) {
        cartAnimationcontroller.reset();
      }
    });
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: cartAnimationcontroller, curve: Curves.decelerate));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.itemScale,
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 500),
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..translate(
                    (widget.size.width * 0.8) * cartAnimationcontroller.value,
                    -(widget.size.height * 0.5) * cartAnimationcontroller.value)
                ..scale(_animation.value),
              child: Opacity(
                opacity: 1.0,
                child: Image.asset(
                  widget.widget.item.imagePath,
                  height: widget.size.height * 0.5,
                ),
              ),
            );
          }),
    );
  }
}

//  transform: Matrix4.identity()
//             ..setEntry(3, 2, 0.001)
// ..translate(
//     (widget.size.width * 0.8) *
//         (widget.itemScale - _animation.value),
//     -(widget.size.height * 0.5) *
//        (widget.itemScale - _animation.value)),
// ..scale(_animation.value),
class ScaleEffectWidget extends StatefulWidget {
  final Function onTap;
  final Widget child;

  const ScaleEffectWidget({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  _ScaleEffectWidgetState createState() => _ScaleEffectWidgetState();
}

class _ScaleEffectWidgetState extends State<ScaleEffectWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      onTap: widget.onTap as void Function()?,
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition;
              var index = 0;
              if (!initialPosition) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.13,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
            top: 0,
            bottom: 0,
            left: initialPosition ? 0 : size.width * 0.2,
            right: !initialPosition ? 0 : size.width * 0.2,
            child: Container(
              width: size.width * 0.2,
              height: size.width * 0.13,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.1),
                ),
              ),
              child: Text(
                initialPosition ? widget.values[0] : widget.values[1],
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
