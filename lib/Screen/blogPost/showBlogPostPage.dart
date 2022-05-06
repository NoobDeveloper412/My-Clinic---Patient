import 'dart:convert';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:http/http.dart' as http;

class ShowBlogPostPage extends StatefulWidget {
  final body;
  final title;
  final String thumbUrl;

  ShowBlogPostPage({this.body, this.title, this.thumbUrl});
  @override
  _ShowBlogPostPageState createState() => _ShowBlogPostPageState();
}

class _ShowBlogPostPageState extends State<ShowBlogPostPage> {
  bool _isLoading = false;
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _getDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //   appBar:_isLoading? AppBar(
        //   title: Text(widget.title,style: kAppbarTitleStyle,),
        //   backgroundColor: appBarColor,
        // ):null,
        body: _isLoading
            ? LoadingIndicatorWidget()
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      backgroundColor: appBarColor,
                      pinned: false,
                      snap: false,
                      floating: false,
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                          background:
                              ImageBoxFillWidget(imageUrl: widget.thumbUrl))),
                  SliverToBoxAdapter(
                      child: QuillEditor(
                          controller: _controller,
                          scrollController: ScrollController(),
                          scrollable: true,
                          focusNode: _focusNode,
                          autoFocus: true,
                          readOnly: true,
                          expands: false,
                          showCursor: false,
                          padding: EdgeInsets.all(8))),
                ],
              ));
  }

  void _getDoc() async {
    //print(widget.blogPost.body);
    setState(() {
      _isLoading = true;
    });
    final _viewUrl = widget.body;
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      var myJSON = jsonDecode(response.body);
      setState(() {
        _controller = QuillController(
            document: Document.fromJson(myJSON),
            selection: TextSelection.collapsed(offset: 0));
        _isLoading = false;
      });
    }
    // print("Data ${res[0].body}");
  }
}
