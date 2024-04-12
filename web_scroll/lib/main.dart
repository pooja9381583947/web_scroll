// import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();
  int _counter = 0;
  bool showFloatingButton = true;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener((_scrollListener));
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  // void _scrollListener() {
  //   _updateOpacity(_scrollController.offset);
  // }

  bool _showMenu = false;
  // bool _isOpacityOff = false;

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  final TransformationController transformationController = TransformationController();
  ScrollController scrollController = ScrollController();

  // void _updateOpacity(double scrollOffset) {
  //   if (scrollOffset > 567) {
  //     // setState(() {
  //     _isOpacityOff = true;
  //     // });
  //   } else {
  //     // setState(() {
  //     _isOpacityOff = false;
  //     // });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final totalScrollableHeight = screenSize.height * 3;

    return Scaffold(
        body: Stack(children: [
      ScrollTransformView(
        children: [
          ScrollTransformItem(
            builder: ((scrollOffset) {
              return Container(
                color: Colors.blue.shade100,
                child: Row(
                  children: [
                    SizedBox(
                      width: screenSize.width / 7,
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Products',
                            style: TextStyle(color: Colors.black, fontSize: 23),
                          ),
                        ),
                        onTap: _toggleMenu,
                      ),
                    ),
                    const Expanded(
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Branches',
                            style: TextStyle(color: Colors.black, fontSize: 23),
                          ),
                        ),
                        // onTap: _toggleMenu,
                      ),
                    ),
                    const Expanded(
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Partners',
                            style: TextStyle(color: Colors.black, fontSize: 23),
                          ),
                        ),
                        // onTap: _toggleMenu,
                      ),
                    ),
                    const Expanded(
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'About',
                            style: TextStyle(color: Colors.black, fontSize: 23),
                          ),
                        ),
                        // onTap: _toggleMenu,
                      ),
                    )
                  ],
                ),
              );
            }),
            offsetBuilder: (scrollOffset) {
              return Offset(0, 0);
            },
            // scaleBuilder: (scrollOffset) {
            //   return 0.8;
            // },
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              // _updateOpacity(scrollOffset);
              final offScreenPercentage = min(scrollOffset / screenSize.height, 1.0);
              showFloatingButton = scrollOffset > screenSize.height * 2;
              return Container(
                height: screenSize.height - (screenSize.height * 0.2 * offScreenPercentage),
                width: screenSize.width - (screenSize.width * 0.5 * offScreenPercentage),
                color: Colors.black,
                child: Column(
                  children: [
                    Container(
                      width: screenSize.width,
                      height: 100,
                    ),
                    Image.network(
                      height: screenSize.height / 3,
                      width: screenSize.width / 3,
                      fit: BoxFit.cover,
                      'https://picsum.photos/250?image=7', // Valid image URL from a placeholder service
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Error loading image: $error'); // Display error message
                      },
                    ),
                  ],
                ),
              );
            },
            // offsetBuilder: (scrollOffset) {
            //   final offScreenPercentage = min(scrollOffset / screenSize.height, 1.0);
            //   final heightShrinkageamount = (screenSize.height * 0.5 * offScreenPercentage);
            //   final bool isStartMovingImage = scrollOffset >= screenSize.height;
            //   final double onScreenOffset = scrollOffset + heightShrinkageamount / 2;

            //   return Offset(0, !isStartMovingImage ? scrollOffset : onScreenOffset - (scrollOffset - screenSize.height));
            // },
            offsetBuilder: (scrollOffset) {
              final offScreenPercentage = min(scrollOffset / screenSize.height, 1.0);
              final heightShrinkageAmount = (screenSize.height * 0.5 * offScreenPercentage);
              final bool isStartMovingImage = scrollOffset >= screenSize.height;
              final double onScreenOffset = scrollOffset + heightShrinkageAmount / 2;

              if (scrollOffset < totalScrollableHeight - screenSize.height) {
                // Keep the first item pinned
                return Offset(0, !isStartMovingImage ? scrollOffset : onScreenOffset - (scrollOffset - screenSize.height));
              } else {
                // Allow the first item to scroll
                return Offset(0, scrollOffset - (totalScrollableHeight - screenSize.height));
              }
            },
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                height: screenSize.height,
                width: screenSize.width,
                color: Colors.blueGrey,
                child: Column(
                  children: [
                    (!_showMenu)
                        ? Positioned(
                            top: screenSize.height / 2 + 20,
                            left: screenSize.width / 6,
                            child: Text("Zitar\n\n", style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8))),
                          )
                        : const SizedBox(),
                    (!_showMenu)
                        ? Positioned(
                            top: screenSize.height / 2 + screenSize.height * 0.1,
                            left: screenSize.width / 6,
                            child: Text("MetalWare", style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8))),
                          )
                        : const SizedBox(),
                    (!_showMenu)
                        ? Positioned(
                            top: screenSize.height / 2 + screenSize.height * 0.2,
                            left: screenSize.width / 6,
                            child: Text("leading Postion among\nsuppliers of products", style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8))),
                          )
                        : const SizedBox(),
                    // Image.network(
                    //   height: screenSize.height / 2,
                    //   width: screenSize.width / 3,
                    //   fit: BoxFit.cover,
                    //   'https://picsum.photos/250?image=9', // Valid image URL from a placeholder service
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Text('Error loading image: $error'); // Display error message
                    //   },
                    // )
                  ],
                ),
              );
            },
            offsetBuilder: ((scrollOffset) => Offset(0, scrollOffset - screenSize.height / 2)),
          ),
          // ScrollTransformItem(
          //   builder: (scrollOffset) {
          //     return Container(
          //       padding: const EdgeInsets.only(top: 30),
          //       height: screenSize.height,
          //       width: screenSize.width,
          //       color: Colors.amber,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           const SizedBox(
          //             width: 50,
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               const Text(
          //                 "Scroll Up",
          //                 style: TextStyle(color: Colors.white, fontSize: 16),
          //               ),
          //               SizedBox(
          //                 height: screenSize.height / 3,
          //               ),
          //               const Text("Info@\nZitar.ru", style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)),
          //               const SizedBox(height: 100),
          //               const Text(
          //                 "@2023",
          //                 style: TextStyle(color: Colors.white, fontSize: 14),
          //               ),
          //             ],
          //           ),
          //           const Divider(
          //             thickness: 2,
          //             color: Colors.black,
          //           ),
          //           const Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "About",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          //               ),
          //               Text(
          //                 "partners",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          //               ),
          //               Text(
          //                 "Values",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //           const Divider(),
          //           const Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Metalware",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          //               ),
          //               Text(
          //                 "Building materials",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          //               ),
          //               Text(
          //                 "Abrasives",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          //               ),
          //               Text(
          //                 "Quality Control",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
          //               ),
          //               Text(
          //                 "Service Centers",
          //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
          //               ),
          //             ],
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Row(
          //                 children: [
          //                   const Text(
          //                     "Download price",
          //                     style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
          //                   ),
          //                   const SizedBox(
          //                     width: 30,
          //                   ),
          //                   Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
          //                       border: Border.all(color: Colors.white, width: 2.0), // Add a white border
          //                     ),
          //                     child: IconButton(
          //                       icon: const Icon(Icons.download, color: Colors.white),
          //                       onPressed: () {},
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const Padding(
          //                 padding: EdgeInsets.only(bottom: 60),
          //                 child: Text(
          //                   "Developed By Me",
          //                   style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     );
          //   },
          //   // offsetBuilder: ((scrollOffset) => Offset(0, -scrollOffset)),
          // ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                height: screenSize.height,
                width: screenSize.width,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Scroll Up",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: screenSize.height / 3,
                        ),
                        const Text("Info@\nZitar.ru", style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 100),
                        const Text(
                          "@2023",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "partners",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Values",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Metalware",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Building materials",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Abrasives",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Quality Control",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
                        ),
                        Text(
                          "Service Centers",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Download price",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
                                border: Border.all(color: Colors.white, width: 2.0), // Add a white border
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.download, color: Colors.white),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 60),
                          child: Text(
                            "Developed By Me",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            // offsetBuilder: ((scrollOffset) => Offset(0, -scrollOffset)),
          ),
        ],
      ),
      AnimatedPositioned(
        bottom: _showMenu ? 0.0 : screenSize.height,
        left: 0.0,
        right: 0.0,
        top: 0.0,
        duration: const Duration(milliseconds: 200),
        child: Material(
          color: Colors.blue.shade100,
          child: Stack(
            children: [
              // Menu Items
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: screenSize.height / 8,
                          child: ListTile(
                            title: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ZITAR',
                                style: TextStyle(color: Colors.blue, fontSize: 23),
                              ),
                            ),
                            onTap: () {
                              // Handle branch selection
                              _toggleMenu();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Products',
                              style: TextStyle(color: Colors.black, fontSize: 23),
                            ),
                          ),
                          onTap: _toggleMenu,
                        ),
                      ),
                      const Expanded(
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Branches',
                              style: TextStyle(color: Colors.black, fontSize: 23),
                            ),
                          ),
                          // onTap: _toggleMenu,
                        ),
                      ),
                      const Expanded(
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Partners',
                              style: TextStyle(color: Colors.black, fontSize: 23),
                            ),
                          ),
                          // onTap: _toggleMenu,
                        ),
                      ),
                      const Expanded(
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'About',
                              style: TextStyle(color: Colors.black, fontSize: 23),
                            ),
                          ),
                          // onTap: _toggleMenu,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: screenSize.width,
                    height: screenSize.height / 3,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: screenSize.width / 3,
                          child: ListTile(
                            title: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'METALWARE',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                            onTap: () {
                              // Handle MetalWare selection

                              _toggleMenu();
                            },
                          ),
                        ),
                        Container(
                          width: screenSize.width / 3,
                          color: Colors.blue,
                          child: ListTile(
                            title: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ABRASIVES',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                              ),
                            ),
                            onTap: () {
                              // Handle MetalWare selection

                              _toggleMenu();
                            },
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: screenSize.width / 3,
                          child: ListTile(
                            title: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'FOR BUILDING',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                              ),
                            ),
                            onTap: () {
                              // Handle MetalWare selection

                              _toggleMenu();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: _toggleMenu,
                ),
              ),
            ],
          ),
        ),
      ),
      (!_showMenu)
          ? Positioned(
              top: 10,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.grey,
                onPressed: () {
                  _toggleMenu();
                },
              ))
          : const SizedBox(),
      (!_showMenu)
          ? Positioned(
              top: 10,
              left: 10,
              // child:
              // NotificationListener<ScrollNotification>(
              //   onNotification: (scrollNotification) {
              //     final differenceInOffset = (scrollNotification.metrics.pixels) / (scrollNotification.metrics.maxScrollExtent);
              //     final percentage = differenceInOffset * 100;

              //     // model.notifyListeners();
              //     return false;
              //   },
              child: InteractiveViewer(
                transformationController: transformationController,

                // minScale: 4.0,
                // boundaryMargin: EdgeInsets.zero,
                // maxScale: 2.5,

                child: Text("Zitar", style: TextStyle(fontSize: 32, color: Colors.lightBlueAccent.withOpacity(0.8))),
              ),
            )
          // )

          : const SizedBox(),
      // (!_showMenu)
      //     ? Positioned(
      //         top: screenSize.height / 2 + 20,
      //         left: screenSize.width / 6,
      //         child: Text("Zitar\n\n", style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8))),
      //       )
      //     : SizedBox(),
      // (!_showMenu)
      //     ? Positioned(
      //         top: screenSize.height / 2 + screenSize.height * 0.1,
      //         left: screenSize.width / 6,
      //         child: Text("MetalWare", style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8))),
      //       )
      //     : SizedBox(),
      // (!_showMenu)
      //     ? Positioned(
      //         top: screenSize.height / 2 + screenSize.height * 0.2,
      //         left: screenSize.width / 6,
      //         child: Text("leading Postion among\nsuppliers of products", style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8))),
      //       )
      //     : SizedBox(),
      (!_showMenu)
          ? Positioned(
              bottom: 10,
              right: 20,
              child: Container(
                width: screenSize.width * 0.08,
                height: screenSize.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Adjust corner radius as needed
                  color: Colors.blue, // Set your FAB color
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    // Handle button press action
                  },
                  child: const Text("All Materials"),
                  backgroundColor: Colors.blue, // Customize color
                ),
              ),
            )
          : const SizedBox(),
    ]));
  }
}
