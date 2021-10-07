//
//  PageSegmentControllerView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/6/21.
//
#if os(iOS)
import SwiftUI

public struct PageSegmentControllerView<T: Hashable & RawRepresentable>: View {
    @StateObject var viewModel: PageSegmentControllerViewModel<T>
    @Binding var selection: T
    
    public init(viewModel: PageSegmentControllerViewModel<T>, selection: Binding<T>){
        self.viewModel = viewModel
        _selection = selection
    }
    public var body: some View {
        GeometryReader{geo in
            let size = geo.frame(in: .global).size
            let segmentWidth = size.width/viewModel.options.count.double.cgfloat
            HStack(spacing: 0){
                ForEach(viewModel.options, id: \.self){option in
                    Button(action: {
                        withAnimation(.standardEIO){   selection = option
                            print(selection)
                        }
                    }){
                        Text(String(describing: option.rawValue))
                            .frame(width: size.width/viewModel.options.count.double.cgfloat)
                            .foregroundColor(option == selection ? viewModel.selectedOptionForegroundColor : viewModel.unselectedOptionForegroundColor)
                    }
                }
            }
            .frame(height: viewModel.height)
            .if(viewModel.style == .background){
                $0.background(
                    viewModel.selectedOptionBackgroundColor
                        .frame(width: segmentWidth)
                        .ifLet(viewModel.indicatorCornerRadius){
                            $0.cornerRadius($1)
                        }
                        .offset(x: -size.width/2)
                        .offset(x: segmentWidth/2)
                        .ifLet(viewModel.options.firstIndex(of: selection), transform: { view, val in
                            view.offset(x: Int(val).double.cgfloat * segmentWidth)
                        })
                    
                    
                )
                    .background(viewModel.unselectedOptionBackgroundColor)
            }
            .if(viewModel.style == .underline){
                $0.background(
                    VStack{
                        Spacer()
                        viewModel.selectedOptionBackgroundColor
                            .frame(width: segmentWidth, height: 3)
                            .ifLet(viewModel.indicatorCornerRadius){
                                $0.cornerRadius($1)
                            }
                            
                            .offset(x: -size.width/2)
                            .offset(x: segmentWidth/2)
                            .ifLet(viewModel.options.firstIndex(of: selection), transform: { view, val in
                                view.offset(x: Int(val).double.cgfloat * segmentWidth)
                            })
                        
                    }
                )
                    .background(viewModel.unselectedOptionBackgroundColor)
            }
            
            
        }.frame(height: viewModel.height)
        
    }
}

struct PageSegmentControllerView_Previews: PreviewProvider {
    static var previews: some View {
        PageSegmentControllerView.init(
            viewModel: .init(
                options: [TestEnum.one, .two, .three, .four],
                selection: .constant(.three),
                height: 30,
                style: .underline,
                selectedOptionBackgroundColor: .blue,
                unselectedOptionBackgroundColor: .clear,
                selectedOptionForegroundColor: .blue,
                unselectedOptionForegroundColor: .black
            ),
            selection: .constant(.three)
        )
    }
}

enum TestEnum: String, Hashable {
    case one, two, three, four, five, six
}

#endif

