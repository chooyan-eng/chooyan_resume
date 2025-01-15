import 'package:chooyan_resume/animated_appearing.dart';
import 'package:chooyan_resume/link_text.dart';
import 'package:chooyan_resume/packages_playground.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
          'About Tsuyoshi Chujo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: const Text(
            'Tsuyoshi Chujo, or Chooyan, is a freelance Flutter developer based in Japan. \n\n'
            'With experience in Flutter since 2019, in Mobile App Development since 2011, '
            'he has developed many apps for clients with his knowledge of fundamental mechanisms of the framework. \n\n '
            'He is also passionate about sharing his knowledge by writing articles, providing talks at conferences, '
            'as well as contributing to the community by creating packages.',
            style: TextStyle(fontSize: 20),
          ),
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
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
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
          ],
        ),
        SizedBox(height: 32),
        Text(
          'Try them out!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        PackagesPlayground(),
      ],
    );
  }
}

class _Videos extends StatelessWidget {
  const _Videos();

  @override
  Widget build(BuildContext context) {
    const video1 = _VideoItem(
      videoId: 'zJpnP6gG3T8',
      title: 'Maximizing the Power of the Widget Tree',
    );
    const video2 = _VideoItem(
      videoId: 'Xitie4TrnPo',
      title: '体験！マクロ時代のFlutterアプリ開発 (Japanese)',
    );
    return Column(
      children: [
        const Text(
          'Videos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return width > 900
                ? const Row(
                    children: [
                      Expanded(child: video1),
                      SizedBox(width: 60),
                      Expanded(child: video2),
                    ],
                  )
                : const Column(
                    children: [
                      video1,
                      SizedBox(height: 60),
                      video2,
                    ],
                  );
          },
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
