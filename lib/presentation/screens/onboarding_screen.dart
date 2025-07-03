import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/onboarding_model.dart';
import '../../generated/assets.dart'; // عشان نتحكم في شريط الحالة اللي فوق
 // نعمل import للموديل
 // نعمل import للبيانات اللي عملناها

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
  static const routeName ='onboardingScreen';
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0); // ده اللي بيتحكم في الـ PageView
  int _currentPage = 0;// بيخزن رقم الصفحة اللي احنا فيها حالياً

  final List<OnboardingItemModel> onboardingPages = [
    OnboardingItemModel(
      imagePath: Assets.imagesImagePageview2, // Make sure this path is correct
      title: 'Choose Products',
      description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingItemModel(
      imagePath: Assets.imagesImagePageview2, // Make sure this path is correct
      title: 'Make Payment',
      description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingItemModel(
      imagePath: Assets.imagesImagePageview3, // Make sure this path is correct
      title: 'Get Your Order',
      description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose(); // مهم أوي نعمل dispose للـ controller لما الشاشة تتقفل
    super.dispose();
  }

  // ويجيت صغير عشان يعمل النقط اللي تحت بتاعت مؤشر الصفحات
  Widget _buildPageIndicator(int index) {
    return Container(
      width: _currentPage == index ? 24 : 8, // النقطة النشطة تبقى أطول شوية
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey[300], // لون النقطة النشطة وغير النشطة
        borderRadius: BorderRadius.circular(4), // عشان تبقى شكلها بيضاوي/دائري
      ),
    );
  }

  // ويجيت عشان يعمل محتوى صفحة واحدة من صفحات الـ onboarding
  Widget _buildOnboardingPage(OnboardingItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى عمودياً
        children: [
          Image.asset(
            item.imagePath, // مسار الصورة من الموديل
            height: 250, // حجم الصورة
          ),
          SizedBox(height: 40), // مسافة فاضية
          Text(
            item.title, // العنوان من الموديل
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center, // توسيط النص
          ),
          SizedBox(height: 16),
          Text(
            item.description, // الشرح من الموديل
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // اختياري: عشان نخفي شريط الحالة اللي فوق ونخلي الشاشة شكلها أحلى
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // شريط حالة شفاف
      statusBarIconBrightness: Brightness.dark, // الأيقونات اللي فيه تبقى غامقة (زي الساعة والبطارية)
    ));

    return Scaffold(
      body: Stack( // بنستخدم Stack عشان نحط عناصر فوق بعض (زي الزراير والـ PageView)
        children: [
          // ده الـ PageView نفسه اللي بيوريني الصفحات وبتتنقل بينها
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length, // عدد الصفحات هو عدد العناصر في اللستة بتاعتنا
            onPageChanged: (int page) { // لما الصفحة تتغير (لما تسحبي)
              setState(() {
                _currentPage = page; // بنحدث رقم الصفحة الحالية
              });
            },
            itemBuilder: (context, index) { // ده اللي بيبني محتوى كل صفحة
              return _buildOnboardingPage(onboardingPages[index]); // بنجيب بيانات الصفحة من اللستة
            },
          ),
          // الشريط اللي فوق (الساعة، رقم الصفحة، Skip)
          Positioned(
            top: 40, // بعد عن فوق
            left: 20, // بعد عن الشمال
            right: 20, // بعد عن اليمين
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // يخلي العناصر متوزعة على الطرفين
              children: [
                Text(
                  '9:41', // أو تستخدمي مكتبة تجيب الوقت الحقيقي
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_currentPage + 1}/${onboardingPages.length}', // بيعرض 1/3, 2/3 وهكذا
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                GestureDetector( // عشان نعمل زرار الـ Skip
                  onTap: () {
                    // هنا هتكتبي الكود اللي ينقلك للشاشة الرئيسية بتاعت التطبيق
                    print('تم الضغط على تخطي');
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // عناصر التحكم اللي تحت (النقط، Prev/Next/Get Started)
          Positioned(
            bottom: 30, // بعد عن تحت
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // بيوزع العناصر على الطرفين
              children: [
                // زرار Prev (يظهر بس لو مش في أول صفحة)
                _currentPage > 0
                    ? GestureDetector(
                  onTap: () {
                    _pageController.previousPage( // يرجع للصفحة اللي قبلها
                      duration: Duration(milliseconds: 300), // مدة الحركة
                      curve: Curves.easeIn, // شكل حركة الرجوع
                    );
                  },
                  child: Text(
                    'السابق',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(width: 50), // حاطين مسافة فاضية عشان الحجم ما يتغيرش لما الزرار يختفي

                // مؤشرات الصفحات (النقط)
                Row(
                  children: List.generate(
                    onboardingPages.length,
                        (index) => _buildPageIndicator(index), // بيبني النقط ديناميكياً
                  ),
                ),

                // زرار Next أو Get Started (حسب لو دي آخر صفحة)
                _currentPage == onboardingPages.length - 1 // لو احنا في آخر صفحة
                    ? GestureDetector(
                  onTap: () {
                    // هنا هتكتبي الكود اللي ينقلك للشاشة الرئيسية بتاعت التطبيق
                    print('تم الضغط على ابدأ الآن');
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    'ابدأ الآن',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : GestureDetector( // لو مش آخر صفحة بيعرض Next
                  onTap: () {
                    _pageController.nextPage( // ينقل للصفحة اللي بعدها
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text(
                    'التالي',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}