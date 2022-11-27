import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/information_segment.dart';
import 'package:waaiburg_app/data/repositories/information_segment_repository.dart';
import 'package:waaiburg_app/main.dart';
import 'package:waaiburg_app/ui/components/information_segments/segment_card.dart';

class SegmentList extends StatefulWidget {
  SegmentList({Key key, this.jongerenOfVolwassenen}) : super(key: key);

  final JongerenOfVolwassenen jongerenOfVolwassenen;

  @override
  _SegmentListState createState() => _SegmentListState(jongerenOfVolwassenen);
}

class _SegmentListState extends State<SegmentList> {
  final _segmentRepository = InformationSegmentRepository();

  final JongerenOfVolwassenen jongerenOfVolwassenen;

  _SegmentListState(this.jongerenOfVolwassenen);

  List<InformationSegment> segments = [];

  bool isConnectedToInternet = true;

  @override
  void initState() {
    super.initState();
    loadSegments();
  }

  loadSegments() async {
    // Try to load from cache
    var segments = await _segmentRepository.getSegments(jongerenOfVolwassenen,
        fromCache: true);

    if (segments != null) {
      this.segments.clear();
      setState(() {
        this.segments.addAll(segments);
      });
    }

    // Try to load from online
    segments = await _segmentRepository.getSegments(jongerenOfVolwassenen,
        fromCache: false);

    if (segments != null) {
      this.segments.clear();
      setState(() {
        this.segments.addAll(segments);
      });
    } else {
      if (this.segments.length == 0)
        setState(() {
          isConnectedToInternet = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: EdgeInsets.only(top: 0.13 * screenHeight),
        child: Stack(
      children: [
        if (isConnectedToInternet == false)
          Center(
            child: Text(WaaiburgApp.NoInternetMessage),
          )
        else if (segments == null || segments.length == 0)
          Center(
            child: CircularProgressIndicator(),
          )
        else
          ListView(
            padding: EdgeInsets.only(top: 0),
            children: segments
                .map((s) => SegmentCard(
                      segment: s,
                    ))
                .toList(),
          ),
      ],
    ));
  }
}
