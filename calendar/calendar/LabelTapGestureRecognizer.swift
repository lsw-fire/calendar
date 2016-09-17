//
//  LabelTapGestureRecognizer.swift
//  calendar
//
//  Created by Li Shi Wei on 9/13/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class LabelTapGestureRecognizer: UIGestureRecognizer {

    var onTouch:((UITouch) -> Void)?
    var onMoved:((UITouch) -> Void)?
    var onEnded:((UITouch) -> Void)?
    
    init(target: AnyObject?) {
        super.init(target: target, action: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        let myTouch = touches.first! as UITouch
        onTouch?(myTouch)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        let myTouch = touches.first! as UITouch
        onMoved?(myTouch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        let myTouch = touches.first! as UITouch
        onEnded?(myTouch)
        self.reset()
    }
}
