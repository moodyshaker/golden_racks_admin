import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomAudio extends StatefulWidget {
  @override
  State<CustomAudio> createState() => _CustomAudioState();
}

class _CustomAudioState extends State<CustomAudio> {
  bool isPlaying = false;
  bool isRecording = false;
  late Record audioRecord;
  late AudioPlayer audioPlayer;

  //recorder
  int recordDuration = 0;
  Timer? timer;
  String audioPath = '';

  //player
  Duration audioDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  int audioDurationInSeconds = 0;
  int currentPositionInSeconds = 0;

  @override
  void initState() {
    super.initState();
    audioRecord = Record();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    timer?.cancel();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Audio Recorder'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTimer(recordDuration: recordDuration),
            SizedBox(height: 16),
            InkWell(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 32,
                child: Icon(
                  isRecording ? Icons.stop : Icons.mic,
                  size: 32,
                ),
              ),
              onTap: () async {
                if (isRecording) {
                  await stopRecord();
                } else {
                  await startRecord();
                }
              },
            ),
            SizedBox(height: 24),
            isRecording
                ? Center(child: Text('Recording...'))
                : Center(
                    child: IconButton(
                      onPressed: () async {
                        if (audioPath.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Record the audio first'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            ),
                          );
                        } else {
                          if (isPlaying) {
                            await audioPlayer.pause();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            log(audioPath);
                            await playRecording();
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        }
                      },
                      icon: Container(
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
            Slider(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              value: currentPositionInSeconds.toDouble(),
              min: 0.0,
              max: audioDurationInSeconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimer(recordDuration: currentPositionInSeconds),
                Text(' / '),
                buildTimer(recordDuration: audioDurationInSeconds),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startRecord() async {
    try {
      bool hasPermission = await audioRecord.hasPermission();
      if (hasPermission) {
        audioPlayer.stop();
        await audioRecord.start(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );
        bool recording = await audioRecord.isRecording();
        setState(() {
          isRecording = recording;
          recordDuration = 0;
          currentPositionInSeconds = 0;
          audioDurationInSeconds = 0;
        });
        startTimer();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> stopRecord() async {
    try {
      timer?.cancel();
      String? path = await audioRecord.stop();
      bool recording = await audioRecord.isRecording();
      setState(() {
        isRecording = recording;
        audioPath = path!;
        isPlaying = false;
      });
      if (path != null && recordDuration >= 1) {
        File audioSourceFile = File(path);
        audioPath = audioSourceFile.path;
        log(audioSourceFile.path);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> playRecording() async {
    Source urlSource = UrlSource(audioPath);
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDurationInSeconds = duration.inSeconds;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        currentPositionInSeconds = position.inSeconds;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        currentPositionInSeconds = 0; // Reset the slider position to zero
      });
    });
    await audioPlayer.play(urlSource);
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(
        () => recordDuration += 1,
      );
    });
  }

  Widget buildTimer({required int recordDuration}) {
    final String minutes = formatNumber(recordDuration ~/ 60);
    final String seconds = formatNumber(recordDuration % 60);

    return MainText(
      text: '$minutes : $seconds',
      color: Colors.white,
      font: 16,
    );
  }

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }
}

class MainText extends StatelessWidget {
  final String text;
  final Color color;
  final double font;
  MainText({
    required this.text,
    required this.color,
    required this.font,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${text}',
      style: TextStyle(
        color: color,
        fontSize: font,
      ),
    );
  }
}

class CustomCalendarTable extends StatefulWidget {
  @override
  State<CustomCalendarTable> createState() => _CustomCalendarTableState();
}

class _CustomCalendarTableState extends State<CustomCalendarTable> {
  List<DateTime> highlightedDates = [
    DateTime(2023, 11, 5),
    DateTime(2023, 11, 10),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2025, 1, 1),
        focusedDay: DateTime.utc(2023, 11, 1),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (highlightedDates.contains(date)) {
              return Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              );
            }
            return null;
          },
        ),
        onDaySelected: (date, events) {
          if (highlightedDates.contains(date)) {
            print('ss');
          }
        },
      ),
    );
  }
}
