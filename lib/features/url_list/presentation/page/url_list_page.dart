import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../url_shortener/domain/models/url_alias.dart';
import '../cubit/url_list_cubit.dart';
import '../widgets/delete_confirmation_dialog.dart';
import '../widgets/url_searh_dialog.dart';

class UrlListPage extends StatelessWidget {
  const UrlListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UrlListCubit cubit = context.read();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('URL Shortener App'),
          actions: [
            IconButton(
              onPressed: () => _showDeleteConfirmationDialog(context, cubit),
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
    );
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
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        onChanged: cubit.onTextChanged,
        decoration: InputDecoration(
          hintText: 'Enter the link here',
          suffix: IconButton(
            iconSize: 25,
            icon: const Icon(Icons.send),
            onPressed: cubit.onShortUrlTap,
          ),
        ),
      ),
    );
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
                onTap: () {},
                contentPadding: EdgeInsets.zero,
                title: Text(item.alias),
                subtitle: Text(item.short),
                leading: const Icon(Icons.help_outline_rounded),
              );
            },
          ),
        );
      },
    );
  }
}