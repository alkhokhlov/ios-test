//
//  NavigationSegmentedPicker.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct NavigationSegmentedPicker: View {
    @Binding var filter: CallFilter
    
    let navBarColor: Color
    
    init(navBarColor: Color, sectionIndex: Binding<CallFilter>) {
        self.navBarColor = navBarColor
        self._filter = sectionIndex
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Picker(
                selection: $filter,
                label: Text("Which calls you would like to see ?")
            ) {
                ForEach(CallFilter.allCases, id: \.self) {
                    Text($0.localizedString)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .padding(.top, 0)
            .padding(.bottom, 8)
                            
            NavigationShadow()
        }
    }
}

struct NavigationSegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSegmentedPicker(navBarColor: .white,
                                  sectionIndex: Binding.constant(CallFilter.all))
        .environment(\.locale, .init(identifier: "fr"))
    }
}
