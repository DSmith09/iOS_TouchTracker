//
//  DrawView.swift
//  TouchTracker
//
//  Created by David on 1/18/17.
//  Copyright © 2017 DSmith. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLines: [NSValue: Line] = [NSValue: Line]()
    var finishedLines: [Line]! = [Line]()
    
    // MARK: Interface Builder attributes
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Draw
    override func draw(_ rect: CGRect) {
        // Draw finished lines in black
        finishedLineColor.setStroke()
        for line in finishedLines {
            strokeLine(line: line)
        }
        // Draw the current line(s) in red
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            strokeLine(line: line)
        }
    }
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    // MARK: UIResponder Events for Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let newKey = NSValue(nonretainedObject: touch)
            currentLines.updateValue(newLine, forKey: newKey)
        }
        // Refresh view
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            // As the finger moves - update the final end point to create a line
            currentLines[NSValue(nonretainedObject: touch)]?.end = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] as Line! {
                line.end = touch.location(in: self)
                finishedLines.append(line)
                // Remove value
                currentLines.removeValue(forKey: key)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        
        setNeedsDisplay()
    }
}
