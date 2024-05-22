import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_snack_bar.dart';
import 'snack_bars/snack_bars_cubit.dart';

class SnackBarService extends StatefulWidget {
  final Widget child;
  final Stream<SnackMessage> snackMessageStream;

  const SnackBarService({
    super.key,
    required this.child,
    required this.snackMessageStream,
  });

  @override
  State<SnackBarService> createState() => _SnackBarServiceState();
}

class _SnackBarServiceState extends State<SnackBarService> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<AppSnack> _snackBars = [];

  void _addItem(AppSnack snack) {
    _snackBars.insert(0, snack);
    _listKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 300));
  }

  void _removeItem(AppSnack snack) {
    final index = _snackBars.indexOf(snack);
    _listKey.currentState!.removeItem(
      index,
      (_, animation) {
        return SlideTransition(
          key: UniqueKey(),
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: AppSnackBar(
                entity: snack,
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );

    _snackBars.removeAt(index);
  }

  @override
  void initState() {
    super.initState();
    widget.snackMessageStream.listen((event) {
      if (event.adding) {
        _addItem(event.snack);
      } else if (event.removing) {
        _removeItem(event.snack);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
                maxHeight: 600,
              ),
              child: AnimatedList(
                key: _listKey,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                initialItemCount: _snackBars.length,
                itemBuilder: (_, index, animation) {
                  animation = animation.drive(Tween(begin: 0.0, end: 1.0)
                      .chain(CurveTween(curve: Curves.easeInOut)));
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SlideTransition(
                      key: UniqueKey(),
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: ScaleTransition(
                        scale: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: AppSnackBar(
                            entity: _snackBars[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                reverse: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
