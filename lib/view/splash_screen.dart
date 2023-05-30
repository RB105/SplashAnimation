
import 'package:flutter/material.dart';
import 'package:splashanimation/build_context_ext.dart';


class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  late PageController pageController;
  late bool isFinal;
  int currentIndex = 0;
  String lang = "uz";

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    isFinal = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.025),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    value: lang,
                    focusColor: Colors.white,
                    underline: Container(),
                    items: [
                      DropdownMenuItem(
                        value: "uz",
                        onTap: () {
                          setState(() {
                            lang = "uz";
                          });
                        },
                        child: Text(
                          "Uzbek",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ru',
                        onTap: () {
                          setState(() {
                            lang = "ru";
                          });
                        },
                        child: Text("Russian",
                                style: Theme.of(context).textTheme.displaySmall)
                            ,
                      ),
                      DropdownMenuItem(
                        value: "en",
                        onTap: () {
                          setState(() {
                            lang = "en";
                          });
                        },
                        child: Text("English",
                                style: Theme.of(context).textTheme.displaySmall)
                            ,
                      )
                    ],
                    onChanged: (value) {},
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigation to Auth page
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'phone', (route) => false);
                    },
                    child: Text(
                      "skip",
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .fontSize,
                          color: const Color(0xffE31E24)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.height * 0.05),
                child: SizedBox(
                    height: context.height * 0.7,
                    width: double.infinity,
                    child: PageView(
                      onPageChanged: (value) {
                        // elevated button dynamic state algo
                        changeButtonState(value);
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      controller: pageController,
                      children: [
                        SplashBodyWidget(currentIndex: currentIndex),
                        SplashBodyWidget(currentIndex: currentIndex),
                        SplashBodyWidget(currentIndex: currentIndex),
                        SplashBodyWidget(currentIndex: currentIndex),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.025),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInSine);
                      if (isFinal) {
                        // navigate to Auth
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'phone', (route) => false);
                      }
                    },
                    child: !isFinal
                        ? const Text("next")
                        : const Text("start")))
          ],
        ),
      ),
    );
  }

  void changeButtonState(int value) {
    if (value < 3) {
      setState(() {
        isFinal = false;
      });
    } else {
      setState(() {
        isFinal = true;
      });
    }
    pageController.animateToPage(value,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }
}

class SplashBodyWidget extends StatelessWidget {
  final int currentIndex;
  const SplashBodyWidget({super.key, required this.currentIndex});

  @override
  Column build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 7,
          child: Image.asset(
            'assets/splash/MTransfer 1.png',
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "International Money Transfers",
            maxLines: 3,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Expanded(
          flex: 1,
          child: Text(
            "A trifle, but nice: the speakers of the State Duma are indignant!"
                ,
            style: Theme.of(context).textTheme.displaySmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
            flex: 1,
            child: SizedBox(
              width: context.width * 0.25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor:
                          currentIndex == index ? Colors.red : Colors.grey,
                      radius: currentIndex == index ? 10 : 7,
                    ),
                  );
                },
              ),
            ))
      ],
    );
  }
}
