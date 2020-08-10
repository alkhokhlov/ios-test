//
//  DashedLine.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct DashedLine: View {
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path{ path in
                path.move(to: CGPoint(x: 0, y: Constants.lineY))
                path.addLine(to: CGPoint(x: geometry.size.width, y: Constants.lineY))
            }
            .stroke(style: StrokeStyle(
                lineWidth: Constants.lineHeight,
                dash: [Constants.lineDash]))
                .foregroundColor(self.color)
                .frame(height: geometry.size.height)
        }
    }
    
    enum Constants {
        static let lineY: CGFloat = 3
        static let lineHeight: CGFloat = 1
        static let lineDash: CGFloat = 4
    }
}

struct DashedLine_Previews: PreviewProvider {
    static var previews: some View {
        DashedLine(color: Color.blue)
    }
}
