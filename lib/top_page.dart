import 'dart:typed_data';
import 'dart:ui';

import 'package:animated_to/animated_to.dart';
import 'package:chooyan_resume/animated_appearing.dart';
import 'package:chooyan_resume/link_text.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:http/http.dart' as http;

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  var _isVisible = false;
  var _animationEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = PrimaryScrollController.of(context);
    return NotificationListener<ScrollStartNotification>(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 32,
                children: [
                  AnimatedAppearing(
                    globalKey: const GlobalObjectKey('about_me'),
                    isVisible: _isVisible,
                    delayIndex: 0,
                    animationEnabled: _animationEnabled,
                    child: const _AboutMe(),
                  ),
                  const SizedBox(height: 16),
                  AnimatedAppearing(
                    globalKey: const GlobalObjectKey('articles'),
                    isVisible: _isVisible,
                    delayIndex: 1,
                    animationEnabled: _animationEnabled,
                    child: const _Articles(),
                  ),
                  const SizedBox(height: 16),
                  AnimatedAppearing(
                    globalKey: const GlobalObjectKey('packages'),
                    isVisible: _isVisible,
                    delayIndex: 2,
                    animationEnabled: _animationEnabled,
                    child: const _Packages(),
                  ),
                  const SizedBox(height: 16),
                  AnimatedAppearing(
                    globalKey: const GlobalObjectKey('socials'),
                    isVisible: _isVisible,
                    delayIndex: 3,
                    animationEnabled: _animationEnabled,
                    child: const _Socials(),
                    onEnd: () {
                      Future.delayed(
                        const Duration(milliseconds: 1000),
                        () {
                          setState(() {
                            _animationEnabled = false;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  AnimatedAppearing(
                    globalKey: const GlobalObjectKey('videos'),
                    isVisible: _isVisible,
                    delayIndex: 4,
                    animationEnabled: _animationEnabled,
                    child: const _Videos(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutMe extends StatelessWidget {
  const _AboutMe();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/me_photo.jpg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'About Chooyan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tsuyoshi Chujo, or Chooyan, is a freelance Flutter developer based in Japan. '
          'With experience in Flutter since 2019, in Mobile App Development since 2011, '
          'he has developed many apps for clients with his knowledge of fundamental mechanisms of the framework. '
          'He is also passionate about sharing his knowledge by writing articles, providing talks at conferences, '
          'as well as contributing to the community by creating packages.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class _Articles extends StatelessWidget {
  const _Articles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Articles',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.blue.shade900.withAlpha(100), // Darker background
            border: Border.all(color: Colors.blue.shade700), // Darker border
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinkText(
                text: 'All I Know about Layout Calculation',
                url:
                    'https://chooyan.hashnode.dev/all-i-know-about-layout-calculation',
              ),
              SizedBox(height: 8),
              LinkText(
                text: 'All I Know about BuildContext',
                url:
                    'https://chooyan.hashnode.dev/all-i-know-about-buildcontext',
              ),
              SizedBox(height: 8),
              LinkText(
                text: 'All I Know about GlobalKey',
                url: 'https://chooyan.hashnode.dev/all-i-know-about-globalkey',
              ),
              SizedBox(height: 8),
              LinkText(
                text: 'Why We Need AsyncValue of Riverpod',
                url:
                    'https://chooyan.hashnode.dev/why-we-need-asyncvalue-of-riverpod',
              ),
              SizedBox(height: 8),
              LinkText(
                text: '...And more',
                url: 'https://chooyan.hashnode.dev/',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Packages extends StatelessWidget {
  const _Packages();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Flutter Packages',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        LinkText(
          text: 'crop_your_image',
          url: 'https://pub.dev/packages/crop_your_image',
        ),
        LinkText(
          text: 'animated_to',
          url: 'https://pub.dev/packages/animated_to',
        ),
        LinkText(
          text: 'draw_your_image',
          url: 'https://pub.dev/packages/draw_your_image',
        ),
        SizedBox(height: 32),
        Text(
          'Try them out!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _PackagesPlayground(),
      ],
    );
  }
}

class _PackagesPlayground extends StatefulWidget {
  const _PackagesPlayground();

  @override
  State<_PackagesPlayground> createState() => _PackagesPlaygroundState();
}

class _PackagesPlaygroundState extends State<_PackagesPlayground> {
  Uint8List? _image;
  Uint8List? _croppedImage;
  List<Uint8List> _doneImages = [];

  final _cropController = CropController();
  final _drawController = DrawController();
  final _textEditingController = TextEditingController();

  var _color = Colors.black;
  var _strokeWidth = 1.0;
  final _canvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _load(String url) async {
    final response = await http.get(Uri.parse(url));
    setState(() {
      _image = response.bodyBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 32,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: _image == null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: _textEditingController,
                            decoration: const InputDecoration(
                              hintText: 'Enter image URL',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: _load,
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: _textEditingController.text.isEmpty
                              ? null
                              : () {
                                  _load(_textEditingController.text);
                                },
                          child: const Text('Start'),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Crop(
                        image: _image!,
                        controller: _cropController,
                        onCropped: (result) {
                          setState(() {
                            _croppedImage = switch (result) {
                              CropSuccess(:final croppedImage) => croppedImage,
                              CropFailure() => null,
                            };
                          });
                        },
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: IconButton(
                          onPressed: () {
                            _cropController.crop();
                          },
                          icon: const Icon(Icons.crop),
                        ),
                      )
                    ],
                  ),
          ),
          if (_croppedImage != null)
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  RepaintBoundary(
                    key: _canvasKey,
                    child: Stack(
                      children: [
                        SizedBox.expand(
                          child: Container(
                            color: Colors.white,
                            child: Image.memory(
                              _croppedImage!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Draw(
                            backgroundColor: Colors.transparent,
                            controller: _drawController,
                            strokeColor: _color,
                            strokeWidth: _strokeWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              _color = Colors.black;
                            });
                          },
                          icon: const Icon(Icons.circle, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _color = Colors.red;
                            });
                          },
                          icon: const Icon(Icons.circle, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _color = Colors.blue;
                            });
                          },
                          icon: const Icon(Icons.circle, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _color = Colors.green;
                            });
                          },
                          icon: const Icon(Icons.circle, color: Colors.green),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Slider(
                            value: _strokeWidth,
                            min: 1,
                            max: 20,
                            onChanged: (value) {
                              setState(() {
                                _strokeWidth = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () async {
                            final image = _canvasKey.currentContext
                                ?.findRenderObject() as RenderRepaintBoundary?;
                            if (image == null) return;
                            final imageBytes =
                                await image.toImage(pixelRatio: 3);
                            final bytes = await imageBytes.toByteData(
                                format: ImageByteFormat.png);
                            setState(() {
                              _doneImages.add(bytes!.buffer.asUint8List());
                            });
                          },
                          icon: const Icon(Icons.done),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (_doneImages.isNotEmpty)
            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    _doneImages.length,
                    (index) {
                      final doneImage = _doneImages[index];
                      const size = 80.0;
                      final child = ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: size,
                          height: size,
                          child: Image.memory(
                            doneImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                      return AnimatedTo(
                        duration: const Duration(milliseconds: 200),
                        globalKey: GlobalObjectKey(doneImage),
                        curve: Curves.easeInOut,
                        child: Draggable<Uint8List>(
                          data: doneImage,
                          feedback: Material(
                            color: Colors.transparent,
                            child: child,
                          ),
                          childWhenDragging: const SizedBox(
                            width: size,
                            height: size,
                          ),
                          child: DragTarget<Uint8List>(
                            builder: (context, _, __) => child,
                            onWillAcceptWithDetails: (details) {
                              if (details.data == doneImage) {
                                return false;
                              }
                              setState(() {
                                final fromIndex =
                                    _doneImages.indexOf(details.data);
                                final toIndex = index;

                                final temp = _doneImages[fromIndex];
                                _doneImages[fromIndex] = _doneImages[toIndex];
                                _doneImages[toIndex] = temp;
                              });
                              return true;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Videos extends StatelessWidget {
  const _Videos();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Videos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _VideoItem(
                videoId: 'zJpnP6gG3T8',
                title: 'Maximizing the Power of the Widget Tree',
              ),
            ),
            SizedBox(width: 60),
            Expanded(
              child: _VideoItem(
                videoId: 'Xitie4TrnPo',
                title: '体験！マクロ時代のFlutterアプリ開発 (Japanese)',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _VideoItem extends StatefulWidget {
  const _VideoItem({
    required this.videoId,
    required this.title,
  });

  final String videoId;
  final String title;
  @override
  State<_VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<_VideoItem> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
        Text(widget.title),
      ],
    );
  }
}

class _Socials extends StatelessWidget {
  const _Socials();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'GitHub / SNS',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo_github.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const LinkText(
                  text: 'chooyan-eng',
                  url: 'https://github.com/chooyan-eng',
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo_x.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const LinkText(
                  text: '@tsuyoshi_chujo',
                  url: 'https://x.com/tsuyoshi_chujo',
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo_x.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const LinkText(
                  text: '@chooyan_i18n (Japanese)',
                  url: 'https://x.com/chooyan_i18n',
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset('assets/logo_linkedin.png',
                      width: 24, height: 24),
                ),
                const SizedBox(width: 8),
                const LinkText(
                  text: 'LinkedIn',
                  url: 'https://www.linkedin.com/in/chooyani18n/',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
