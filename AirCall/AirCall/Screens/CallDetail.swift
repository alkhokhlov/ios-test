//
//  CallDetail.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct CallDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var interactor: CallDetailInteractor
    
    var call: Call
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationShadow()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    CallDetailHeader(call: call)
                    
                    CallDetailActions(call: call)
                        .offset(y: Constants.linesTopOffset)
                        .offset(x: Constants.linesTrailingOffset)
                        .padding(.bottom, Constants.linesTopOffset)
                        .padding(.trailing, Constants.linesTrailingOffset)
                    
                    Spacer()
                }
            }
        }
        .onReceive(interactor.$isArchived, perform: { value in
            if value {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarItems(trailing:
            Button(action: {
                self.interactor.archive(self.call)
            }) {
                Image(systemName: "archivebox")
            }
        )
    }
    
    enum Constants {
        static let linesTopOffset: CGFloat = -20
        static let linesTrailingOffset: CGFloat = 16
    }
}

struct CallDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CallDetail(call: DependencyProvider.callExample)
                .environmentObject(DependencyProvider.callDetailInteractor)
        }
    }
}
