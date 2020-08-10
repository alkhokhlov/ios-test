//
//  ContentView.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var interactor: CallListInteractor
    
    @State var filter: CallFilter = .all
    
    private let isRunningTests: Bool
    
    init(isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
        self.isRunningTests = isRunningTests
    }
    
    var body: some View {
        NavigationView {
            if isRunningTests {
                Text("Running unit tests")
            } else {
                #if DEBUG
                contentView()
                    .navigationBarItems(leading:
                        Button(action: {
                            self.interactor.reset()
                        }) {
                            Text("Reset")
                        }
                    )
                #else
                contentView()
                #endif
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func contentView() -> AnyView {
        AnyView(VStack(spacing: 0) {
            NavigationSegmentedPicker(navBarColor: .white,
                                      sectionIndex: $filter)
            
            CallsList(groupedCalls: filter == .all ? interactor.groupedCalls : interactor.groupedCallsInbox)
        }
        .onAppear(perform: {
            self.interactor.loadCached()
            self.interactor.loadCalls()
        })
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("Activity",
                            displayMode: .inline)
        .background(NavigationConfigurator { nc in
            nc.navigationBar.tintColor = .black
            nc.navigationBar.barTintColor = .white
            nc.navigationBar.shadowImage = UIImage()
        }))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DependencyProvider.callListInteractor)
            .environment(\.locale, .init(identifier: "fr"))
    }
}
