//
//  UINavigationController+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 20/2/26.
//

import SwiftUI
import UIKit

var isSwipeBackEnabled: Bool = true

// MARK: - This code help to swipe screen when hide original back button
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (viewControllers.count > 1 && isSwipeBackEnabled)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
