//
//  SegmentControllerViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/6/21.
//

import SwiftUI

open class SegmentControllerViewModel<T: Hashable>: ObservableObject {
    
    public enum Style {
        case underline
        case background
    }
    
    public var style: Style = .background
    public var selectedOptionBackgroundColor: Color
    public var unselectedOptionBackgroundColor: Color
    public var selectedOptionForegroundColor: Color
    public var unselectedOptionForegroundColor: Color
    public var height: CGFloat
    public var indicatorCornerRadius: CGFloat?
    public var fontWeight: Font.Weight = .regular
    
    @Published public var options: [T]
    @Binding public var selection: T
    
    public init(
        options: [T],
        fontWeight: Font.Weight = .regular,
        selection: Binding<T>,
        height: CGFloat = 40,
        indicatorCornerRadius: CGFloat? = 10,
        style: Style,
        selectedOptionBackgroundColor: Color = Color.blue.opacity(0.5),
        unselectedOptionBackgroundColor: Color = .clear,
        selectedOptionForegroundColor: Color = .black,
        unselectedOptionForegroundColor: Color = .black
        
    ){
        self.fontWeight = fontWeight
        self.options = options
        _selection = selection
        self.height = height
        self.style = style
        self.indicatorCornerRadius = indicatorCornerRadius
        self.selectedOptionBackgroundColor = selectedOptionBackgroundColor
        self.unselectedOptionBackgroundColor = unselectedOptionBackgroundColor
        self.selectedOptionForegroundColor = selectedOptionForegroundColor
        self.unselectedOptionForegroundColor = unselectedOptionForegroundColor
    }
}
