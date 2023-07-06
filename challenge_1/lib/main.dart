import 'package:flutter/material.dart';

void main() {
  runApp(const CApp());
}

class CApp extends StatelessWidget {
  const CApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge Day 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        body: Column(
          children: [
            const SizedBox(
              height: 65,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://mdbcdn.b-cdn.net/img/new/avatars/2.webp'),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                        ),
                        iconSize: 35,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'MONDAY 16',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        var isToday = index == 0;
                        return Text(
                          isToday ? "TODAY" : "$index",
                          style: TextStyle(
                            color: isToday
                                ? Colors.white
                                : const Color(
                                    0xFF8F8F8F,
                                  ),
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) {
                        var isToday = index == 0;
                        return isToday
                            ? Container(
                                width: 8,
                                height: 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFB22581),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : const SizedBox(
                                width: 30,
                              );
                      },
                      itemCount: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                children: [
                  CardWidget(
                    title: "DESIGN\nMETTING",
                    startTime: [
                      "11",
                      "30",
                    ],
                    endTime: [
                      "12",
                      "20",
                    ],
                    names: [
                      "ALEX",
                      "HELENA",
                      "NANA",
                    ],
                    bgColor: Color(
                      0xFFFEF754,
                    ),
                  ),
                  CardWidget(
                    title: "DAILY\nPROJECT",
                    startTime: [
                      "12",
                      "35",
                    ],
                    endTime: [
                      "14",
                      "10",
                    ],
                    names: ["ME", "RICHARD", "CIRY", "+4"],
                    bgColor: Color(
                      0xFF9C6BCE,
                    ),
                  ),
                  CardWidget(
                    title: "WEEKLY\nPLANNING",
                    startTime: [
                      "15",
                      "00",
                    ],
                    endTime: [
                      "16",
                      "30",
                    ],
                    names: ["DEN", "NANA", "MARK"],
                    bgColor: Color(
                      0xFFBBEE4B,
                    ),
                  ),
                  CardWidget(
                    title: "DESIGN\nMETTING",
                    startTime: [
                      "11",
                      "30",
                    ],
                    endTime: [
                      "12",
                      "20",
                    ],
                    names: [
                      "ALEX",
                      "HELENA",
                      "NANA",
                    ],
                    bgColor: Color(
                      0xFFFEF754,
                    ),
                  ),
                  CardWidget(
                    title: "DAILY\nPROJECT",
                    startTime: [
                      "12",
                      "35",
                    ],
                    endTime: [
                      "14",
                      "10",
                    ],
                    names: ["ME", "RICHARD", "CIRY", "+4"],
                    bgColor: Color(
                      0xFF9C6BCE,
                    ),
                  ),
                  CardWidget(
                    title: "WEEKLY\nPLANNING",
                    startTime: [
                      "15",
                      "00",
                    ],
                    endTime: [
                      "16",
                      "30",
                    ],
                    names: ["DEN", "NANA", "MARK"],
                    bgColor: Color(
                      0xFFBBEE4B,
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final List<String> startTime;
  final List<String> endTime;
  final String title;
  final List<String> names;
  final Color bgColor;
  const CardWidget({
    super.key,
    required this.endTime,
    required this.title,
    required this.names,
    required this.startTime,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 10,
        left: 15,
        right: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            30,
          ),
        ),
        color: bgColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                startTime[0],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  height: 1,
                ),
              ),
              Text(
                startTime[1],
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              Container(
                width: 0.8,
                color: Colors.black,
                height: 30,
              ),
              Text(
                endTime[0],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              Text(
                endTime[1],
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 60, height: 0.85),
              ),
              Wrap(
                direction: Axis.horizontal,
                spacing: 20,
                children: [
                  for (var t in names)
                    Text(
                      t,
                      style: const TextStyle(
                        color: Color(0xFFB1AC23),
                      ),
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
