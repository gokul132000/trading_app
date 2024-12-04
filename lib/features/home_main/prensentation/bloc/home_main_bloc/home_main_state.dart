abstract class HomeMainState {
  final int currentIndex;
  const HomeMainState(this.currentIndex);
}

class HomeMainInitial extends HomeMainState {
  const HomeMainInitial() : super(0);
}

class HomeMainNavChanged extends HomeMainState {
  const HomeMainNavChanged(int currentIndex) : super(currentIndex);
}