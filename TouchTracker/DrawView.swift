//
//  DrawView.swift
//  TouchTracker
//
//  Created by David on 1/18/17.
//  Copyright © 2017 DSmith. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLine: Line?
    var finishedLines: [Line]! = [Line]()
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // Draw finished lines in black
        UIColor.black.setStroke()
        for line in finishedLines {
            strokeLine(line: line)
        }
        // Draw the current line in red
        if let line = currentLine as Line! {
            UIColor.red.setStroke()
            strokeLine(line: line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        // Get the location of the touch in the view's coordinates
        let location = touch.location(in: self)
        // Default location is the point of entry
        currentLine = Line(begin: location, end: location)
        
        // Refreshes view
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.location(in: self)
        // As the finger moves - update the final end point to create a line
        currentLine?.end = location
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if var line = currentLine as Line! {
            let touch = touches.first!
            let location = touch.location(in: self)
            line.end = location
            finishedLines.append(line)
        }
        // Reset
        currentLine = nil
        
        setNeedsDisplay()
    }
}
