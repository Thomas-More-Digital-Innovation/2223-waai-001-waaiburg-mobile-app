import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/information_block.dart';
import 'package:waaiburg_app/data/models/information_segment.dart';
import 'package:waaiburg_app/data/repositories/information_block_repository.dart';
import 'package:waaiburg_app/main.dart';
import 'package:waaiburg_app/ui/components/information_blocks/block_card.dart';

class BlockList extends StatefulWidget {
  BlockList({Key key, this.segment}) : super(key: key);

  final InformationSegment segment;

  @override
  _BlockListState createState() => _BlockListState(segment);
}

class _BlockListState extends State<BlockList> {
  final _blockRepository = InformationBlockRepository();

  final InformationSegment segment;

  _BlockListState(this.segment);

  List<InformationBlock> blocks = [];

  bool isConnectedToInternet = true;

  @override
  void initState() {
    super.initState();

    loadBlocks();
  }

  loadBlocks() async {
    // Try to load from cache
    var blocks = await _blockRepository.getInfoBlocks(segment, fromCache: true);

    if (blocks != null) {
      this.blocks.clear();
      setState(() {
        this.blocks.addAll(blocks);
      });
    }
    
    // Try to load from online
    blocks = await _blockRepository.getInfoBlocks(segment, fromCache: false);

    if (blocks != null) {
      this.blocks.clear();
      setState(() {
        this.blocks.addAll(blocks);
      });
    } else {
      if (this.blocks.length == 0)
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
          else if (blocks == null || blocks.length == 0)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            ListView(
              padding: EdgeInsets.only(top: 0),
              children: blocks
                  .map((s) => BlockCard(
                        block: s,
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
