//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 11/2/21.
//

import SwiftUI

#if os(iOS)
public extension View {
    public func alertAware(_ manager: AlertManager) -> some View{
        ZStack{
            self
            AlertCentralView(viewModel: manager)
        }
    }
}

public class AlertManager: ObservableObject {
    
    public struct AlertObject {
        
        public init(
            message: String,
            colorOverride: Color? = nil,
            type: AlertType,
            style: AlertStyle,
            duration: Double = 2.4,
            tapToDismiss: Bool = true
        ){
            self.message = message
            self.colorOverride = colorOverride
            self.type = type
            self.style = style
            self.duration = duration
            self.tapToDismiss = tapToDismiss
        }
        public var message: String
        public var colorOverride: Color? = nil
        public var type: AlertType
        public var style: AlertStyle
        public var duration: Double = 2.4
        public var tapToDismiss: Bool = true
        
        public var systemImage: String{
            type.systemImage
        }
        
        public var color: Color{
            colorOverride ?? type.color
        }
        
        public var view: some View {
            return style.view(alert: self)
        }
        
        public enum AlertType {
            case error, success, warning, info, custom(String, Color?)
            
            public var systemImage: String {
                switch self {
                case .error:
                    return "xmark"
                case .success:
                    return "checkmark"
                case .warning:
                    return "exclamationmark.shield"
                case .info:
                    return "info"
                case .custom(let imageName, _):
                    return imageName
                }
            }
            
            public var color: Color {
                switch self {
                case .error:
                    return .red
                case .success:
                    return .green
                case .warning:
                    return .yellow
                case .info:
                    return .blue
                case .custom(_, let color):
                    return color ?? .yellow
                }
            }
        }
        
        public enum AlertStyle {
            case capsule
            case banner
            
            public func view(alert: AlertObject) -> some View {
                Group{
                    switch self {
                    case .banner:
                        AlertBanner(alert: alert)
                    case .capsule:
                        AlertCapsule(alert: alert)
                    }
                }
            }
        }
    }
    
    public init(){
      self.alertQueue = []
      self.currentAlert = nil
    }
    @Published public var alertQueue: [AlertObject]
    @Published public var currentAlert: AlertObject?
    
    public func notifyNewAlert(){
        if alertQueue.count == 1 && currentAlert == nil {
            displayFirstAlert()
        }
    }
    
    public func displayFirstAlert(){
        print("displaying first alert")
        currentAlert = alertQueue.first
        if alertQueue.count > 0 {
            _ = alertQueue.removeFirst()
        }
    }
    
    public func addAlert(_ alert: AlertObject){
        alertQueue.append(alert)
    }
}

public struct AlertCentralView: View {
    
    init(viewModel: AlertManager){
        _viewModel = .init(wrappedValue: viewModel)
        self.queueCount = viewModel.alertQueue.count
    }
    @StateObject var viewModel: AlertManager
    @State var queueCount: Int
    public var body: some View {
        VStack{
            Spacer().frame(height: GeneralHelper.UniversalSafeOffsets?.top ?? 0)
            if let currentAlert = viewModel.currentAlert {
                currentAlert.view
                    .if(currentAlert.tapToDismiss){
                        $0.embedInButton {
                            self.viewModel.currentAlert = nil
                        }
                    }
                    .transition(AnyTransition.opacity.combined(with: .move(edge: .top)))
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(currentAlert.duration)) {
                            self.viewModel.currentAlert = nil
                        }
                    }
                    .onDisappear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            self.viewModel.displayFirstAlert()
                        }
                    }
                    .padding(8)
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.randomizedSpring)
        .onChange(of: viewModel.alertQueue.count){newValue in
            self.queueCount = newValue
        }
        .onChange(of: queueCount, perform: { [queueCount] newCount in
            if newCount > queueCount {
                viewModel.notifyNewAlert()
                print("alert count -> \(viewModel.alertQueue.count)")
            }
        })
        .environmentObject(viewModel)
    }
}


public struct AlertCapsule: View {
    public var alert: AlertManager.AlertObject
    @EnvironmentObject public var alertManager: AlertManager
    
    public var body: some View {
        HStack{
            Image(systemName: alert.type.systemImage)
                .foregroundColor(alert.color)
            Text(alert.message)
                .foregroundColor(.white)
        }
        .padding()
        .frame(height: 46)
//        .padding(.horizontal)
        .background(VisualEffectView(effect: UIBlurEffect(style: .dark)))
        .cornerRadius(23)
        
    }
}


public struct AlertBanner: View {
    public var alert: AlertManager.AlertObject
    @EnvironmentObject public var alertManager: AlertManager
    
    public var body: some View {
        HStack{
            Image(systemName: alert.type.systemImage)
                .foregroundColor(.white)
            Text(alert.message)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .infiniteWidth(.leading)
        .frame(minHeight: 50)
        .background(alert.color.opacity(0.6))
        .background(VisualEffectView(effect: UIBlurEffect(style: .dark)))
        .cornerRadius(10)
        
    }
}
#endif
