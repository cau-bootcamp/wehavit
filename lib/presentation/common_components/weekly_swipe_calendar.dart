import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/either_future_builder.dart';

class WeeklySwipeCalendar extends StatefulWidget {
  const WeeklySwipeCalendar({super.key});

  @override
  State<WeeklySwipeCalendar> createState() => _WeeklySwipeCalendarState();
}

class _WeeklySwipeCalendarState extends State<WeeklySwipeCalendar> {
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool isShowingCarousel = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              selectedDate.getFormattedString(),
              style: const TextStyle(
                color: CustomColors.whWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isShowingCarousel = !isShowingCarousel;
                });
              },
              icon: Icon(
                isShowingCarousel ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: CustomColors.whWhite,
              ),
            ),
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          height: isShowingCarousel ? 64 : 0,
          child: WeeklySwipeCalendarCarousel(
            firstDate: DateTime.now().subtract(const Duration(days: 5)),
            calendartMondayDateList: [
              DateTime.now().subtract(const Duration(days: 7)).getMondayDateTime(),
              DateTime.now().getMondayDateTime(),
            ],
            onChangeDate: (newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
            selectedDate: selectedDate,
          ),
        ),
      ],
    );
  }
}

class WeeklySwipeCalendarCarousel extends StatelessWidget {
  WeeklySwipeCalendarCarousel({
    super.key,
    required this.calendartMondayDateList,
    required this.firstDate,
    required this.onChangeDate,
    required this.selectedDate,
  });

  final DateTime firstDate;
  final DateTime selectedDate;

  final DateTime todayDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final List<DateTime> calendartMondayDateList;
  final Map<DateTime, EitherFuture<List<ConfirmPostEntity>>> confirmPostList = {};

  final Function(DateTime) onChangeDate;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(7, (jndex) {
            final cellDate = todayDate.subtract(
              Duration(
                days: todayDate.weekday - 1 - jndex + 7 * index,
              ),
            );
            final isFuture = todayDate.isBefore(cellDate);
            final isPast = firstDate.isAfter(cellDate);

            return Expanded(
              child: GestureDetector(
                onTapUp: (details) async {
                  if (!isFuture && !isPast) {
                    onChangeDate(cellDate);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.whBlack,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(
                      14.0,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                          blurRadius: 4,
                          color: CustomColors.whBlack,
                        ),
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                          color: (isFuture || isPast)
                              ? CustomColors.whGrey
                              : cellDate == selectedDate
                                  ? CustomColors.whYellow500
                                  : CustomColors.whYellow200,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                cellDate.day == 1 ? '${cellDate.month}/${cellDate.day}' : cellDate.day.toString(),
                                style: context.bodyLarge?.copyWith(
                                  color: (isFuture || isPast) || cellDate != selectedDate
                                      ? CustomColors.whGrey700
                                      : CustomColors.whGrey100,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Visibility(
                              visible: !(isFuture || isPast),
                              replacement: Text(
                                '-',
                                style: context.displaySmall?.copyWith(
                                  color: (isFuture || isPast) || cellDate != selectedDate
                                      ? CustomColors.whGrey700
                                      : CustomColors.whGrey100,
                                ),
                              ),
                              child: EitherFutureBuilder<List<ConfirmPostEntity>>(
                                target: confirmPostList[cellDate],
                                forWaiting: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      2.0,
                                    ),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: (isFuture || isPast) || cellDate != selectedDate
                                          ? CustomColors.whGrey700
                                          : CustomColors.whGrey100,
                                    ),
                                  ),
                                ),
                                forFail: const Text('-'),
                                mainWidgetCallback: (entityList) => Text(
                                  entityList.length.toString(),
                                  style: context.displaySmall?.copyWith(
                                    color: (isFuture || isPast) || cellDate != selectedDate
                                        ? CustomColors.whGrey700
                                        : CustomColors.whGrey100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
      itemCount: calendartMondayDateList.length,
      options: CarouselOptions(
        height: 64,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        reverse: true,
        onPageChanged: (index, reason) async {
          if (index == calendartMondayDateList.length - 1) {
            if (calendartMondayDateList.first.isBefore(firstDate)) {
              return;
            }
            // 마지막 페이지에 도달했을 때 추가 요소를 추가합니다.
            calendartMondayDateList.insert(
              0,
              calendartMondayDateList.first.subtract(
                const Duration(days: 7),
              ),
            );

            // await provider
            //     .loadConfirmPostsForWeek(
            //   mondayOfTargetWeek: viewModel.calendartMondayDateList[0],
            // )
            //     .whenComplete(() {
            //   setState(() {});
            // });
          }
        },
      ),
    );
  }
}
