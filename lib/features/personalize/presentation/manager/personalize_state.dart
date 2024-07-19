part of 'personalize_cubit.dart';

class PersonalizeState extends Equatable {
  final int pageIndex;
  final List<dynamic> formResults;
  final String username;
  final bool isParent;

  const PersonalizeState({
    this.pageIndex = 0,
    this.formResults = const [],
    this.username = "",
    this.isParent = false,
  });

  PersonalizeState copyWith({
    int? pageIndex,
    List<dynamic>? formResults,
    String? username,
    bool? isParent,
  }) {
    return PersonalizeState(
      pageIndex: pageIndex ?? this.pageIndex,
      formResults: formResults ?? this.formResults,
      username: username ?? this.username,
      isParent: isParent ?? this.isParent,
    );
  }

  @override
  List<Object> get props => [
        pageIndex,
        formResults,
        username,
        isParent,
      ];
}
