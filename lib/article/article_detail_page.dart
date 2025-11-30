import 'package:final_project/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/article/article_service.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF7F4F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:  EdgeInsets.fromLTRB(20, 40, 20, 20),
              decoration:  BoxDecoration(
                color: Color(0xFF4F3422),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                    ),
                    child: Container(
                      padding:  EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child:  Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                   SizedBox(height: 20),

                  // Title
                  Text(
                    article.title,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 12),

                  // Stats
                  Row(
                    children:  [
                      Icon(Icons.star, color: Colors.white, size: 20),
                      SizedBox(width: 6),
                      Text("4.5", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 12),
                      Icon(Icons.remove_red_eye, color: Colors.white, size: 22),
                      SizedBox(width: 6),
                      Text("200K", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 12),
                      Icon(Icons.comment, color: Colors.white, size: 20),
                      SizedBox(width: 6),
                      Text("23", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                   SizedBox(height: 18),

                  // Profile + Follow
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                       SizedBox(width: 10),
                       Text(
                        "By Author",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                       Spacer(),
                      Container(
                        padding:  EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children:  [
                            Text(
                              "Follow",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.add, size: 18, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content dari Article
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.content,
                    style:  TextStyle(fontSize: 16, height: 1.5),
                  ),
                   SizedBox(height: 22),
                  ClipRRect(
                    borderRadius:  BorderRadius.all(Radius.circular(25)),
                    child: Image.network(
                      article.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
