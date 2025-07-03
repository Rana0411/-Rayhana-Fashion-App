class OnboardingItemModel{
  final String imagePath; // مسار الصورة بتاعت الصفحة
  final String title;     // العنوان الرئيسي للصفحة
  final String description; // الشرح اللي تحت العنوان

  OnboardingItemModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}