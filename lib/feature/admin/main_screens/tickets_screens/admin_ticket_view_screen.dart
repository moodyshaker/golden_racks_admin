import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';

import 'package:golden_racks_admin/core/models/admin_tickets_model.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:path/path.dart' as pathFile;
import 'package:video_player/video_player.dart';

class AdminTicketViewScreen extends StatefulWidget {
  final VisitDetails visitDetails;
  final String ticketNumber;
  final String companyName;
  final String technicalName;

  AdminTicketViewScreen({
    required this.visitDetails,
    required this.ticketNumber,
    required this.companyName,
    required this.technicalName,
  });

  @override
  State<AdminTicketViewScreen> createState() => _AdminTicketViewScreenState();
}

class _AdminTicketViewScreenState extends State<AdminTicketViewScreen> {
  late AudioPlayer player;
  double _currentPosition = 0.0;
  Duration _duration = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    player.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    player.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position.inMilliseconds.toDouble();
      });
    });

    player.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        _currentPosition = 0.0;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudio(String audioPath) async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(UrlSource(audioPath));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void seekTo(double milliseconds) {
    Duration newPosition = Duration(milliseconds: milliseconds.round());
    player.seek(newPosition);
  }

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: true,
        isHome: true,
        hasNavBar: true,
        title1: '${Preferences.instance.getUserFullName}',
        title2: 'عرض تذكرة رقم ${widget.ticketNumber}',
        title3: '',
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: gray_20,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(width: 1.0, color: kInactiveColor),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 19.h),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: MainText(
                            text: 'شركة ${widget.companyName}',
                            font: 15.sp,
                            weight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Flexible(
                          child: MainText(
                            text: 'رقم التذكرة ${widget.ticketNumber}',
                            font: 15.sp,
                            weight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 20.h,
                      color: gray_60,
                      thickness: 0.5,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: MainText(
                        text: '${widget.visitDetails.problemName}',
                        font: 16.sp,
                        weight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          MainText(
                            text: 'الفني',
                            font: 12.sp,
                            weight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20.w),
                          MainText(
                            text: widget.technicalName == ''
                                ? 'لم يتم تخصيص فني بعد'
                                : '${widget.technicalName}',
                            font: 14.sp,
                            weight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          MainText(
                            text: 'التاريخ',
                            font: 12.sp,
                            weight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          MainText(
                            text: formateDateTimeToDate(
                              widget.visitDetails.createdDate!,
                            ),
                            font: 15.sp,
                            weight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: MainText(
                        text: 'تفاصيل المشكلة تسجيل صوتي',
                        font: 12.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: InkWell(
                        onTap: () async {
                          var path =
                              '$base_url_image${widget.visitDetails.sound}';
                          log(path);

                          playAudio(path);
                        },
                        child: Container(
                          height: 56.h,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.w,
                            horizontal: 30.h,
                          ),
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(width: 1.0, color: mainColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 24.h,
                                width: 24.w,
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              MainText(
                                text: 'تشغيل الملف الصوتي الخاص بالمشكلة',
                                color: Colors.white,
                                font: 12.sp,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Slider(
                          activeColor: kSecondaryColor,
                          value: _currentPosition,
                          min: 0.0,
                          max: _duration.inMilliseconds.toDouble(),
                          onChanged: (value) {
                            seekTo(value);
                          },
                        ),
                        Text(
                          '${formatDuration(Duration(milliseconds: _currentPosition.toInt()))} / ${formatDuration(_duration)}',
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: MainText(
                        text: 'الصور والفيديو الخاصين بالمشكلة',
                        font: 12.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 74.h,
                          width: 74.w,
                          child: widget.visitDetails.problemDetails!.length < 1
                              ? Image.asset(getAsset('no_pic'))
                              : CustomNetworkFileImage(
                                  path:
                                      '$base_url_image${widget.visitDetails.problemDetails![0].fileName}',
                                ),
                        ),
                        Container(
                          height: 74.h,
                          width: 74.w,
                          child: widget.visitDetails.problemDetails!.length < 2
                              ? Image.asset(getAsset('no_pic'))
                              : CustomNetworkFileImage(
                                  path:
                                      '$base_url_image${widget.visitDetails.problemDetails![1].fileName}',
                                ),
                        ),
                        Container(
                          height: 74.h,
                          width: 74.w,
                          child: widget.visitDetails.problemDetails!.length < 3
                              ? Image.asset(getAsset('no_pic'))
                              : CustomNetworkFileImage(
                                  path:
                                      '$base_url_image${widget.visitDetails.problemDetails![2].fileName}',
                                ),
                        ),
                        Container(
                          height: 74.h,
                          width: 74.w,
                          child: widget.visitDetails.problemDetails!.length < 4
                              ? Image.asset(getAsset('no_pic'))
                              : CustomNetworkFileImage(
                                  path:
                                      '$base_url_image${widget.visitDetails.problemDetails![3].fileName}',
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNetworkFileImage extends StatefulWidget {
  final String path;
  const CustomNetworkFileImage({
    required this.path,
  });

  @override
  State<CustomNetworkFileImage> createState() => _CustomNetworkFileImageState();
}

class _CustomNetworkFileImageState extends State<CustomNetworkFileImage> {
  @override
  Widget build(BuildContext context) {
    bool isVideo = false;
    String extension = pathFile.extension(widget.path).toLowerCase();
    if (extension == '.mp4' ||
        extension == '.avi' ||
        extension == '.mov' ||
        extension == '.mkv' ||
        extension == '.wmv' ||
        extension == '.flv' ||
        extension == '.ts' ||
        extension == '.ogv' ||
        extension == '.webm' ||
        extension == '.m4v' ||
        extension == '.3gp') {
      isVideo = true;
    } else {
      isVideo = false;
    }

    if (!isVideo) {
      return InkWell(
        child: Image.network(
          '${widget.path}',
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Image.network(
                  '${widget.path}',
                ),
              );
            },
          );
        },
      );
    } else {
      return InkWell(
        child: Image(
          image: AssetImage(
            getAsset('video_loading'),
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                contentPadding: EdgeInsets.zero,
                content: CustomVideoPlayer(
                  path: widget.path,
                ),
              );
            },
          );
        },
      );
    }
  }
}

class CustomVideoPlayer extends StatefulWidget {
  final String path;

  CustomVideoPlayer({required this.path});
  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController videoController;
  bool load = false;

  void initalizeVideoPlayer() async {
    setState(() {
      load = true;
    });
    videoController = await VideoPlayerController.networkUrl(
      Uri.parse(widget.path),
    )
      ..initialize().then((_) {
        setState(() {});
        videoController.play();
      });

    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initalizeVideoPlayer();
  }

  Widget videoPreview() {
    return load
        ? Center(child: CircularProgressIndicator())
        : videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: videoPreview(),
    );
  }
}
