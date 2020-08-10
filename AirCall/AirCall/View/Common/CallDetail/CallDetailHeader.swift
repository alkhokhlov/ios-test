//
//  CallDetailHeader.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct CallDetailHeader: View {
    var call: Call
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Constants.backgroundHeaderColor)
                .frame(height: Constants.headerHeight)
            
            HStack(spacing: 24) {
                UserIcon()
                    .frame(
                        width: Constants.imageHeight,
                        height: Constants.imageHeight)
                
                VStack(alignment: .leading) {
                    Text(call.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    
                    DashedLine(color: Color(.lightGray))
                        .frame(height: Constants.dashedLineHeight)
                        .offset(y: Constants.dashedLineOffset)
                        .padding(.bottom, Constants.dashedLineOffset)
                }
                .offset(y: Constants.phoneBottomOffset)
                .padding(.bottom, Constants.phoneBottomOffset)
            }
            .padding(.leading, 32)
        }
    }
    enum Constants {
        static let backgroundHeaderColor = Color(UIColor(
            red: 63/255.0,
            green: 142/255.0,
            blue: 182/255.0,
            alpha: 1.0
        ))
        static let headerHeight: CGFloat = 200
        static let imageHeight: CGFloat = 100
        static let phoneBottomOffset: CGFloat = -32
        static let dashedLineHeight: CGFloat = 5
        static let dashedLineOffset: CGFloat = -8
    }
}

struct CallDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        CallDetailHeader(call: DependencyProvider.callExample)
    }
}
