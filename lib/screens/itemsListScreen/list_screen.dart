import 'dart:developer';

import 'package:coffee/main.dart';
import 'package:coffee/models/burger.dart';
import 'package:coffee/models/item.dart';
import 'package:coffee/screens/detailsScreen/details_screen.dart';
import 'package:flutter/material.dart';

class ItemPageView extends StatefulWidget {
  final List<Item> itemList;

  ItemPageView({required this.itemList});

  @override
  State<ItemPageView> createState() => _ItemPageViewState();
}

class _ItemPageViewState extends State<ItemPageView> {
  PageController? controller;
  PageController? nameController;
  PageController? priceController;
  double currentPosition = initialPage.toDouble();
  int currentPage = initialPage;
  double titleCurrentPage = initialPage.toDouble();
  Item? coffee;
  final ValueNotifier<double> _doubleNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier<double> _titleCurrentPagedoubleNotifier =
      ValueNotifier<double>(0.0);

  void pageControllerListner() {
    currentPosition = controller!.page ?? 0.0;
    _doubleNotifier.value = currentPosition;
  }

  void titleControllerListner() {
    titleCurrentPage = nameController!.page ?? 0.0;
    _titleCurrentPagedoubleNotifier.value = titleCurrentPage;
  }

  @override
  void initState() {
    coffee = widget.itemList[initialPage];
    controller = PageController(
        viewportFraction: 0.35, keepPage: true, initialPage: initialPage);
    controller!.addListener(pageControllerListner);

    nameController = PageController(
      viewportFraction: 1,
      initialPage: initialPage,
      keepPage: true,
    );
    nameController!.addListener(titleControllerListner);
    priceController = PageController(
      viewportFraction: 1,
      initialPage: initialPage,
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.removeListener(pageControllerListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Column(
        children: [
          buildHeader(),
          buildItemsBody(size),
        ],
      ),
    );
  }

  Expanded buildItemsBody(Size size) {
    return Expanded(
      child: ValueListenableBuilder<double>(
          valueListenable: _doubleNotifier,
          builder: (context, value, child) {
            return Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Hero(
                    tag: "bgColor",
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                coffee!.color.withOpacity(0.3), // Shadow color
                            spreadRadius: 200, // Spread radius
                            blurRadius: 3000,
                            offset: Offset(0, 3), // Offset (x, y)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                PageView.builder(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.itemList.length + 1,
                  clipBehavior: Clip.antiAlias,
                  onPageChanged: (v) {
                    if (v >= widget.itemList.length) return;
                    log("loo $v");
                    currentPage = v;
                    coffee = widget.itemList[v];

                    nameController!
                      ..animateToPage(v,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    // nameController!.animateToPage(v,
                    //     duration: Duration(seconds: 1), curve: Curves.ease);
                    priceController!.animateToPage(v,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox.shrink();
                    }

                    final value = (-0.6 * (currentPosition - index + 1) + 2)
                        .clamp(0.0, 2.0);

                    Item _coffee = widget.itemList[index - 1];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsScreen(item: _coffee);
                        }));
                        await Future.delayed(Duration(milliseconds: 500));
                        nameController!.animateToPage(currentPage,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                        // nameController!.animateToPage(v,
                        //     duration: Duration(seconds: 1), curve: Curves.ease);
                        priceController!.animateToPage(currentPage,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Transform(
                        alignment: Alignment.topRight,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0001)
                          ..translate(size.width / 5 * value,
                              (size.height / 3 * (1 - value)).toDouble())
                          ..scale((_coffee is Burger ? -0.2 : 0.0) + value),
                        child: Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: Hero(
                            tag: _coffee.name,
                            child: Image.asset(
                              _coffee.imagePath,
                             
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
    );
  }

  Hero buildHeader() {
    return Hero(
      tag: "header",
      child: SizedBox(
        height: 120,
        child: ValueListenableBuilder<double>(
            valueListenable: _titleCurrentPagedoubleNotifier,
            builder: (context, value, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildItemTitle(),
                  buildItemPrice(),
                ],
              );
            }),
      ),
    );
  }

  Expanded buildItemPrice() {
    return Expanded(
      flex: 2,
      child: PageView.builder(
        controller: priceController,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.itemList.length,
        itemBuilder: (context, index) {
          Item _coffee = widget.itemList[index];
          final value = (1 - (index - titleCurrentPage)).clamp(0.0, 1.0);

          return Container(
            height: 120,
            alignment: Alignment.center,
            child: AnimatedScale(
              duration: Duration(milliseconds: 300),
              scale: (1.0 - (currentPosition - index).abs()).clamp(0.0, 1.0),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity:
                    (1.0 - (currentPosition - index).abs()).clamp(0.0, 1.0),
                child: Text(
                  "₹ ${_coffee.price.toStringAsFixed(2)}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded buildItemTitle() {
    return Expanded(
      flex: 4,
      child: PageView.builder(
        controller: nameController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.itemList.length,
        itemBuilder: (context, index) {
          Item _coffee = widget.itemList[index];
          final value = (1 - (index - titleCurrentPage)).clamp(0.0, 1.0);

          return Transform.scale(
            scale: value,
            child: Opacity(
              opacity: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _coffee.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _coffee.subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 10,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
