import 'package:challenge_3/constants.dart';
import 'package:challenge_3/models/movie_popular_model.dart';
import 'package:challenge_3/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class ScrollWithTitleView extends StatelessWidget {
  final AsyncSnapshot<List<MovieModel>> movieList;
  final String title;
  final bool? subTitle;
  final double height;
  final double width;

  const ScrollWithTitleView({
    super.key,
    required this.movieList,
    required this.title,
    this.subTitle = false,
    this.height = 200,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: subTitle == true ? height + 90 : height + 20,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movieList.data!.length,
            padding: const EdgeInsets.all(
              10,
            ),
            itemBuilder: (context, index) {
              var movie = movieList.data![index];
              var tag = title + movie.id.toString();
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(movie: movie, tag: tag),
                    ),
                  )
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: tag,
                      child: Container(
                        width: width,
                        height: height,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(5, 5),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Image.network(
                          Constants.makeImagePath(movie.posterPath),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    if (subTitle == true)
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: width,
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
          ),
        ),
      ],
    );
  }
}
