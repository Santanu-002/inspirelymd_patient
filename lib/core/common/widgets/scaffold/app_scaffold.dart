import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final bool? centerTitle;
  final double? titleSpacing;
  final VoidCallback? onBackPressed;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final bool useScrollView;
  final Widget? footer;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;

  const AppScaffold({
    super.key,
    required this.child,
    this.title,
    this.titleWidget,
    this.centerTitle,
    this.titleSpacing,
    this.onBackPressed,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.useScrollView = true,
    this.footer,
    this.drawer,
    this.endDrawer,
    this.leading,
    this.padding,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Custom back / leading button styling
    Widget? leadingWidget;
    if (leading != null) {
      leadingWidget = leading;
    } else if (onBackPressed != null ||
        (automaticallyImplyLeading && (ModalRoute.of(context)?.canPop ?? false))) {
      leadingWidget = IconButton(
        onPressed: onBackPressed ?? Get.back,
        icon: Icon(
          AppIcons.common.back,
          color: theme.colorScheme.onSurface,
          size: 20,
        ),
      );
    }

    final EdgeInsets defaultPadding = (padding as EdgeInsets?) ??
        EdgeInsets.all(AppUIConstants.spacing.containerPadding);

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        drawer: drawer,
        endDrawer: endDrawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: (title != null || titleWidget != null || leadingWidget != null || actions != null)
            ? AppBar(
                backgroundColor: theme.scaffoldBackgroundColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                titleSpacing: titleSpacing,
                centerTitle: centerTitle ?? true,
                title: titleWidget ?? (title != null ? Text(title!) : null),
                systemOverlayStyle: theme.brightness == Brightness.light
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light,
                actions: actions,
                automaticallyImplyLeading: false,
                leading: leadingWidget,
              )
            : null,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: useScrollView
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: defaultPadding,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight - defaultPadding.vertical,
                              ),
                              child: child,
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: defaultPadding,
                        child: child,
                      ),
              ),
              if (footer != null)
                Padding(
                  padding: defaultPadding,
                  child: footer!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
