// ignore_for_file: public_member_api_docs, sort_constructors_first
/// This class defines the NavBarState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class NavBarState {
  final int currentIndex;

  /// Constructs a [NavBarState] instance.
  NavBarState({
    required this.currentIndex,
  });

  /// Constructs an initial [NavBarState] with default values.
  factory NavBarState.initial() {
    return NavBarState(currentIndex: 0);
  }

  NavBarState copyWith({
    int? currentIndex,
  }) {
    return NavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
