import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_icon_button.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String? titleText;
  final Widget? title;
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
  final double? leadingWidth;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    super.key,
    required this.child,
    this.titleText,
    this.title,
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
    this.leadingWidth,
    this.padding,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset = true,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Custom back / leading button styling
    Widget? leadingWidget;
    if (leading != null) {
      leadingWidget = leading;
    } else if (onBackPressed != null ||
        (automaticallyImplyLeading &&
            (ModalRoute.of(context)?.canPop ?? false))) {
      leadingWidget = AppIconButton.ghost(
        icon: AppIcons.common.back,
        iconColor: theme.colorScheme.onSurface,
        iconSize: 20,
        onPressed: onBackPressed ?? Get.back,
      );
    }

    final EdgeInsets defaultPadding =
        (padding as EdgeInsets?) ??
        EdgeInsets.all(AppUIConstants.spacing.containerPadding);

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
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
        bottomNavigationBar: bottomNavigationBar,
        appBar:
            (titleText != null ||
                title != null ||
                leadingWidget != null ||
                actions != null)
            ? AppBar(
                backgroundColor: theme.scaffoldBackgroundColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                titleSpacing: titleSpacing ?? 0.0,
                centerTitle: centerTitle ?? false,
                title: title ?? (titleText != null ? Text(titleText!) : null),
                systemOverlayStyle: theme.brightness == Brightness.light
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light,
                actions: actions != null
                    ? [
                        ...actions!,
                        SizedBox(width: AppUIConstants.spacing.space$12),
                      ]
                    : null,
                automaticallyImplyLeading: false,
                leading: leadingWidget,
                leadingWidth: leadingWidth,
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
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: defaultPadding,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight:
                                    constraints.maxHeight -
                                    defaultPadding.vertical,
                              ),
                              child: child,
                            ),
                          );
                        },
                      )
                    : Padding(padding: defaultPadding, child: child),
              ),
              if (footer != null)
                Padding(padding: defaultPadding, child: footer!),
            ],
          ),
        ),
      ),
    );
  }
}
