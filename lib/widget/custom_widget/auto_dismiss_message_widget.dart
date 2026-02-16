import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A common widget for showing success and error messages
/// Automatically disappears after 3 seconds
class AutoDismissMessageWidget extends StatefulWidget {
  final String? message;
  final bool isError;
  final bool showMessage;
  final VoidCallback? onDismiss;
  final Duration autoHideDuration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AutoDismissMessageWidget({
    super.key,
    this.message,
    this.isError = false,
    this.showMessage = false,
    this.onDismiss,
    this.autoHideDuration = const Duration(seconds: 3),
    this.padding,
    this.margin,
  });

  @override
  State<AutoDismissMessageWidget> createState() => _AutoDismissMessageWidgetState();
}

class _AutoDismissMessageWidgetState extends State<AutoDismissMessageWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));

    // Start auto-hide timer when message shows
    if (widget.showMessage && widget.message != null && widget.message!.isNotEmpty) {
      _startAutoHide();
    }
  }

  @override
  void didUpdateWidget(AutoDismissMessageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showMessage && widget.message != null && widget.message!.isNotEmpty) {
      if (!oldWidget.showMessage) {
        _startAutoHide();
      }
    } else {
      _animationController.reverse();
    }
  }

  void _startAutoHide() {
    _animationController.forward();

    // Auto-hide after duration
    Future.delayed(widget.autoHideDuration, () {
      if (mounted) {
        _animationController.reverse().then((_) {
          if (mounted) {
            widget.onDismiss?.call();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showMessage || widget.message == null || widget.message!.isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: double.infinity,
              margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Icon(
                    widget.isError ? Icons.error_outline : Icons.check_circle_outline,
                    color: widget.isError ? Colors.red.shade600 : Colors.green.shade600,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.message!,
                      style: TextStyle(
                        color: widget.isError ? Colors.red.shade700 : Colors.green.shade700,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Floating version that appears at the top of the screen
class FloatingAutoDismissMessage extends StatefulWidget {
  final String message;
  final bool isError;
  final bool showMessage;
  final VoidCallback? onComplete;
  final Duration duration;

  const FloatingAutoDismissMessage({
    super.key,
    required this.message,
    this.isError = false,
    this.showMessage = false,
    this.onComplete,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<FloatingAutoDismissMessage> createState() => _FloatingAutoDismissMessageState();
}

class _FloatingAutoDismissMessageState extends State<FloatingAutoDismissMessage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));

    if (widget.showMessage) {
      _startAutoHide();
    }
  }

  @override
  void didUpdateWidget(FloatingAutoDismissMessage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showMessage && !oldWidget.showMessage) {
      _startAutoHide();
    } else if (!widget.showMessage && oldWidget.showMessage) {
      _animationController.reverse();
    }
  }

  void _startAutoHide() {
    _animationController.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _animationController.reverse().then((_) {
          if (mounted) {
            widget.onComplete?.call();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showMessage) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: MediaQuery.of(context).padding.top + 20.h,
      left: 16.w,
      right: 16.w,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: widget.isError ? Colors.red.shade600 : Colors.green.shade600,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2)),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.isError ? Icons.error_outline : Icons.check_circle_outline,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
