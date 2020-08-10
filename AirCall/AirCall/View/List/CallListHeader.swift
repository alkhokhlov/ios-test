//
//  CallListHeader.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct CallListHeader: View {
    var title: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            Text(title)
                .font(.system(size: 11))
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
                .padding(.bottom, 8)
            Spacer()
        }
    }
}

struct CallListHeader_Previews: PreviewProvider {
    static var previews: some View {
        CallListHeader(title: "TODAY")
    }
}
