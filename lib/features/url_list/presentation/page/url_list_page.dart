import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_app/features/url_list/presentation/widgets/url_info_dialog.dart';

import '../../../url_shortener/domain/models/url_alias.dart';
import '../cubit/url_list_cubit.dart';
import '../widgets/delete_confirmation_dialog.dart';
import '../widgets/url_searh_dialog.dart';

class UrlListPage extends StatelessWidget {
  const UrlListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UrlListCubit cubit = context.read();
    return BlocBuilder<UrlListCubit, UrlListState>(
        buildWhen: (UrlListState current, UrlListState prev) =>
            current.showFullLoader != prev.showFullLoader,
        builder: (BuildContext context, UrlListState state) {
          return Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('URL Shortener App'),
                    actions: [
                      IconButton(
                        onPressed: () =>
                            _showDeleteConfirmationDialog(context, cubit),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  body: Column(
                    children: const <Widget>[
                      _InputField(),
                      _ListView(),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => _showSearchDialog(context, cubit),
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
              if (state.showFullLoader)
                Positioned.fill(
                    child: Container(
                  color: Colors.black26,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )),
            ],
          );
        });
  }

  _showDeleteConfirmationDialog(BuildContext context, UrlListCubit cubit) {
    cubit.deleteRecentUrls(
      showConfirmationDialog: () => showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return const DeleteConfirmationDialog();
          }),
    );
  }

  void _showSearchDialog(BuildContext context, UrlListCubit cubit) {
    cubit.searchAlias(
      showSearchDialog: () => showDialog<String?>(
          context: context,
          builder: (BuildContext context) {
            return const UrlSearchDialog();
          }),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UrlListCubit cubit = context.read();
    return BlocBuilder<UrlListCubit, UrlListState>(
        builder: (BuildContext context, UrlListState state) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                key: const ValueKey<String>('UrlTextField'),
                onChanged: cubit.onTextChanged,
                decoration: const InputDecoration(
                  hintText: 'Enter the link here',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: state.isLoading
                  ? Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(),
                    )
                  : IconButton(
                      key: const ValueKey<String>('ShortUrlButton'),
                      iconSize: 25,
                      icon: const Icon(Icons.send),
                      onPressed: cubit.onShortUrlTap,
                    ),
            ),
          ],
        ),
      );
    });
  }
}

class _ListView extends StatelessWidget {
  const _ListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UrlListCubit, UrlListState>(
      builder: (BuildContext context, UrlListState state) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: state.recentUrlsList.length,
            itemBuilder: (context, index) {
              final UrlAlias item = state.recentUrlsList[index];
              return ListTile(
                onTap: () => _showInfoDialog(context, item),
                contentPadding: EdgeInsets.zero,
                title: Text(item.alias),
                subtitle: Text(
                  item.short,
                  style: const TextStyle(fontSize: 14),
                ),
                leading: const Icon(Icons.help_outline_rounded),
              );
            },
          ),
        );
      },
    );
  }

  void _showInfoDialog(BuildContext context, UrlAlias item) {
    showDialog(
      context: context,
      builder: (context) {
        return UrlInfoDialog(urlAlias: item);
      },
    );
  }
}
