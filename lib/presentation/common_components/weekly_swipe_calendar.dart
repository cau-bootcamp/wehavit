import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/group_post/confirm_post_provider.dart';

class WeeklyPostSwipeCalendar extends StatefulWidget {
  const WeeklyPostSwipeCalendar({
    super.key,
    required this.resolutionList,
    required this.firstDate,
    required this.onSelected,
  });

  final List<String> resolutionList;
  final DateTime firstDate;
  final Function(DateTime) onSelected;

  @override
  State<WeeklyPostSwipeCalendar> createState() => _WeeklyPostSwipeCalendarState();
}

class _WeeklyPostSwipeCalendarState extends State<WeeklyPostSwipeCalendar> {
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool isShowingCarousel = true;
  List<DateTime> calendartMondayDateList = [
    DateTime.now().subtract(const Duration(days: 7)).getMondayDateTime(),
    DateTime.now().getMondayDateTime(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              selectedDate.getFormattedString(),
              style: context.titleMedium,
            ),
            WhIconButton(
              size: WHIconsize.small,
              iconString: isShowingCarousel ? WHIcons.chevronUp : WHIcons.chevronDown,
              onPressed: () {
                setState(() {
                  isShowingCarousel = !isShowingCarousel;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          height: isShowingCarousel ? 64 : 0,
          child: WeeklySwipeCalendarCarousel(
            resolutionList: widget.resolutionList,
            firstDate: widget.firstDate,
            calendartMondayDateList: calendartMondayDateList,
            onChangeDate: (newDate) {
              setState(() {
                selectedDate = newDate;
              });
              widget.onSelected(newDate);
            },
            selectedDate: selectedDate,
          ),
        ),
      ],
    );
  }
}

class WeeklySwipeCalendarCarousel extends StatefulWidget {
  const WeeklySwipeCalendarCarousel({
    super.key,
    required this.resolutionList,
    required this.calendartMondayDateList,
    required this.firstDate,
    required this.onChangeDate,
    required this.selectedDate,
  });

  final List<String> resolutionList;
  final DateTime firstDate;
  final DateTime selectedDate;

  final List<DateTime> calendartMondayDateList;
  final Function(DateTime) onChangeDate;

  @override
  State<WeeklySwipeCalendarCarousel> createState() => _WeeklySwipeCalendarCarouselState();
}

class _WeeklySwipeCalendarCarouselState extends State<WeeklySwipeCalendarCarousel> {
  final DateTime todayDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final Map<DateTime, EitherFuture<List<ConfirmPostEntity>>> confirmPostList = {};

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return Consumer(
          builder: (context, ref, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Widget>.generate(7, (jndex) {
                final cellDate = todayDate.subtract(
                  Duration(days: todayDate.weekday - 1 - jndex + 7 * index),
                );
                final isFuture = todayDate.isBefore(cellDate);
                final isPast = widget.firstDate.isAfter(cellDate);

                final asyncCellValue = ref
                    .watch(confirmPostListProvider(ConfirmPostProviderParam(widget.resolutionList, cellDate)))
                    .whenData((list) => list.length);

                return WeeklyPostSwipeCalendarCell(
                  isValidDate: !(isFuture || isPast),
                  widget: widget,
                  cellDate: cellDate,
                  asyncConfirmPostCount: asyncCellValue,
                );
              }),
            );
          },
        );
      },
      itemCount: widget.calendartMondayDateList.length,
      options: CarouselOptions(
        height: 64,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        reverse: true,
        onPageChanged: (index, reason) async {
          if (index == widget.calendartMondayDateList.length - 1) {
            if (widget.calendartMondayDateList.first.isBefore(widget.firstDate)) {
              return;
            }
            // 마지막 페이지에 도달했을 때 추가 요소를 추가합니다.
            widget.calendartMondayDateList.insert(
              0,
              widget.calendartMondayDateList.first.subtract(const Duration(days: 7)),
            );
            setState(() {});
          }
        },
      ),
    );
  }
}

class WeeklyPostSwipeCalendarCell extends StatelessWidget {
  const WeeklyPostSwipeCalendarCell({
    super.key,
    required this.isValidDate,
    required this.widget,
    required this.cellDate,
    required this.asyncConfirmPostCount,
  });

  final bool isValidDate;
  final WeeklySwipeCalendarCarousel widget;
  final DateTime cellDate;
  final AsyncValue<int> asyncConfirmPostCount;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.selectedDate == cellDate;

    return Expanded(
      child: GestureDetector(
        onTapUp: (details) async {
          if (isValidDate) {
            widget.onChangeDate(cellDate);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.whBlack,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(14.0),
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
                  color: !isValidDate
                      ? CustomColors.whGrey
                      : (isSelected ? CustomColors.whYellow500 : CustomColors.whYellow200),
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
                          color: !isValidDate || !isSelected ? CustomColors.whGrey700 : CustomColors.whGrey100,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Visibility(
                      visible: isValidDate,
                      replacement: Text(
                        '-',
                        style: context.displaySmall?.copyWith(
                          color: !isValidDate || !isSelected ? CustomColors.whGrey700 : CustomColors.whGrey100,
                        ),
                      ),
                      child: asyncConfirmPostCount.when(
                        data: (data) {
                          return Text(
                            data.toString(),
                            style: context.displaySmall?.copyWith(
                              color: !isValidDate || cellDate != widget.selectedDate
                                  ? CustomColors.whGrey700
                                  : CustomColors.whGrey100,
                            ),
                          );
                        },
                        error: (_, __) {
                          return Text(
                            '-',
                            style: context.displaySmall?.copyWith(
                              color: !isValidDate || !isSelected ? CustomColors.whGrey700 : CustomColors.whGrey100,
                            ),
                          );
                        },
                        loading: () {
                          return SizedBox(
                            width: 20,
                            height: 24,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: !isSelected ? CustomColors.whGrey700 : CustomColors.whGrey100,
                              ),
                            ),
                          );
                        },
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
  }
}
