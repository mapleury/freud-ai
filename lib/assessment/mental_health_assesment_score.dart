import 'package:flutter/material.dart';
import 'package:final_project/article/article_detail_page.dart';
import 'package:final_project/article/article_service.dart';
import 'package:final_project/assessment/widgets/swipeable_button.dart';
import 'package:final_project/assessment/assesment_service.dart';
import 'package:final_project/assessment/assesment_model.dart';

class AssessmentResultView extends StatefulWidget {
  final bool physicalDistress;
  final int stressLevel;
  final String? goal;
  final String? gender;
  final int? age;
  final double? moodValue;
  final double? stressLevelAnswer;

  const AssessmentResultView({
    super.key,
    required this.physicalDistress,
    required this.stressLevel,
    this.goal,
    this.gender,
    this.age,
    this.moodValue,
    this.stressLevelAnswer,
  });

  @override
  State<AssessmentResultView> createState() => _AssessmentResultViewState();
}

class _AssessmentResultViewState extends State<AssessmentResultView> {
  int? fetchedScore;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadLatestScore();
  }

  Future<void> _loadLatestScore() async {
    final AssessmentModel? data = await AssessmentService()
        .getLatestAssessment();

    setState(() {
      fetchedScore = data?.score;
      loading = false;
    });
  }

  int getCalculatedScore() {
    return widget.stressLevel + (widget.physicalDistress ? 2 : 0);
  }

  String getBackground(int score) {
    if (score <= 5) return 'assets/mental-health-assessment1.png';
    if (score <= 8) return 'assets/mental-health-assessment2.png';
    return 'assets/mental-health-assessment3.png';
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return  Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    final int score = fetchedScore ?? getCalculatedScore();
    final bool highStress = score > 5;

    final article = highStress
        ? ArticleService.sampleArticles[1]
        : ArticleService.sampleArticles[0];

    final description = highStress
        ? 'Your stress level is high. Consider taking a break and practicing relaxation techniques.'
        : 'You are managing stress well. Keep it up!';

    final Color scoreColor = highStress ? Colors.red : Colors.green;
    final IconData feelingIcon = highStress
        ? Icons.sentiment_dissatisfied
        : Icons.sentiment_satisfied;
    final String feelingText = highStress ? 'Stressed' : 'Calm';
    final int suggestionsCount = highStress ? 5 : 2;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getBackground(score)),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  "Your Freud Score",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                 SizedBox(height: 30),
                CircleScore(score: score, mainColor: scoreColor),

                 SizedBox(height: 30),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),

                 SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                     SizedBox(width: 6),
                    Text(
                      "$suggestionsCount AI suggestions",
                      style:  TextStyle(color: Colors.white, fontSize: 16),
                    ),
                     SizedBox(width: 20),
                    Icon(feelingIcon, color: Colors.white, size: 18),
                     SizedBox(width: 6),
                    Text(
                      feelingText,
                      style:  TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),

                 SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: SwipeableButton(
                    text: 'Swipe for Mindful Tips',
                    onComplete: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArticleDetailPage(article: article),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget CircleScore({required int score, required Color mainColor}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 340,
        height: 340,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      Container(
        width: 310,
        height: 310,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.95),
        ),
        alignment: Alignment.center,
        child: Text(
          "$score",
          style: TextStyle(
            fontSize: 100,
            fontFamily: 'Urbanist',
            color: mainColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    ],
  );
}
