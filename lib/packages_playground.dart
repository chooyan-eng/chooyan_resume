import 'dart:typed_data';
import 'dart:ui';

import 'package:animated_to/animated_to.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class PackagesPlayground extends StatefulWidget {
  const PackagesPlayground({super.key});

  @override
  State<PackagesPlayground> createState() => PackagesPlaygroundState();
}

class PackagesPlaygroundState extends State<PackagesPlayground> {
  Uint8List? _image;
  Uint8List? _croppedImage;
  final List<Uint8List> _doneImages = [];

  final _cropController = CropController();
  final _drawController = DrawController();
  final _textEditingController = TextEditingController();

  var _color = Colors.blue;
  var _strokeWidth = 4.0;
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
    final children = [
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
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('crop your image!'),
                  Expanded(
                    child: Stack(
                      children: [
                        Crop(
                          image: _image!,
                          controller: _cropController,
                          initialRectBuilder:
                              InitialRectBuilder.withSizeAndRatio(
                            size: 0.5,
                          ),
                          onCropped: (result) {
                            setState(() {
                              _croppedImage = switch (result) {
                                CropSuccess(:final croppedImage) =>
                                  croppedImage,
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
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                            ),
                            icon: const Icon(Icons.crop),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
      if (_croppedImage != null)
        AspectRatio(
          aspectRatio: 1,
          child: Column(
            children: [
              const Center(
                child: Text('Draw whatever you want!'),
              ),
              Expanded(
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
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ColoredBox(
                        color: Colors.black.withAlpha(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    spacing: 16,
                                    children: [
                                      const SizedBox(width: 16),
                                      _ColorSelector(
                                        color: Colors.blue,
                                        onTap: () => setState(
                                            () => _color = Colors.blue),
                                        isSelected: _color == Colors.blue,
                                        strokeWidth: _strokeWidth,
                                      ),
                                      _ColorSelector(
                                        color: Colors.red,
                                        onTap: () =>
                                            setState(() => _color = Colors.red),
                                        isSelected: _color == Colors.red,
                                        strokeWidth: _strokeWidth,
                                      ),
                                      _ColorSelector(
                                        color: Colors.green,
                                        onTap: () => setState(
                                            () => _color = Colors.green),
                                        isSelected: _color == Colors.green,
                                        strokeWidth: _strokeWidth,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
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
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                              ),
                              onPressed: () async {
                                _drawController.clear();
                                final image = _canvasKey.currentContext
                                        ?.findRenderObject()
                                    as RenderRepaintBoundary?;
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
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      if (_doneImages.isNotEmpty)
        AspectRatio(
          aspectRatio: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text('Try drag/drop and reordering!'),
              ),
              Wrap(
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
            ],
          ),
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return width > 1000
            ? SizedBox(
                height: 300,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 32,
                  children: children,
                ))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 32,
                    children: children,
                  ),
                ),
              );
      },
    );
  }
}

class _ColorSelector extends StatelessWidget {
  const _ColorSelector({
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.strokeWidth,
  });

  final Color color;
  final VoidCallback onTap;
  final bool isSelected;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: color, width: 2) : null,
        ),
        child: Center(
          child: Container(
            width: strokeWidth,
            height: strokeWidth,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
