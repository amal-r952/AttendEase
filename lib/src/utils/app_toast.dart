import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class AppToasts {
  static TextStyle _titleStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          );

  static TextStyle _descriptionStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          );

  static Color _backgroundColor(BuildContext context) =>
      Theme.of(context).cardColor;

  static Color _shadowColor(BuildContext context) =>
      Theme.of(context).shadowColor;

  // Success Toasts
  static void showSuccessToastTop(BuildContext context, String message) {
    CherryToast.success(
      title: Text('Success', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showSuccessToastBottom(BuildContext context, String message) {
    CherryToast.success(
      title: Text('Success', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }

  // Error Toasts
  static void showErrorToastTop(BuildContext context, String message) {
    CherryToast.error(
      title: Text('Error', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showErrorToastBottom(BuildContext context, String message) {
    CherryToast.error(
      title: Text('Error', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }

  // Warning Toasts
  static void showWarningToastTop(BuildContext context, String message) {
    CherryToast.warning(
      title: Text('Warning', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showWarningToastBottom(BuildContext context, String message) {
    CherryToast.warning(
      title: Text('Warning', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }

  // Info Toasts
  static void showInfoToastTop(BuildContext context, String message) {
    CherryToast.info(
      title: Text('Info', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showInfoToastBottom(BuildContext context, String message) {
    CherryToast.info(
      title: Text('Info', style: _titleStyle(context)),
      backgroundColor: _backgroundColor(context),
      shadowColor: _shadowColor(context),
      displayIcon: true,
      description: Text(message,
          textAlign: TextAlign.center, style: _descriptionStyle(context)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }
}
