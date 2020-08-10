//
//  CallsList.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/6/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import SwiftUI

struct CallsList: View {
    var groupedCalls: [String: [Call]]
        
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if groupedCalls.keys.count == 0 {
                    Section(header: CallListHeader(title: "")) {
                        Spacer()
                    }
                } else {
                    ForEach(self.groupedCalls.keys.sorted().reversed(), id: \.self) { sectionTitle in
                        Section(header: CallListHeader(title: sectionTitle)) {
                            ForEach(0..<self.groupedCalls[sectionTitle]!.count, id: \.self) { rowIndex in
                                NavigationLink(destination: self.callDetail(self.groupedCalls[sectionTitle]![rowIndex])) {
                                    self.borderedCallRow(key: sectionTitle,
                                                         index: rowIndex,
                                                         itemsCount: self.groupedCalls[sectionTitle]!.count)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .offset(x: Constants.rowsTrailingOffset)
                    .padding(.trailing, Constants.rowsTrailingOffset)
                }
            }
        }
        .background(Constants.backgroundColor)
    }
    
    // MARK: - Helpers
    
    func callDetail(_ call: Call) -> AnyView {
        return AnyView(CallDetail(call: call)
            .environmentObject(DependencyProvider.callDetailInteractor))
    }
    
    func borderedCallRow(key: String, index: Int, itemsCount: Int) -> AnyView {
        func getItem(key: String, index: Int) -> Call {
            return groupedCalls[key]![index]
        }
        if itemsCount == 1 {
            return AnyView(CallCell(call: groupedCalls[key]![index], showSeparator: false)
                .clipShape(Constants.roundedShape)
                .overlay(Constants.roundedShape
                    .stroke(Constants.borderColor,
                            lineWidth: 1)))
        }
        
        switch index {
        case 0:
            return AnyView(CallCell(call: getItem(key: key, index: index), showSeparator: true)
                .clipShape(RoundedCorner(radius: Constants.rowCornerRadius,
                                         corners: [.topLeft]))
                .overlay(self.callRowOverlay(.top)))
        case itemsCount - 1:
            return AnyView(CallCell(call: getItem(key: key, index: index), showSeparator: false)
                .clipShape(RoundedCorner(radius: Constants.rowCornerRadius,
                                         corners: [.bottomLeft]))
                .overlay(self.callRowOverlay(.bottom))
            )
        default:
            return AnyView(CallCell(call: getItem(key: key, index: index), showSeparator: true)
                .overlay(EdgeBorder(edges: [.leading, .trailing], strokeWidth: 1)
                    .stroke(
                        Constants.borderColor,
                        style: StrokeStyle(
                            lineWidth: 1,
                            lineCap: .square,
                            lineJoin: .round))))
        }
    }
    
    func callRowOverlay(_ side: CorneredBorderedAngle.Side) -> AnyView {
        return AnyView(CorneredBorderedAngle(cornerRadius: Constants.rowCornerRadius, side: side, strokeWidth: 1)
            .stroke(
                Constants.borderColor,
                style: StrokeStyle(
                    lineWidth: 1,
                    lineCap: .square,
                    lineJoin: .round)))
    }
    
    enum Constants {
        static let rowsTrailingOffset: CGFloat = 16
        static let rowCornerRadius: CGFloat = 12
        static let borderColor = Color(UIColor.lightGray.withAlphaComponent(0.3))
        static let backgroundColor = Color(red: 242/255.0,
                                           green: 242/255.0,
                                           blue: 242/255.0)
        static let roundedShape = RoundedCorner(radius: 12,
                                            corners: [.topLeft, .bottomLeft])
    }
}

struct CallsList_Previews: PreviewProvider {
    static var previews: some View {
//        CallsList(calls: [
//            DependencyProvider.callExample,
//            DependencyProvider.callExample,
//            DependencyProvider.callExample
//        ])
        CallsList(groupedCalls: [
            "13 Apr" : [DependencyProvider.callExample],
            "14 Apr" : [DependencyProvider.callExample]
        ])
    }
}
