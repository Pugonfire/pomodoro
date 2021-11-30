//
//  MacMenuApp.swift
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
        
    }
}
