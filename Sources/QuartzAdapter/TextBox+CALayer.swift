//
//  TextBox+CALayer.swift
//  Rendering
//
//  Created by James Bean on 6/13/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Rendering

extension CALayer {
    
    public convenience init(_ textBox: TextBox) {
        self.init()
        
        self.frame = CGRect(textBox.frame)
        self.borderColor = textBox.borderColor.cgColor
        self.borderWidth = CGFloat(textBox.borderWidth)
        self.backgroundColor = textBox.backgroundColor.cgColor
        
        let textLayer = CATextLayer(textBox.text)
        
        // TODO: Do this within `TextBox`
        textLayer.position.x = frame.midX
        textLayer.position.y += CGFloat(textBox.insets.top)
        addSublayer(textLayer)
    }
}

#endif
