import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 2;
  int round = 0;
  int totalPomodoros = 0;

  bool isRunning = false;

  final int restTime = 60 * 5;
  final times = [15, 20, 25, 30, 35];
  final CarouselController _controller = CarouselController();

  late int totalSeconds;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onRestTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPress() {
    isRunning = true;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  updateTime() {
    totalSeconds = times[selectedIndex] * 60;
  }

  void moveToIndex(int index) {
    _controller.animateToPage(index);
    setState(() {
      selectedIndex = index;
      updateTime();
    });
  }

  void onRestorePress() {
    if (totalSeconds != times[selectedIndex] * 60) {
      timer.cancel();
    }
    setState(() {
      moveToIndex(2);
      isRunning = false;
      selectedIndex = 2;
      round = 0;
      totalPomodoros = 0;
    });
  }

  List<String> format(int seconds) {
    return Duration(seconds: seconds)
        .toString()
        .split(".")
        .first
        .substring(2, 7)
        .split(":");
  }

  @override
  void initState() {
    super.initState();
    updateTime();
  }

  @override
  Widget build(BuildContext context) {
    var timeToStringList = format(totalSeconds);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "POMOTIMER",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 30,
                    color: Theme.of(context).cardColor,
                    onPressed: onRestorePress,
                    icon: const Icon(
                      Icons.restore,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 130,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Row(
                        children: [
                          StackCard(
                            time: timeToStringList[0],
                          ),
                          const Column(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: Color(0xFFF19287),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: Color(0xFFF19287),
                              ),
                            ],
                          ),
                          StackCard(
                            time: timeToStringList[1],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CarouselSlider(
                      items: times
                          .asMap()
                          .entries
                          .map(
                            (entry) => TimeButton(
                              selected: entry.key == selectedIndex,
                              text: entry.value.toString(),
                              onPressed: () {
                                if (!isRunning) {
                                  moveToIndex(entry.key);
                                }
                              },
                            ),
                          )
                          .toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                        aspectRatio: 10 / 1,
                        initialPage: selectedIndex,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          if (!isRunning) {
                            setState(() {
                              selectedIndex = index;
                              updateTime();
                            });
                          }
                        },
                        viewportFraction: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          isRunning ? Icons.pause : Icons.play_arrow,
                        ),
                        color: Colors.white,
                        onPressed: isRunning ? onPausePressed : onStartPress,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 90,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "$round/4",
                          style: TextStyle(
                            color: Colors.white.withOpacity(
                              0.5,
                            ),
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "ROUND",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "$totalPomodoros/4",
                          style: TextStyle(
                            color: Colors.white.withOpacity(
                              0.5,
                            ),
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "GOAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeButton extends StatefulWidget {
  final void Function()? onPressed;
  final bool selected;
  final String text;
  const TimeButton(
      {super.key, this.onPressed, required this.selected, required this.text});

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> with TickerProviderStateMixin {
  late AnimationController _colorAnimationController;
  late AnimationController _backgroundAnimationController;
  late Animation _colorAnimation;
  late Animation _backgroundAnimation;

  updateColors() {
    widget.selected
        ? _colorAnimationController.forward()
        : _colorAnimationController.reverse();
    widget.selected
        ? _backgroundAnimationController.forward()
        : _backgroundAnimationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _colorAnimation = ColorTween(
      begin: Colors.white.withOpacity(
        0.8,
      ),
      end: Colors.red,
    ).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });
    _backgroundAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.white,
    ).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });
    updateColors();
  }

  @override
  void didUpdateWidget(covariant TimeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateColors();
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 100,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: _backgroundAnimation.value,
            side: const BorderSide(
              width: 2,
              color: Color(0xFFED675A),
            )),
        onPressed: () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        child: Text(
          widget.text,
          style: TextStyle(color: _colorAnimation.value),
        ),
      ),
    );
  }
}

class StackCard extends StatelessWidget {
  final String time;
  const StackCard({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -6,
            child: Card(
              color: Colors.white.withOpacity(
                0.6,
              ),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const SizedBox(
                width: 120,
                height: 150,
              ),
            ),
          ),
          Positioned(
            top: -12,
            child: Card(
              color: Colors.white.withOpacity(
                0.6,
              ),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const SizedBox(
                width: 110,
                height: 140,
              ),
            ),
          ),
          Card(
            elevation: 2,
            clipBehavior: Clip.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: SizedBox(
              width: 130,
              height: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
