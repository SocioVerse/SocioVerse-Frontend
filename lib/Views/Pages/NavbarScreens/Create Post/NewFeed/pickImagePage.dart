import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/postEditPage.dart';
import 'package:socioverse/Views/Widgets/Global/loadingOverlay.dart';
import 'package:socioverse/helpers/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key});

  @override
  State<PickImagePage> createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  List<int> selectedIndex = [];
  int imageCount = 0;
  int? singleImageIndex;
  bool multiSelect = false;
  List<AssetEntity> assets = [];
  late AssetEntity selectedAsset;
  int currentGrid = 30;
  bool isStatus = false;
  bool? assetType;
  final ScrollController _scrollController = ScrollController();
  Future<void> _fetchAssets() async {
    assets = await PhotoManager.getAssetListRange(
      start: 0,
      end: currentGrid,
      type: RequestType.image,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializePhotoManager();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentGrid += 30;
      await _fetchAssets();
    }
  }

  Future<void> _initializePhotoManager() async {
    final PermissionState state = await PhotoManager.requestPermissionExtend();
    if (state.isAuth) {
      await _fetchAssets();
      selectedAsset = assets[0];
      singleImageIndex = 0;
      setState(() {
        isStatus = true;
      });
    }
  }

  Icon selectedIcon() {
    return Icon(
      Icons.check_circle,
      color: Theme.of(context).colorScheme.primary,
      size: 25,
    );
  }

  Widget countPickedImages(int cnt) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        cnt.toString(),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Theme.of(context).colorScheme.onPrimary),
      )),
    );
  }

  Widget _buildAssetWidget(File bytes) {
    final assetType = selectedAsset.type;

    if (assetType == AssetType.image) {
      return PhotoView(
        imageProvider: FileImage(bytes),
      );
    } else if (assetType == AssetType.video) {
      return VideoPlayerWidget(
        file: bytes,
      );
    } else {
      // Handle other asset types if needed
      return const Text('Unsupported asset type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "New Post",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                List<File> files = [];
                if (selectedIndex.isNotEmpty) {
                  // Use Future.wait to wait for all futures to complete
                  await Future.wait(
                    List<Future>.generate(selectedIndex.length, (int i) async {
                      log(i.toString());
                      final value = await assets[selectedIndex[i]].file;
                      if (value != null) {
                        files.add(value);
                      }
                    }),
                  );

                  print(files.length.toString());
                } else {
                  File? value = await selectedAsset.file;
                  log(value!.path);
                  if (value != null) {
                    files.add(value);
                  }
                }
                ImagePickerFunctionsHelper()
                    .cropMultipleImages(context, files, false)
                    .then((value) {
                  if (value != null) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => LoadingOverlayAlt(
                                child: PostEditPage(
                                  images: value,
                                ),
                              )),
                    );
                  }
                });
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              )),
        ],
      ),
      body: isStatus == false
          ? Center(
              child: SpinKitRing(
                color: Theme.of(context).colorScheme.tertiary,
                lineWidth: 1,
                duration: const Duration(seconds: 1),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  FutureBuilder<File?>(
                    future: selectedAsset.file,
                    builder:
                        (BuildContext context, AsyncSnapshot<File?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: SizedBox(
                                width: MyApp.width!,
                                height: MyApp.width! - 20,
                                child: const Center(
                                    child: CircularProgressIndicator())));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const Text('No data available');
                      }

                      final bytes = snapshot.data!;
                      log(bytes.path);

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MyApp.width!,
                          height: MyApp.width! - 20,
                          child: _buildAssetWidget(bytes),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          items: [
                            DropdownMenuItem(
                              value: "Gallery",
                              child: Text(
                                "Gallery",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            ),
                          ],
                          value: "Gallery",
                          underline: Container(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          onChanged: (value) {},
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Ionicons.camera,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: StatefulBuilder(builder: (context, innerState) {
                      return GridView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: assets.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<Uint8List>(
                              future: assets[index]
                                  .thumbnailData
                                  .then((value) => value!),
                              builder: (_, snapshot) {
                                final bytes = snapshot.data;
                                if (bytes == null) {
                                  return Positioned.fill(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Shimmer.fromColors(
                                          baseColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    if (multiSelect == true) {
                                      if (selectedIndex.contains(index)) {
                                        selectedIndex.remove(index);
                                        imageCount = selectedIndex.length;
                                        if (imageCount == 0) {
                                          multiSelect = false;
                                        }
                                      } else {
                                        selectedIndex.add(index);
                                        imageCount = selectedIndex.length;
                                      }
                                      if (imageCount > 0) {
                                        selectedAsset =
                                            assets[selectedIndex[0]];
                                      }
                                      setState(() {});
                                    } else {
                                      if (singleImageIndex == null) {
                                        singleImageIndex = index;
                                      } else {
                                        singleImageIndex = index;
                                      }
                                      selectedAsset = assets[index];
                                      setState(() {});
                                    }
                                  },
                                  onLongPress: () {
                                    if (multiSelect == true) {
                                      if (selectedIndex.contains(index)) {
                                        selectedIndex.remove(index);
                                        imageCount = selectedIndex.length;
                                        if (imageCount == 0) {
                                          setState(() {
                                            multiSelect = false;
                                          });
                                        }
                                      } else {
                                        selectedIndex.add(index);
                                        imageCount = selectedIndex.length;
                                      }

                                      selectedAsset = assets[selectedIndex[0]];
                                      setState(() {});
                                    } else {
                                      setState(() {
                                        multiSelect = true;
                                        selectedIndex.add(index);
                                        selectedAsset =
                                            assets[selectedIndex[0]];
                                        imageCount = selectedIndex.length;
                                      });
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      // Wrap the image in a Positioned.fill to fill the space
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(bytes,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      // Display a Play icon if the asset is a video
                                      if (assets[index].type == AssetType.video)
                                        const Center(
                                          child: Icon(
                                            Ionicons.play,
                                            color: Colors.white,
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: multiSelect == true
                                                ? selectedIndex.contains(index)
                                                    ? countPickedImages(
                                                        selectedIndex.indexOf(
                                                                index) +
                                                            1)
                                                    : Container()
                                                : singleImageIndex == index
                                                    ? selectedIcon()
                                                    : Container()),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          });
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.file});
  final File file;
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    File? videoFile = await widget.file;
    log(videoFile.path);
    if (videoFile != null) {
      _controller = VideoPlayerController.file(videoFile)
        ..play()
        // Play the video again when it ends
        ..setLooping(true)
        // initialize the controller and notify UI when done
        ..initialize().then((_) => setState(() {
              _isControllerInitialized = true;
            }));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isControllerInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: VideoPlayer(_controller),
          )
        : const CircularProgressIndicator();
  }
}
