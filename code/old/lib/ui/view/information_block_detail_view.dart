import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/information_block.dart';
import 'package:waaiburg_app/ui/components/information_blocks/block_details.dart';

class InformationBlockDetailView extends StatelessWidget {
  final InformationBlock block;

  const InformationBlockDetailView({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		return BlockDetail(block: block);
  }
}
