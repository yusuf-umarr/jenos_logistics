// ignore_for_file: public_member_api_docs, sort_constructors_first
/// This class defines the HomeState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class HomeState {
  final bool isShowPop;

  /// Constructs a [HomeState] instance.
  HomeState({
    required this.isShowPop,
  });

  /// Constructs an initial [HomeState] with default values.
  factory HomeState.initial() {
    return HomeState(isShowPop: true);
  }



  HomeState copyWith({
    bool? isShowPop,
  }) {
    return HomeState(
      isShowPop: isShowPop ?? this.isShowPop,
    );
  }
}
