import 'package:Spark/shared/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PhotoViewer extends StatelessWidget {
  List<Widget> _photos;
  final _controller = PageController();

  PhotoViewer(Map<String,String> imageMap) {
    _photos = imageMap.map((name,url) { 
                return MapEntry(
                        name, 
                        CachedNetworkImage(
                          imageUrl: url,
                          placeholder: (context, url) => Loading(),
                          )
                        );
                }).values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Expanded(
            flex: 5,
            child: PageView(
              controller: _controller,
              children: _photos,
            ),
          ),
          //SizedBox(height:40),
          Container(
            //color: Colors.green,
              child: SmoothPageIndicator(
                controller: _controller,
                count: _photos.length,
                effect: WormEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 50),
        ],
      ),
    );
  }
}
