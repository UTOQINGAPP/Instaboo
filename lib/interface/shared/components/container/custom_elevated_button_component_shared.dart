import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Custom ElevatedButton clone that works correctly on Windows desktop.
///
/// Does not use the built-in [ElevatedButton] widget. Built from [Material],
/// [InkWell], and [MouseRegion] so the cursor switches to [SystemMouseCursors.click]
/// on hover when enabled. Use this instead of [ElevatedButton] on desktop to avoid
/// cursor and hover issues.
///
/// Clon de [ElevatedButton] compatible con Windows. No usa el widget [ElevatedButton].
/// Construido con [Material], [InkWell] y [MouseRegion] para que el cursor cambie
/// correctamente al hacer hover.
class CustomElevatedButtonComponentShared extends StatefulWidget {
  /// Creates a custom elevated button.
  /// Crea un botón elevado personalizado.
  const CustomElevatedButtonComponentShared({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior,
    this.statesController,
    required this.child,
  })  : _isIconVariant = false,
        icon = null,
        label = null,
        iconAlignment = null;

  /// Creates a custom elevated button with an [icon] and [label].
  /// Crea un botón elevado con [icon] y [label].
  const CustomElevatedButtonComponentShared.icon({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.icon,
    required Widget this.label,
    this.iconAlignment,
  })  : _isIconVariant = true,
        child = label;

  final bool _isIconVariant;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;
  final Widget child;
  final Widget? icon;
  final Widget? label;
  final IconAlignment? iconAlignment;

  bool get enabled => onPressed != null || onLongPress != null;

  @override
  State<CustomElevatedButtonComponentShared> createState() =>
      _CustomElevatedButtonComponentSharedState();
}

