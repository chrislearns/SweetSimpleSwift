//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 11/9/21.
//

import SwiftUI

public struct ScrollingSegmentControllerView<T: Hashable & CustomStringConvertible>: View{
    @ObservedObject public var viewModel: SegmentControllerViewModel<T>
    @Binding public var selection: T
    @Namespace var animation
    
    public init(viewModel: SegmentControllerViewModel<T>, selection: Binding<T>){
        _viewModel = viewModel
        _selection = selection
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            
            ScrollViewReader{proxy in
                HStack(spacing: 8){
                    ForEach(viewModel.options, id: \.self){option in
                        Button(action: {
                            withAnimation(.standardEIO){
                                selection = option
                                print(selection)
                            }
                        }){
                            Text(String(describing: option.description))
                                .fontWeight(viewModel.fontWeight)
                                .foregroundColor(option == selection ? .black : .init(white: 0.3))
                                .font(.system(size: 12, weight: option == selection ? .semibold : .regular))
                        }
                        .padding(6)
                        .background(
                            ZStack{
                                if selection == option {
                                    if viewModel.style == .background {
                                        viewModel.selectedOptionForegroundColor
                                            .opacity(selection == option ? 1 : 0)
                                            .cornerRadius(viewModel.indicatorCornerRadius ?? 0)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                    } else if viewModel.style == .underline {
                                        VStack{
                                            Spacer()
                                            Rectangle()
                                                .frame(height: 3)
                                                .foregroundColor(viewModel.selectedOptionForegroundColor)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                        }
                                    }
                                }
                            }
                        )
                        .id(option)
                    }
                }
                .onChange(of: selection) { newValue in
                    withAnimation{
                    proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }.frame(height: viewModel.height)
            
    }
}
