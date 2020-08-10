//
//  CallRow.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct CallCell: View {
    var call: Call
    var showInfoImage = true
    var showSeparator = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                phoneIconImage()
                
                VStack(alignment: .leading) {
                    Text(call.title)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .lineLimit(0)
                    Text(call.description)
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                }
                .padding(.leading, 12)
                
                Spacer()
                
                Text(call.createdAtFormatted)
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    .padding(.trailing, 8)
                
                if showInfoImage {
                    Image(systemName: "info.circle")
                        .renderingMode(.template)
                        .foregroundColor(Color.gray)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 12)
            .padding(.top, 12)
            .padding(.bottom, 12)
            
            if showSeparator {
                DashedLine(color: Color(UIColor.lightGray.withAlphaComponent(0.3)))
                    .frame(height: 5)
                    .padding(.leading, 58)
                    .offset(y: -2.5)
                    .padding(.bottom, -2.5)
            }
        }
        .background(Color.white)
    }
    
    func phoneIconImage() -> AnyView {
        switch call.callType {
        case .missed:
            return AnyView(Image(systemName: "phone.down")
                .renderingMode(.template)
                .foregroundColor(.red))
        case .voicemail:
            if call.direction == .outbound {
                return AnyView(Image(systemName: "phone.arrow.up.right")
                    .renderingMode(.template)
                    .foregroundColor(.green))
            } else {
                return AnyView(Image(systemName: "phone.arrow.down.left")
                    .renderingMode(.template)
                    .foregroundColor(.red))
            }
        case .answered:
            if call.direction == .outbound {
                return AnyView(Image(systemName: "phone.fill.arrow.up.right")
                    .renderingMode(.template)
                    .foregroundColor(.green))
            } else {
                return AnyView(Image(systemName: "phone.fill.arrow.down.left")
                    .renderingMode(.template)
                    .foregroundColor(.green))
            }
        }
    }
}

struct CallRow_Previews: PreviewProvider {
    static var previews: some View {
        CallCell(call: DependencyProvider.callExample, showSeparator: true)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
