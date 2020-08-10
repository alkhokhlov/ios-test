//
//  NavigationShadow.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct NavigationShadow: View {
    var body: some View {
        Rectangle()
            .foregroundColor(
                Color(UIColor.lightGray.withAlphaComponent(0.4)))
            .frame(height: 0.25)
            .padding(0)
    }
}

struct NavigationShadow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationShadow()
    }
}
