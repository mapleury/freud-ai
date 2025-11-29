import 'package:flutter/material.dart';
import 'package:final_project/article/article_service.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              decoration: const BoxDecoration(
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
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Stats
                  Row(
                    children: const [
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
                  const SizedBox(height: 18),

                  // Profile + Follow
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "By Author",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: const [
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

            // ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.content,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 22),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
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
