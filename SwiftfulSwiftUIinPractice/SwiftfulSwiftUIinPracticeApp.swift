//
//  SwiftfulSwiftUIinPracticeApp.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 10/10/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

@main
struct SwiftfulSwiftUIinPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
