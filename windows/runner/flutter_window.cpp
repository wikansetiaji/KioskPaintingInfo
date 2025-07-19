#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

FlutterWindow::FlutterWindow(const flutter::DartProject& project)
    : project_(project) {}

FlutterWindow::~FlutterWindow() {
  if (fullscreen_) {
    ToggleFullscreen();
  }
}

bool FlutterWindow::OnCreate() {
  if (!Win32Window::OnCreate()) {
    return false;
  }

  // Set up window for F11 fullscreen toggle
  original_style_ = GetWindowLong(hwnd(), GWL_STYLE);
  
  RECT frame = GetClientArea();
  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      frame.right - frame.left, frame.bottom - frame.top, project_);
  
  // Register F11 key handler
  RegisterHotKey(hwnd(), 1, 0, VK_F11);
  
  return true;
}

void FlutterWindow::OnDestroy() {
  if (flutter_controller_) {
    flutter_controller_ = nullptr;
  }
  UnregisterHotKey(hwnd(), 1);
  Win32Window::OnDestroy();
}

LRESULT
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
                              WPARAM const wparam,
                              LPARAM const lparam) noexcept {
  if (message == WM_HOTKEY && wparam == 1) {
    ToggleFullscreen();
    return 0;
  }
  
  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}

void FlutterWindow::ToggleFullscreen() {
  if (!fullscreen_) {
    // Save window position and size
    GetWindowRect(hwnd(), &saved_window_rect_);
    
    // Get monitor info
    HMONITOR hmon = MonitorFromWindow(hwnd(), MONITOR_DEFAULTTONEAREST);
    MONITORINFO mi = { sizeof(mi) };
    GetMonitorInfo(hmon, &mi);
    
    // Set fullscreen
    SetWindowLong(hwnd(), GWL_STYLE, 
                 original_style_ & ~(WS_CAPTION | WS_THICKFRAME));
    SetWindowPos(
        hwnd(), HWND_TOP,
        mi.rcMonitor.left, mi.rcMonitor.top,
        mi.rcMonitor.right - mi.rcMonitor.left,
        mi.rcMonitor.bottom - mi.rcMonitor.top,
        SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
  } else {
    // Restore window
    SetWindowLong(hwnd(), GWL_STYLE, original_style_);
    SetWindowPos(
        hwnd(), nullptr,
        saved_window_rect_.left, saved_window_rect_.top,
        saved_window_rect_.right - saved_window_rect_.left,
        saved_window_rect_.bottom - saved_window_rect_.top,
        SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
  }
  
  fullscreen_ = !fullscreen_;
}