//
//  EdgeBorder.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct EdgeBorder: Shape {
    var edges: [Edge]
    var strokeWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            edges.forEach { (edge) in
                switch edge {
                case .top:
                    path.move(to: CGPoint(x: rect.origin.x,
                                          y: rect.origin.y))
                    path.addLine(to: CGPoint(x: rect.origin.x,
                                             y: rect.size.width))
                case .bottom:
                    path.move(to: CGPoint(x: rect.origin.x,
                                          y: rect.size.height))
                    path.addLine(to: CGPoint(x: rect.size.width,
                                             y: rect.size.height))
                case .leading:
                    path.move(to: CGPoint(x: rect.origin.x,
                                          y: rect.size.height - strokeWidth / 2))
                    path.addLine(to: CGPoint(x: rect.origin.x,
                                             y: rect.origin.y + strokeWidth / 2))
                case .trailing:
                    path.move(to: CGPoint(x: rect.size.width,
                                          y: rect.size.height - strokeWidth / 2))
                    path.addLine(to: CGPoint(x: rect.size.width,
                                             y: rect.origin.y + strokeWidth / 2))
                }
            }
        }
    }
}

struct EdgeBorder_Previews: PreviewProvider {
    static var previews: some View {
        EdgeBorder(edges: [.bottom, .leading], strokeWidth: 5)
            .stroke(Color.red,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .square,
                        lineJoin: .round))
    }
}
