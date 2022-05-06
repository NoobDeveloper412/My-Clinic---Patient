import 'dart:isolate';
import 'dart:ui';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipedetector/swipedetector.dart';

class ShowPrescriptionImagePage extends StatefulWidget {
  final title;
  final imageUrls;
  final int selectedImagesIndex;
  ShowPrescriptionImagePage(
      {Key key, this.imageUrls, this.title, this.selectedImagesIndex})
      : super(key: key);
  @override
  _ShowPrescriptionImagePageState createState() =>
      _ShowPrescriptionImagePageState();
}

class _ShowPrescriptionImagePageState extends State<ShowPrescriptionImagePage> {
  String _selectedImageUrl = "";
  int totalImg = 0;
  int _index = 0;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    //print(widget.imageUrls.length);
    //initialize all value
    setState(() {
      _selectedImageUrl = widget.imageUrls[widget.selectedImagesIndex];
      totalImg = widget.imageUrls.length;
      _index = widget.selectedImagesIndex;
    });
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      // DownloadTaskStatus status = data[1];
      // int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: kAppbarTitleStyle,
          ),
          backgroundColor: appBarColor,
          actions: [
            IconButton(
                onPressed: () async {
                  var perStatus = await Permission.storage.request();
                  if (perStatus.isGranted) {
                    final externalDir = await getExternalStorageDirectory();
                    ToastMsg.showToastMsg("Download Stated");
                   await FlutterDownloader.enqueue(
                      url: _selectedImageUrl,
                      savedDir: externalDir.path,
                      fileName:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      showNotification:
                          true, // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                    );
                  }
                },
                icon: Icon(
                  Icons.download_rounded,
                ))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          //color: Colors.red,
          child: Stack(
            children: [
              Container(
                  child: SwipeDetector(
                onSwipeLeft: () {
                  _forwardImg();
                  // print("Swipe Left");
                },
                onSwipeRight: () {
                  _backwardImg();
                  // print("Swipe Right");
                },
                child: Center(
                    child: ImageBoxContainWidget(imageUrl: _selectedImageUrl)
                    //get image from url
                    ),
              )),
              widget.imageUrls.indexOf(_selectedImageUrl) != totalImg - 1
                  ? Positioned.fill(
                      child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: _forwardImg,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ))
                  : Container(),
              widget.imageUrls.indexOf(_selectedImageUrl) > 0
                  ? Positioned.fill(
                      child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: _backwardImg,
                            icon: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ))
                  : Container()
            ],
          ),
        ));
  }

  void _forwardImg() {
    // print(_index);
    //print(totalImg);
    if (_index + 1 <= totalImg - 1) {
      // check more images is remain or not by indexes
      setState(() {
        _selectedImageUrl = widget.imageUrls[_index +
            1]; // if true then set forward to new image by increment the index
      });
    }
    if (_index + 1 < totalImg) // check more images is remain or not by indexes
      setState(() {
        _index = _index +
            1; // increment index value by one so user can forward to other remain images
      });
  }

  void _backwardImg() {
    if (_index - 1 >= 0) {
      //if value is less then 0 then it show error show we are checking the value
      setState(() {
        _selectedImageUrl = widget.imageUrls[_index -
            1]; // if upper condition is true then decrement the index value and show just backward image
        _index = _index - 1;
      });
    }
  }
}
