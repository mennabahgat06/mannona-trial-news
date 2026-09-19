import 'package:flutter/material.dart';
import 'package:mannona_news/features/location_screen/location_screen.dart';
import '../../../../core/utils/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D4ED8),
      body: Stack(
        children: [
          // النصف العلوي: رسم ومظهر ناطحات السحاب المأخوذة من التصميم
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            height: 340,
            child: Center(
              child: SizedBox(
                width: 260,
                height: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // مبنى يسار أصفر
                    Positioned(
                      left: 10,
                      bottom: 0,
                      child: Container(
                        width: 50,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 8)
                          ],
                        ),
                      ),
                    ),
                    // مبنى خلفي رمادي مزرق
                    Positioned(
                      right: 15,
                      bottom: 0,
                      child: Container(
                        width: 65,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFF334155),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // المبنى الأزرق الأوسط الطويل
                    Positioned(
                      left: 70,
                      bottom: 0,
                      child: Container(
                        width: 75,
                        height: 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFF60A5FA),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 12,
                                offset: Offset(0, 4))
                          ],
                        ),
                      ),
                    ),
                    // مبنى أمامي أزرق داكن
                    Positioned(
                      right: 50,
                      bottom: 0,
                      child: Container(
                        width: 65,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // النصف السفلي: بطاقة بيضاء منحنية
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Get The Latest News\nAnd Updates',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'From Politics to Entertainment: Your One-\nStop Source for Comprehensive Coverage\nof the Latest News and Developments\nAcross the Glob will be right on your hand.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textGrey,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 160,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationSearchScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Explore',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward,
                              size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
