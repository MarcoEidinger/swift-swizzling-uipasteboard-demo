//
//  DemoApp.swift
//  Demo
//
//  Created by Eidinger, Marco on 12/19/22.
//

import SwiftUI

@main
struct DemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var allowCustomKeyboards = true

    static var privatePasteboard = UIPasteboard.withUniqueName()

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        #if OBCJ_RUNTIME_SWIZZLING // I defined this in Build Settings -> Swift Compiler - Custom Flags -> Active Compilation Conditions
            swizzleUIPasteboardGeneral()
        #endif

        return true
    }

    func swizzleUIPasteboardGeneral() {
        let aClass: AnyClass! = object_getClass(UIPasteboard.general)
        let targetClass: AnyClass! = object_getClass(self)
        
        let originalMethod = class_getClassMethod(aClass, #selector(getter: UIPasteboard.general))
        let swizzledMethod = class_getInstanceMethod(targetClass, #selector(privatePasteboard))
        
        if let originalMethod, let swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    @objc
    func privatePasteboard() -> UIPasteboard {
        return AppDelegate.privatePasteboard
    }
}
