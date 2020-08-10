//
//  CornerBorder.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct CorneredBorderedAngle: Shape {
    var cornerRadius: CGFloat = 48
    var side: Side = .top
    var strokeWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        switch side {
        case .top:
            return Path { path in
                path.move(to: CGPoint(x: rect.origin.x,
                                         y: rect.size.height - strokeWidth / 2))
                path.addLine(to: CGPoint(x: rect.origin.x,
                                         y: cornerRadius))
                path.addArc(center: CGPoint(x: cornerRadius,
                                            y: cornerRadius),
                            radius: cornerRadius,
                            startAngle: Angle(degrees: 180),
                            endAngle: Angle(degrees: 270),
                            clockwise: false)
                path.addLine(to: CGPoint(x: rect.size.width,
                                         y: rect.origin.y))
                path.addLine(to: CGPoint(x: rect.size.width,
                                         y: rect.size.height))
            }
        case .bottom:
            return Path { path in
                path.move(to: CGPoint(x: rect.size.width,
                                      y: rect.size.height))
                path.addLine(to: CGPoint(x: cornerRadius,
                                         y: rect.size.height))
                path.addArc(center: CGPoint(x: cornerRadius,
                                            y: rect.size.height - cornerRadius),
                            radius: cornerRadius,
                            startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 180),
                            clockwise: false)
                path.addLine(to: CGPoint(x: rect.origin.x,
                                         y: rect.origin.y + strokeWidth / 2))
            }
        }
    }
    enum Side {
        case top
        case bottom
    }
}

struct CornerBorder_Previews: PreviewProvider {
    static var previews: some View {
        CorneredBorderedAngle(cornerRadius: 48, side: .bottom, strokeWidth: 5)
            .stroke(Color.red,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .square,
                        lineJoin: .round))
    }
}
