//
//  Line.swift
//  TouchTracker
//
//  Created by David on 1/18/17.
//  Copyright © 2017 DSmith. All rights reserved.
//

import Foundation
import CoreGraphics

// Structs are like Classes but: Cannot inherit, must set all properties, and are value type instead of reference
struct Line {
    var begin: CGPoint! = CGPoint.zero
    var end: CGPoint! = CGPoint.zero
}
