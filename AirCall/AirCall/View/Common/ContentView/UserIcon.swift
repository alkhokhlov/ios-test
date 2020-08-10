//
//  UserIcon.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct UserIcon: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .padding(24)
            .background(Color(
                red: 81/255.0,
                green: 186/255.0,
                blue: 247/255.0
            ))
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 8))
    }
}

struct UserIcon_Previews: PreviewProvider {
    static var previews: some View {
        UserIcon()
            .background(Color.black)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
