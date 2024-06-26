// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:salonsync/constants.dart';
import 'package:salonsync/controller/on_board_controller.dart';

class OnBoard extends StatelessWidget {
  final _controller = OnboardController();

  OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              itemCount: _controller.onboard.length,
              controller: _controller.pageContoller,
              onPageChanged: _controller.selectedPageIndex.call,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_controller.onboard[index].image),
                      Text(
                        _controller.onboard[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _controller.onboard[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: List.generate(
                _controller.onboard.length,
                (index) => Obx(() {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _controller.selectedPageIndex.value == index
                          ? themeColor
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: themeColor,
                onPressed: () => _controller.forwardAction(context),
                child: Obx(() => _controller.isLastPage
                    ? const Text('Start')
                    : const Text('Next')),
              ))
        ],
      ),
    );
  }
}
