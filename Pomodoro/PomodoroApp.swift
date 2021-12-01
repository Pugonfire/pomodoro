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
        
        // Making view as main view
        popOver.contentViewController?.view.window?.makeKey()
        
        // Creating status bar button
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Safe check if status bar is available enough
        if let MenuButton = statusItem?.button{
            
            MenuButton.image = NSImage(systemSymbolName: "icloud.and.arrow.up.fill", accessibilityDescription: nil)
            MenuButton.action = #selector(MenuButtonToggle)
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
}

