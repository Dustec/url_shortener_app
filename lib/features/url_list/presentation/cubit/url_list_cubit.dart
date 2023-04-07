import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/errors/errors.dart';
import '../../../url_shortener/domain/models/url_alias.dart';
import '../../../url_shortener/domain/repositories.dart/url_shortener_repository.dart';
import '../../domain/ui_errors.dart';
import 'snack_bar_handler.dart';

part 'url_list_cubit.freezed.dart';

class UrlListCubit extends Cubit<UrlListState> {
  UrlListCubit({
    required UrlShortenerRepository urlShortenerRepository,
    required SnackBarHandler snackBarHandler,
  })  : _urlRepo = urlShortenerRepository,
        _snackBarHandler = snackBarHandler,
        super(UrlListState(showFullLoader: true)) {
    _initialize();
  }

  final UrlShortenerRepository _urlRepo;
  final SnackBarHandler _snackBarHandler;

  final List<StreamSubscription> _subscriptions = List.empty(growable: true);
  String _text = '';

  @override
  Future<void> close() {
    for (StreamSubscription subscription in _subscriptions) {
      subscription.cancel();
    }
    return super.close();
  }

  void _initialize() {
    final StreamSubscription subscription = _urlRepo.getSavedUrls().listen(
          (List<UrlAlias> list) {
            emit(state.copyWith(recentUrlsList: list));
          },
          onError: _handleError,
          onDone: () {
            emit(state.copyWith(showFullLoader: false));
          },
        );
    _subscriptions.add(subscription);
  }

  void onTextChanged(String? value) {
    _text = value?.trim() ?? '';
  }

  void onShortUrlTap() {
    if (state.isLoading) {
      return;
    }
    if (_text.isEmpty) {
      _handleError(TextFieldEmptyError());
      return;
    }
    emit(state.copyWith(isLoading: true));
    final StreamSubscription subscription = _urlRepo.shortUrl(_text).listen(
          (List<UrlAlias> list) {
            emit(state.copyWith(recentUrlsList: list));
          },
          onError: _handleError,
          onDone: () {
            emit(state.copyWith(isLoading: false));
          },
        );
    _subscriptions.add(subscription);
  }

  void deleteRecentUrls({
    required Future<bool?> Function() showConfirmationDialog,
  }) {
    showConfirmationDialog().then((bool? result) {
      if (result != true) {
        return;
      }
      _urlRepo.clearRecentUrls();
      emit(state.copyWith(recentUrlsList: []));
    });
  }

  void searchAlias({
    required Future<String?> Function() showSearchDialog,
  }) {
    showSearchDialog().then((String? alias) {
      if ((alias ?? '').isEmpty) {
        return;
      }
      emit(state.copyWith(showFullLoader: true));
      final StreamSubscription subscription =
          _urlRepo.getUrlByAlias(alias!).listen(
                (List<UrlAlias> list) {
                  emit(state.copyWith(recentUrlsList: list));
                },
                onError: _handleError,
                onDone: () {
                  emit(state.copyWith(showFullLoader: false));
                },
              );
      _subscriptions.add(subscription);
    });
  }

  void _handleError(Object? error) {
    if (error is TextFieldEmptyError) {
      //  handle error here
      print('TextFieldEmptyError');
      _snackBarHandler.showSnackBar('Link is empty.');
    }
    if (error is UrlAliasNotFound) {
      //  handle error here
      print('UrlAliasNotFound');
      _snackBarHandler.showSnackBar('Link was not found.');
    }
    if (error is UrlAliasAlreadySaved) {
      //  handle error here
      print('UrlAliasAlreadySaved');
      _snackBarHandler.showSnackBar('Link was already in the list.');
    }
  }
}

@freezed
class UrlListState with _$UrlListState {
  factory UrlListState({
    @Default(false) bool isLoading,
    @Default(false) bool showFullLoader,
    @Default(<UrlAlias>[]) List<UrlAlias> recentUrlsList,
  }) = _UrlListState;
}
