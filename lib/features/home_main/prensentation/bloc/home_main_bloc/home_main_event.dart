abstract class HomeMainEvent {}

class HomeMainNavTabChanged extends HomeMainEvent {
  final int index;
  HomeMainNavTabChanged(this.index);
}