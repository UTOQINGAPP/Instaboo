/// A generic class to transport data between pages along with a title
class GeneralPageTransporter<T> {
  final String title;
  final T data;
  GeneralPageTransporter({required this.title, required this.data});
}
