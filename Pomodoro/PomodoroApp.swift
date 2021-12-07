//
//  pomodoroApp.swift
//  pomodoro
//
//  Created by Max Z on 30/11/21.
//

import SwiftUI

@main
struct pomodoroApp: App {
    
    // Connect AppDelegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            PreferenceView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    // Status Bar Item
    var statusItem: NSStatusItem?
    // Popover
    var popOver = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let timerView = TimerView()
        
        // Create Popover
        popOver.behavior = .transient
        popOver.animates = true
        // Setting empty view controller
        // and setting view as SwiftUI view
        // with the help of hosting controller
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: timerView)
        
        // Making view as main view
        popOver.contentViewController?.view.window?.makeKey()
        
        // Creating status bar button
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Safe check if status bar is available enough
        if let TimerButton = statusItem?.button{
            Timer.scheduledTimer(withTimeInterval: 0.33, repeats: true) { _ in
                TimerButton.title = TimerModel.menubar
            }
//            MenuButton.image = NSImage(systemSymbolName: "hourglass", accessibilityDescription: nil)
            TimerButton.action = #selector(MenuButtonToggle)
        }
    }
    
    // Button Action
    @objc func MenuButtonToggle(sender: AnyObject) {
        
        if popOver.isShown{
            popOver.performClose(sender)
        }
        else {
            // Showing Popover
            if let menuButton = statusItem?.button{
                
                // Top get button location for popover arrow
                self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    var window: NSWindow!
        var preferencesWindow: NSWindow!

        @objc func openPreferencesWindow() {
            if nil == preferencesWindow {
                let preferencesView = PreferenceView()
                preferencesWindow = NSWindow(
                    contentRect: NSRect(x: 20, y: 20, width: 480, height: 300),
                    styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                    backing: .buffered,
                    defer: false)
                preferencesWindow.center()
                preferencesWindow.setFrameAutosaveName("Preference")
                preferencesWindow.isReleasedWhenClosed = false
                preferencesWindow.contentView = NSHostingView(rootView: preferencesView)
            }
            preferencesWindow.makeKeyAndOrderFront(nil)
        }

}

