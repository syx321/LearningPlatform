//
//  UIView+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation
import UIKit

public extension UIView {
    @inlinable func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    /// 修改锚点但不移动当前位置
    func setAnchorPointAtCurPosition(_ anchorPointNew: CGPoint)  {
        var positionNew: CGPoint = CGPoint()
        let positionOld = layer.position
        let anchorPointOld = layer.anchorPoint
        layer.anchorPoint = anchorPointNew
        positionNew.x = positionOld.x + (anchorPointNew.x - anchorPointOld.x)  * bounds.size.width
        positionNew.y = positionOld.y + (anchorPointNew.y - anchorPointOld.y)  * bounds.size.height
        layer.position = positionNew
    }
}
// MARK: 屏幕适配
public let ScreenWidthRadio = ScreenWidth / 375.0
public let ScreenHeightRadio = ScreenHeight / 812.0
public extension Double {
    @inlinable var radio: CGFloat {
        get {
            return CGFloat(self) * ScreenWidthRadio
        }
    }
    
    @inlinable var per1000: CGFloat {
        get {
            return CGFloat(self) / CGFloat(1000)
        }
    }
}

public extension CGFloat {
    @inlinable var radio: CGFloat {
        get {
            return self * ScreenWidthRadio
        }
    }
    
    @inlinable var per1000: CGFloat {
        get {
            return CGFloat(self) / CGFloat(1000)
        }
    }
    
    @inlinable var heightRadio: CGFloat {
        get {
            return self * ScreenHeightRadio
        }
    }
}

public extension Int {
    @inlinable var radio: CGFloat {
        get {
            return CGFloat(self) * ScreenWidthRadio
        }
    }
    
    @inlinable var per1000: CGFloat {
        get {
            return CGFloat(self) / CGFloat(1000)
        }
    }
    
    @inlinable var heightRadio: CGFloat {
        get {
            return self.cgFloat * ScreenHeightRadio
        }
    }
}

public extension Float {
    @inlinable var radio: CGFloat {
        get {
            return CGFloat(self) * ScreenWidthRadio
        }
    }
    
    @inlinable var per1000: CGFloat {
        get {
            return CGFloat(self) / CGFloat(1000)
        }
    }
    
    @inlinable var heightRadio: CGFloat {
        get {
            return self.cgFloat * ScreenHeightRadio
        }
    }
}

extension UIView {
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func removeAllGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
}
