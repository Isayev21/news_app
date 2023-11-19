import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/views/home.dart';
import 'package:news_app/helper/category_news.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  const CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<Article> articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass categoryNewsClass = CategoryNewsClass();
    await categoryNewsClass.fetchCategoryNews(widget.category);
    articles = categoryNewsClass.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category[0].toUpperCase() + widget.category.substring(1),
          style: const TextStyle(
            color: Color.fromARGB(255, 27, 131, 216),
          ),
        ),
        elevation: 0.0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return NewsTile(
                          title: articles[index].title,
                          description: articles[index].description,
                          imageUrl: articles[index].urlToImage,
                          url: articles[index].url,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
