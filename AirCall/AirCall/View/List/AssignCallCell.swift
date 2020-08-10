//
//  AssignCallRow.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct AssignCallCell: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "person.badge.plus")
                .renderingMode(.template)
                .foregroundColor(Color.blue)
                .offset(y: 2) // make more centered visually
            
            Text("Assign")
                .font(.system(size: 14))
                .padding(.leading, 12)
            
            Spacer()
            
            Image(systemName: "arrow.right.circle")
                .renderingMode(.template)
                .foregroundColor(Color.gray)
        }
        .padding(.top, 12)
        .padding(.bottom, 12)
        .padding(.leading, 12)
        .padding(.trailing, 12)
        .background(Color.white)
    }
}

struct AssignCallRow_Previews: PreviewProvider {
    static var previews: some View {
        AssignCallCell()
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
