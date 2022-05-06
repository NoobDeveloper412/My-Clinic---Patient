import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/Service/blogPostService.dart';
import 'package:demopatient/Screen/blogPost/showBlogPostPage.dart';

class BlogPostPage extends StatefulWidget {
  @override
  _BlogPostPageState createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  int _limit = 20;
  int _itemLength = 0;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    _scrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    return Stack(
      //overflow: Overflow.visible,
      children: <Widget>[
        CAppBarWidget(title: 'Health Blog'),
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: IBoxDecoration.upperBoxDecoration(),
            child: FutureBuilder(
                future:
                    BlogPostService.getData(_limit), //fetch all service details
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return snapshot.data.length == 0
                        ? NoDataWidget()
                        : buildListView(snapshot.data);
                  else if (snapshot.hasError)
                    return IErrorWidget(); //if any error then you can also use any other widget here
                  else
                    return LoadingIndicatorWidget();
                }),
          ),
        ),
      ],
    );
  }

  Widget buildListView(blogPost) {
    _itemLength = blogPost.length;
    return ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 8),
        itemCount: blogPost.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowBlogPostPage(
                              body: blogPost[index].body,
                              title: blogPost[index].title,
                              thumbUrl: blogPost[index].thumbImageUrl)),
                    );
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 5, right: 5, top: 0),

                    leading: imageBox(blogPost[index].thumbImageUrl),
                    title: Text(
                      "${blogPost[index].title}",
                      style: TextStyle(
                        fontFamily: 'OpenSans-SemiBold',
                        fontSize: 14,
                      ),
                    ),
                    //         DateFormat _dateFormat = DateFormat('y-MM-d');
                    // String formattedDate =  _dateFormat.format(dateTime);
                    subtitle:
                        Text("Updated at ${blogPost[index].updatedTimeStamp}"),
                    //  isThreeLine: true,
                  ),
                ),
                Divider()
              ],
            ),
          );
        });
  }

  Widget imageBox(String imageUrl) {
    return Container(
        width: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: ImageBoxFillWidget(imageUrl: imageUrl),
        ));
  }

  void _scrollListener() {
    _scrollController.addListener(() {
      // print("blength $_itemLength $_limit");
      //print("length $_itemLength $_limit");
      if (_itemLength >= _limit) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _limit += 20;
          });
        }
      }
      // print(_scrollController.offset);
    });
  }
}
