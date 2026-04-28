import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/search_history/domain/usecases/search_history_usecases.dart';
import 'search_history_event.dart';
import 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final GetSearchHistoryUseCase getSearchHistory;
  final AddSearchQueryUseCase addSearchQuery;
  final DeleteSearchQueryUseCase deleteSearchQuery;
  final ClearSearchHistoryUseCase clearSearchHistory;

  SearchHistoryBloc({
    required this.getSearchHistory,
    required this.addSearchQuery,
    required this.deleteSearchQuery,
    required this.clearSearchHistory,
  }) : super(const SearchHistoryState()) {
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<AddSearchQuery>(_onAddSearchQuery);
    on<DeleteSearchQuery>(_onDeleteSearchQuery);
    on<ClearSearchHistoryEvent>(_onClearSearchHistory);
  }

  void _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<SearchHistoryState> emit,
  ) async {
    emit(state.copyWith(status: SearchHistoryStatus.loading));

    try {
      final history = await getSearchHistory();
      emit(
        state.copyWith(
          status: SearchHistoryStatus.loaded,
          searchHistory: history,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchHistoryStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onAddSearchQuery(
    AddSearchQuery event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      await addSearchQuery(event.query);
      add(LoadSearchHistory());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onDeleteSearchQuery(
    DeleteSearchQuery event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      await deleteSearchQuery(event.id);
      add(LoadSearchHistory());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onClearSearchHistory(
    ClearSearchHistoryEvent event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      await clearSearchHistory();
      emit(state.copyWith(searchHistory: []));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
