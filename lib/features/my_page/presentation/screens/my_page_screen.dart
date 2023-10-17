import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/presentation/providers/my_page_resolution_list_provider.dart';
import 'package:wehavit/features/my_page/presentation/widgets/resolution_accomplishment_donut_graph_datamodel.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var resolutionListProvider = ref.watch(myPageResolutionListProvider);
    var currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 30,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  // Image(image: AssetImage(""), width: 50, height: 50),
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      radius: 40,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentUser?.displayName ?? "DEBUG_NONAME"),
                      Text(currentUser?.uid ?? "DEBUG_UID"),
                    ],
                  )
                ],
              ),
            ),
            Row(children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: FilledButton(
                    onPressed: () async {
                      await ref
                          .read(myPageResolutionListProvider.notifier)
                          .getActiveResolutionList();
                    },
                    child: Text("전체 통계 확인하기")),
              )),
            ]),
            resolutionListProvider.fold(
              (left) => null,
              (right) => Expanded(
                child: ListView.builder(
                  itemCount: right.length,
                  itemBuilder: (context, index) {
                    return MyResolutionWidget(model: right[index]);
                  },
                ),
              ),
            ) as Widget,
            // MyResolutionWidget(),
            // MyResolutionWidget(),
          ],
        ),
      ),
    );
  }
}

class MyResolutionWidget extends StatefulWidget {
  const MyResolutionWidget({Key? key, required this.model}) : super(key: key);

  final ResolutionModel model;

  @override
  State<MyResolutionWidget> createState() => _MyResolutionWidgetState();
}

class _MyResolutionWidgetState extends State<MyResolutionWidget> {
  late String goalStatement = widget.model.goal;
  late String actionStatement = widget.model.action;

  List<DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>>
      _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel,
        String>>[
      DoughnutSeries<ResolutionAccomplishmentDonutGraphDataModel, String>(
        dataSource: <ResolutionAccomplishmentDonutGraphDataModel>[
          ResolutionAccomplishmentDonutGraphDataModel(x: "do", y: 90),
          ResolutionAccomplishmentDonutGraphDataModel(x: "didn't", y: 10),
        ],
        xValueMapper:
            (ResolutionAccomplishmentDonutGraphDataModel datum, int index) =>
                datum.x,
        yValueMapper:
            (ResolutionAccomplishmentDonutGraphDataModel datum, int index) =>
                datum.y,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$goalStatement"),
                  Text("$actionStatement"),
                  SizedBox(height: 20),
                  Container(
                    child: Container(
                      child: SfLinearGauge(
                        showTicks: false,
                        showAxisTrack: false,
                        showLabels: false,
                        maximum: 13,
                        markerPointers: List<LinearWidgetPointer>.generate(
                          14,
                          (int index) => _buildLinearWidgetPointer(
                              index.toDouble(),
                              index % 4 == 1 ? Colors.black : Colors.white),
                        ),
                      ),
                    ),
                    // width: 200,
                    // height: 50,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  Container(
                    child: Container(
                      child: SfLinearGauge(
                        showTicks: false,
                        showAxisTrack: false,
                        showLabels: false,
                        maximum: 13,
                        markerPointers: List<LinearWidgetPointer>.generate(
                          14,
                          (int index) => _buildLinearWidgetPointer(
                              index.toDouble(),
                              index % 4 == 0 || index % 4 == 1
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.white),
                    // width: 200,
                    // height: 50,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(4),
                child: SfCircularChart(series: _getDefaultDoughnutSeries()),
                decoration: BoxDecoration(color: Colors.amber),
              ),
            ),
          )
        ],
      ),
    );
  }

  LinearWidgetPointer _buildLinearWidgetPointer(double value, Color color) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      child: Container(
        height: 30,
        width: 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
      ),
    );
  }
}
