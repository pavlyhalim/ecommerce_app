import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); // البداية من الصفحة الأولى

  void navigateTo(int index) {
    emit(index); // تغيير حالة الصفحة الحالية إلى الصفحة الجديدة
  }
}
