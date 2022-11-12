import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waaiburg_app/data/models/information_block.dart';
import 'package:waaiburg_app/data/repositories/information_block_repository.dart';
import 'package:waaiburg_app/main.dart';
import 'package:waaiburg_app/ui/components/rounded_headerbar.dart';

class BlockDetail extends StatefulWidget {
  BlockDetail({Key key, this.block}) : super(key: key);

  final InformationBlock block;

  @override
  _BlockDetailState createState() => _BlockDetailState(block);
}

class _BlockDetailState extends State<BlockDetail> {
  final _blockRepository = InformationBlockRepository();

  InformationBlock block;

  bool isConnectedToInternet = true;

  _BlockDetailState(this.block);

  @override
  void initState() {
    super.initState();

    loadBlockDetails();
  }

  loadBlockDetails() async {
    var block =
        await _blockRepository.getInfoBlockDetails(this.block, fromCache: true);

    if (block != null)
      setState(
        () {
          this.block = block;
        },
      );

    block = await _blockRepository.getInfoBlockDetails(this.block,
        fromCache: false);

    if (block == null || block.inhoud == null || block.inhoud.isEmpty) {
      setState(
        () {
          isConnectedToInternet = false;
        },
      );
    }
    if (block != null)
      setState(
        () {
          this.block = block;
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return RoundedHeaderBar(
      headerName: block.titel.stringFix,
      menuColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: size.height * 1,
            child: Stack(
              children: [
                if (isConnectedToInternet == false)
                  Center(
                    child: Text(WaaiburgApp.NoInternetMessage),
                  )
                else if (block == null ||
                    block.inhoud == null ||
                    block.inhoud.length == 0)
                  Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(),
                  )
                else
                  ListView(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    children: [
                      Container(
                        child: Html(
                          data: block.inhoud,
                          style: {
                            'h1': Style(
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.secondary,
                              margin: EdgeInsets.all(0),
                            ),
                            'p': Style(
                              color: Colors.black,
                              textAlign: TextAlign.start,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
                              margin: EdgeInsets.all(0),
                            ),
                          },
                          onLinkTap: (url, _, __, ___) {
                            launch(url,
                                forceWebView: false,
                                enableJavaScript: true,
                                webOnlyWindowName: url);
                          },
                          onImageTap: (src, _, __, ___) {
                            print(src);
                          },
                          onImageError: (exception, stackTrace) {
                            print(exception);
                          },
                        ),
                      ),
                      if (block.meerInfoLink != null &&
                          block.meerInfoLink.isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(bottom: 30),
                          child: Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.secondary),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "Meer info",
                                    style: TextStyle(
                                      fontSize: 48,
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                launch(block.meerInfoLink,
                                    forceWebView: false,
                                    enableJavaScript: true,
                                    webOnlyWindowName: block.meerInfoLink);
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: kToolbarHeight * 1.5,
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColorLight,
                ], begin: Alignment.topLeft),
              ),
            ),
            // Title
            Container(
              child: Center(
                child: Container(
                  width: screenWidth * 0.7,
                  height: kToolbarHeight * 1.0,
                  margin: EdgeInsets.only(top: 25),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        block.titel.stringFix,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Back button icon
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 25),
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: Theme.of(context).primaryColor,
                ),
                iconSize: 48,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight * 1,
            child: Stack(
              children: [
                if (isConnectedToInternet == false)
                  Center(
                    child: Text(WaaiburgApp.NoInternetMessage),
                  )
                else if (block == null ||
                    block.inhoud == null ||
                    block.inhoud.length == 0)
                  Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(),
                  )
                else
                  ListView(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.14),
                        child: Html(
                          data: block.inhoud,
                          style: {
                            'h1': Style(
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.secondary,
                              margin: EdgeInsets.all(0),
                            ),
                            'p': Style(
                              color: Theme.of(context).shadowColor,
                              textAlign: TextAlign.start,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
                              margin: EdgeInsets.all(0),
                            ),
                          },
                          onLinkTap: (url, _, __, ___) {
                            launch(url,
                                forceWebView: false,
                                enableJavaScript: true,
                                webOnlyWindowName: url);
                          },
                          onImageTap: (src, _, __, ___) {
                            print(src);
                          },
                          onImageError: (exception, stackTrace) {
                            print(exception);
                          },
                        ),
                      ),
                      if (block.meerInfoLink != null &&
                          block.meerInfoLink.isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(bottom: 30),
                          child: Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.secondary),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "Meer info",
                                    style: TextStyle(
                                      fontSize: 48,
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                launch(block.meerInfoLink,
                                    forceWebView: false,
                                    enableJavaScript: true,
                                    webOnlyWindowName: block.meerInfoLink);
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
}