class _CustomElevatedButtonComponentSharedState
    extends State<CustomElevatedButtonComponentShared> {
  WidgetStatesController? _internalStatesController;

  WidgetStatesController get _statesController =>
      widget.statesController ?? _internalStatesController!;

  void _handleStatesControllerChange() {
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.statesController == null) {
      _internalStatesController = WidgetStatesController();
    }
    _statesController.update(WidgetState.disabled, !widget.enabled);
    _statesController.addListener(_handleStatesControllerChange);
  }

  @override
  void didUpdateWidget(covariant CustomElevatedButtonComponentShared oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.statesController != oldWidget.statesController) {
      oldWidget.statesController?.removeListener(_handleStatesControllerChange);
      if (oldWidget.statesController == null) {
        _internalStatesController?.dispose();
        _internalStatesController = null;
      }
      if (widget.statesController == null) {
        _internalStatesController = WidgetStatesController();
      }
      _statesController.update(WidgetState.disabled, !widget.enabled);
      _statesController.addListener(_handleStatesControllerChange);
    } else if (widget.enabled != oldWidget.enabled) {
      _statesController.update(WidgetState.disabled, !widget.enabled);
      if (!widget.enabled) {
        _statesController.update(WidgetState.pressed, false);
      }
    }
  }

  @override
  void dispose() {
    _statesController.removeListener(_handleStatesControllerChange);
    _internalStatesController?.dispose();
    super.dispose();
  }

  ButtonStyle _defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    if (theme.useMaterial3) {
      return ElevatedButton.styleFrom(
        backgroundColor: cs.surfaceContainerLow,
        foregroundColor: cs.primary,
        disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
        shadowColor: cs.shadow,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        minimumSize: const Size(64, 40),
        maximumSize: Size.infinite,
        shape: const StadiumBorder(),
        textStyle: theme.textTheme.labelLarge,
        enableFeedback: true,
        alignment: Alignment.center,
      );
    }
    return ElevatedButton.styleFrom(
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
      shadowColor: theme.shadowColor,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      minimumSize: const Size(64, 36),
      maximumSize: Size.infinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: theme.textTheme.labelLarge,
      enableFeedback: true,
      alignment: Alignment.center,
    );
  }

  /// Merges default, theme and widget style so that [widget.style] has
  /// highest priority. [ButtonStyle.merge] only fills null fields in the
  /// receiver, so we must merge with widget.style as base when provided.
  ///
  /// Fusiona estilo por defecto, del tema y del widget para que [widget.style]
  /// tenga prioridad. [ButtonStyle.merge] solo rellena campos null en el
  /// receptor, por eso usamos widget.style como base cuando se proporciona.
  ButtonStyle _mergedStyle(BuildContext context) {
    final ButtonStyle defaultStyle = _defaultStyleOf(context);
    final ButtonStyle? themeStyle = ElevatedButtonTheme.of(context).style;
    final ButtonStyle baseWithTheme =
        themeStyle != null ? defaultStyle.merge(themeStyle) : defaultStyle;
    if (widget.style != null) {
      return widget.style!.merge(baseWithTheme);
    }
    return baseWithTheme;
  }

  T? _resolveState<T>(
    ButtonStyle merged,
    WidgetStateProperty<T>? Function(ButtonStyle? s) getProp,
  ) {
    return getProp(merged)?.resolve(_statesController.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonStyle merged = _mergedStyle(context);

    final double? resolvedElevation =
        _resolveState<double?>(merged, (s) => s?.elevation);
    final Color? resolvedBackgroundColor =
        _resolveState<Color?>(merged, (s) => s?.backgroundColor);
    final Color? resolvedForegroundColor =
        _resolveState<Color?>(merged, (s) => s?.foregroundColor);
    final Color? resolvedShadowColor =
        _resolveState<Color?>(merged, (s) => s?.shadowColor);
    final Color? resolvedSurfaceTintColor =
        _resolveState<Color?>(merged, (s) => s?.surfaceTintColor);
    final EdgeInsetsGeometry? resolvedPadding =
        _resolveState<EdgeInsetsGeometry?>(merged, (s) => s?.padding);
    final Size? resolvedMinimumSize =
        _resolveState<Size?>(merged, (s) => s?.minimumSize);
    final Size? resolvedMaximumSize =
        _resolveState<Size?>(merged, (s) => s?.maximumSize);
    final OutlinedBorder? resolvedShape =
        _resolveState<OutlinedBorder?>(merged, (s) => s?.shape);
    final BorderSide? resolvedSide =
        _resolveState<BorderSide?>(merged, (s) => s?.side);
    final TextStyle? resolvedTextStyle =
        _resolveState<TextStyle?>(merged, (s) => s?.textStyle);
    final VisualDensity resolvedVisualDensity =
        merged.visualDensity ?? theme.visualDensity;
    final Duration resolvedAnimationDuration =
        merged.animationDuration ?? kThemeChangeDuration;
    final bool resolvedEnableFeedback = merged.enableFeedback ?? true;
    final AlignmentGeometry resolvedAlignment =
        merged.alignment ?? Alignment.center;
    final InteractiveInkFeatureFactory resolvedSplashFactory =
        merged.splashFactory ?? theme.splashFactory;

    final WidgetStateProperty<Color?> overlayColorProp =
        merged.overlayColor ?? WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) =>
              resolvedForegroundColor?.withValues(alpha: 0.12),
        );

    final Offset densityAdjustment =
        resolvedVisualDensity.baseSizeAdjustment;
    final double dy = densityAdjustment.dy;
    final double dx = math.max(0, densityAdjustment.dx);
    final EdgeInsetsGeometry padding = (resolvedPadding ?? EdgeInsets.zero)
        .add(EdgeInsets.fromLTRB(dx, dy, dx, dy))
        .clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity);

    final BoxConstraints effectiveConstraints =
        resolvedVisualDensity.effectiveConstraints(
      BoxConstraints(
        minWidth: resolvedMinimumSize?.width ?? 64,
        minHeight: resolvedMinimumSize?.height ?? 36,
        maxWidth: resolvedMaximumSize?.width ?? double.infinity,
        maxHeight: resolvedMaximumSize?.height ?? double.infinity,
      ),
    );

    Widget content = widget.child;
    if (widget._isIconVariant && widget.icon != null && widget.label != null) {
      final double spacing = 8;
      final IconAlignment effectiveAlignment =
          widget.iconAlignment ??
          merged.iconAlignment ??
          IconAlignment.start;
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: effectiveAlignment == IconAlignment.start
            ? [
                widget.icon!,
                SizedBox(width: spacing),
                Flexible(child: widget.label!),
              ]
            : [
                Flexible(child: widget.label!),
                SizedBox(width: spacing),
                widget.icon!,
              ],
      );
    }

    // Same as ElevatedButton: when child is Text, apply button theme (labelLarge + foreground color).
    final TextStyle effectiveTextStyle = (resolvedTextStyle ??
            theme.textTheme.labelLarge ??
            const TextStyle())
        .copyWith(color: resolvedForegroundColor);

    content = DefaultTextStyle(
      style: effectiveTextStyle,
      child: content,
    );

    content = Padding(
      padding: padding,
      child: Align(
        alignment: resolvedAlignment,
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: content,
      ),
    );

    content = IconTheme.merge(
      data: IconThemeData(
        color: _resolveState<Color?>(merged, (s) => s?.iconColor) ??
            resolvedForegroundColor,
        size: _resolveState<double?>(merged, (s) => s?.iconSize) ?? 18,
      ),
      child: content,
    );

    final MouseCursor cursor = widget.enabled
        ? SystemMouseCursors.click
        : SystemMouseCursors.basic;

    content = Material(
      elevation: resolvedElevation ?? 1,
      color: resolvedBackgroundColor,
      shadowColor: resolvedShadowColor,
      surfaceTintColor: resolvedSurfaceTintColor ?? Colors.transparent,
      textStyle: effectiveTextStyle,
      shape: resolvedShape?.copyWith(side: resolvedSide) ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      type: resolvedBackgroundColor == null
          ? MaterialType.transparency
          : MaterialType.button,
      animationDuration: resolvedAnimationDuration,
      clipBehavior: widget.clipBehavior ?? Clip.none,
      borderOnForeground: false,
      child: InkWell(
        onTap: widget.onPressed,
        onLongPress: widget.onLongPress,
        onHover: widget.onHover,
        onFocusChange: widget.onFocusChange,
        focusNode: widget.focusNode,
        canRequestFocus: widget.enabled,
        autofocus: widget.autofocus,
        enableFeedback: resolvedEnableFeedback,
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) =>
              overlayColorProp.resolve(states),
        ),
        highlightColor: Colors.transparent,
        splashFactory: resolvedSplashFactory,
        customBorder: resolvedShape?.copyWith(side: resolvedSide) ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        statesController: _statesController,
        child: MouseRegion(
          cursor: cursor,
          child: content,
        ),
      ),
    );

    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      child: ConstrainedBox(
        constraints: effectiveConstraints,
        child: content,
      ),
    );
  }
}
