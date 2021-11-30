//
//  pomodoroApp.swift
//  pomodoro
//
//  Created by Max Z on 30/11/21.
//

import SwiftUI

@main
struct MacMenuApp: App {
    // Connect AppDelegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Build Menu Button and Pop Over Menu...
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // Status Bar Item
    var statusItem: NSStatusItem?
    // Popover
    var popOver = NSPopover()
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let menuView = MenuView()
        
        // Create Popover
        popOver.behavior = .transient
        popOver.animates = true
        // Setting empty view controller
        // and setting view as SwiftUI view
        // with the help of hosting controller
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: menuView)
        
        // Creating status bar button
    }
}

