//
//  CallDetailActions.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct CallDetailActions: View {
    var call: Call
    
    var body: some View {
        VStack(spacing: 16) {
            CallCell(call: call, showInfoImage: false, showSeparator: false)
                .clipShape(Constants.rowShape)
                .overlay(Constants.rowShape
                    .stroke(Constants.borderColor,
                            lineWidth: 1))
            
            AssignCallCell()
                .clipShape(Constants.rowShape)
                .overlay(Constants.rowShape
                    .stroke(Constants.borderColor,
                            lineWidth: 1))
        }
    }
    
    enum Constants {
        static let linesTopOffset: CGFloat = -30
        static let linesTrailingOffset: CGFloat = 20
        static let rowShape = RoundedCorner(radius: 12,
                                            corners: [.topLeft, .bottomLeft])
        static let borderColor = Color(UIColor.lightGray.withAlphaComponent(0.3))
    }
}

struct CallDetailActions_Previews: PreviewProvider {
    static var previews: some View {
        CallDetailActions(call: DependencyProvider.callExample)
    }
}
