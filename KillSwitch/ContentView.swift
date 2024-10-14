//
//  ContentView.swift
//  KillSwitch
//
//  Created by GooseMooz on 2024-08-29.
//

import Foundation
import SwiftUI
import FamilyControls
import StoreKit
struct AnimationValues {
    var progressBar = 0.0
}

struct EmergencyButtonStyle: ButtonStyle {
    var isBlocked: Bool
    var isDrained: Bool

    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(15)
            .contentShape(Rectangle())
            .background(
                Group {
                    Image(systemName: "exclamationmark.circle")
                    if isBlocked {
                        if isDrained {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color("GradientTwo"), Color("GradientOne")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
                                    .shadow(
                                        .inner(color: Color.gray.opacity(0.5), radius: 10, x: -5, y: 5)
                                    )
                                    .shadow(
                                        .inner(color: Color.gray.opacity(0.2), radius: 10, x: 5, y: -5)
                                    )
                                    .shadow(
                                        .inner(color: Color.white.opacity(0.9), radius: 10, x: -5, y: -5)
                                    )
                                    .shadow(
                                        .inner(color: Color.gray.opacity(0.4), radius: 13, x: 5, y: 5)
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: Color.white.opacity(0.3), radius: 2, x: 1, y: 1)
                                .shadow(color: Color.gray.opacity(0.5), radius: 2, x: -1, y: -1)
                        } else {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color("GradientTwo"), Color("GradientOne")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
                                    .shadow(
                                        .inner(color: Color.white.opacity(0.2), radius: 2, x:1, y:1)
                                    )
                                    .shadow(
                                        .inner(color: Color.gray.opacity(0.5), radius: 2, x:-1, y:-1)
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x:10, y:10)
                                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                .shadow(color: Color.gray.opacity(0.1), radius: 10, x:-10, y:10)
                                .shadow(color: Color.gray.opacity(0.1), radius: 10, x:10, y:-10)
                        }
                    }
                }
            )
    }
}

struct CircleButtonStyle: ButtonStyle {
    var isActive: Bool
    let hapticManager = HapticLong()
    @State private var isHolding: Bool = false
    @State private var timerCount: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var isCompleted: Bool = false
    @State private var longFunction: Bool = false
    @State var longAction: () -> Void
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(85)
            .contentShape(Circle())
            .background(
                Group {
                    if !isHolding {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color("GradientTwo"), Color("GradientOne")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing)
                                .shadow(
                                    .inner(color: Color.white.opacity(0.2), radius: 2, x:1, y:1)
                                )
                                .shadow(
                                    .inner(color: Color.gray.opacity(0.5), radius: 2, x:-1, y:-1)
                                )
                            )
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x:10, y:10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .shadow(color: Color.gray.opacity(0.1), radius: 10, x:-10, y:10)
                            .shadow(color: Color.gray.opacity(0.1), radius: 10, x:10, y:-10)
                    } else {
                        Circle()
                            .fill(Color("FillColor"))
                    }
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color("AccentColor"), lineWidth: 3)
                        .rotationEffect(.init(degrees: -90))
                }
            )
            .onLongPressGesture(minimumDuration: 5, maximumDistance: 200) { (isPressing) in
                if isPressing {
                        withAnimation(.linear(duration: 0.2)) {
                            isHolding = true
                        }
                        longFunction = true
                    if (!isActive) {
                        withAnimation(.easeOut(duration: 4).delay(1)) {
                            progress = 1
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                            withAnimation(.linear(duration: 0.2)) {
                                isHolding = false
                            }
                            if (!isActive) {
                                withAnimation(.easeInOut) {
                                    progress = 0
                                }
                            }
                            longFunction = false
                        }
                }
            } perform: {
                if (!isActive) {
                    withAnimation(.linear(duration: 0.2)) {
                        isHolding = false
                    }
                    withAnimation(.easeInOut) {
                        progress = 0
                    }
                    isCompleted = true
                    hapticManager.startProlongedHapticFeedback(duration: 0.5)
                    longAction()
                }
            }
    }
}

struct AppsButtonStyle: ButtonStyle {
    var isActive: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.top, 15)
            .padding(.bottom, 15)
            .padding(.trailing, 30)
            .padding(.leading, 30)
            .contentShape(Rectangle())
            .background(
                Group {
                    if !isActive {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color("GradientOne"), Color("GradientTwo")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing)
                            )
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x:10, y:10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .shadow(color: Color.gray.opacity(0.1), radius: 10, x:-10, y:10)
                            .shadow(color: Color.gray.opacity(0.1), radius: 10, x:10, y:-10)
                    } else {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color("GradientTwo"), Color("GradientOne")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing)
                                .shadow(
                                    .inner(color: Color.gray.opacity(0.5), radius: 10, x: -5, y: 5)
                                )
                                .shadow(
                                    .inner(color: Color.gray.opacity(0.2), radius: 10, x: 5, y: -5)
                                )
                                .shadow(
                                    .inner(color: Color.white.opacity(0.9), radius: 10, x: -5, y: -5)
                                )
                                .shadow(
                                    .inner(color: Color.gray.opacity(0.4), radius: 13, x: 5, y: 5)
                                )
                            )
                            .cornerRadius(20)
                            .shadow(color: Color.white.opacity(0.3), radius: 2, x: 1, y: 1)
                            .shadow(color: Color.gray.opacity(0.5), radius: 2, x: -1, y: -1)
                    }
                }
            )
    }
}

func resetData() {
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
}

struct ContentView: View {
    @Environment(\.requestReview) private var requestReview
    @StateObject var picker = AppPicker.shared
    var blockManager = BlockManager.shared
    @StateObject var nfcManager = NFCScan()
    @State private var isPresented: Bool = false
    @State private var isEmergencyPresented: Bool = false
    
    @State private var scannedValue: String = "No NFC data"
    
    @State private var blocked: Bool = UserDefaults.standard.bool(forKey: "blocked")
    @State private var canSee: Bool = false
    
    @State private var localEmpty: Bool = true
    
    @State private var date: String? = UserDefaults.standard.string(forKey: "date")
    @State private var clock: String = "(✿◠‿◠)"
    
    @State private var longFunction: Bool = false
    @State private var isCompleted: Bool = false
    @State private var timeHeld: Int = 0
    
    @State private var isDrained: Bool = UserDefaults.standard.bool(forKey: "isDrained")
    @State private var entryDate: Date = (UserDefaults.standard.object(forKey: "entryDate") as? Date ?? Date())
    
    @State private var didAsk: Bool = UserDefaults.standard.bool(forKey: "didAsk")
    @State private var notFirstTime: Bool = UserDefaults.standard.bool(forKey: "notFirstTime")
    
    // SETTINGS FOR THE FUTURE:
    @State private var isNoEmergency: Bool = UserDefaults.standard.bool(forKey: "NoEmergencyButton")
    @State private var isNoLiveActivity: Bool = UserDefaults.standard.bool(forKey: "NoLiveActivity")
    
    let calendar = Calendar.current
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    let formatter = DateFormatter()
    func longAction() {
            if (localEmpty) {
                isPresented = true
            } else {
                picker.initiateKill()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                UserDefaults.standard.set(true, forKey: "blocked")
                let currentDate = Date()
                let formattedDateString = formatter.string(from: currentDate)
                UserDefaults.standard.set(formattedDateString, forKey: "date")
                date = formattedDateString
                withAnimation(.easeInOut(duration: 0.5)) {
                    blocked = true
                }
                blockManager.createBlockRequest(initDate: Date())
            }
    }
    
    func shortAction() {
            if (localEmpty && !blocked) {
                isPresented = true
            } else {
                nfcManager.scan(message: blocked ? "Hold near the KillSwitch to leash yourself back in" : "Hold near the KillSwitch to unleash your creativity")
                scannedValue = nfcManager.word
            }
    }
    
    func unBlock() {
        picker.initiateRevive()
        withAnimation(.easeInOut(duration: 0.5)) {
            blocked = false
        }
        UserDefaults.standard.set(false, forKey: "blocked")
        Task {
            print("boba")
            await blockManager.endBLockActivity()
        }
    }
    
    var body: some View {
        
        ZStack {
            Color("FillColor")
                .ignoresSafeArea()
            
            if (canSee) {
                ZStack(alignment: .center) {
                    if (blocked && !isNoEmergency) {
                        Button(action: {
                            Task {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                isEmergencyPresented = true
                            }
                        }) {
                            Image(systemName: "exclamationmark.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("AccentColor"))
                        }.buttonStyle(EmergencyButtonStyle(isBlocked: blocked, isDrained: isDrained))
                            .offset(y: 330)
                            .disabled(isDrained)
                            .alert("Emergency unblock?", isPresented: $isEmergencyPresented) {
                                Button("Cancel", role: .cancel) { }
                                Button("Unblock!") {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isDrained = true
                                    }
                                    UserDefaults.standard.set(isDrained, forKey: "isDrained")
                                    unBlock()
                                }
                            } message: {
                                Text("You only have one unblock per day!\n Be wise with your usage!")
                            }
                    }
                    
                    ZStack(alignment: .bottom) {
                        
                        Rectangle()
                            .fill(
                                Color("FillColor")
                                    .shadow(
                                        .inner(color: Color.white.opacity(0.2), radius: 2, x:1, y:1)
                                    )
                                    .shadow(
                                        .inner(color: Color.gray.opacity(0.5), radius: 2, x:-1, y:-1)
                                    )
                            )
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x:10, y:10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .shadow(color: Color.gray.opacity(0.1), radius: 10, x:-10, y:10)
                            .shadow(color: Color.gray.opacity(0.1), radius: 10, x:10, y:-10)
                            .frame(width: 130, height: 85)
                        
                        Text(clock)
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                    .offset(y: -385)
                    
                    Button(action: {
                        Task {
                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                            generator.impactOccurred()
                            shortAction()
                        }
                    }) {
                        Image(systemName: "power")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(Color("AccentColor"))
                    }.buttonStyle(CircleButtonStyle(isActive: blocked, longAction: longAction))
                        .offset(y: -15)
                    
                    Button(action: {
                        isPresented = true
                    }) {
                        HStack{
                            Text("Select Apps \n To Lock")
                                .foregroundColor(Color("AccentColor"))
                                .font(.system(size: 16, weight: .bold))
                                .multilineTextAlignment(.trailing)
                                .lineLimit(nil)
                            
                            Image(systemName: "lock")
                                .resizable()
                                .foregroundColor(Color("AccentColor"))
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                    }
                    .familyActivityPicker(isPresented: $isPresented, selection: $picker.selectionToDiscourage)
                    .buttonStyle(AppsButtonStyle(isActive: blocked))
                    .offset(y: 200)
                    .disabled(blocked)
                    .padding()
                    
                }
                .onAppear {
                    picker.updateSelection()
                    
                    if (!calendar.isDateInToday(entryDate)) {
                        entryDate = Date()
                        UserDefaults.standard.set(entryDate, forKey: "entryDate")
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isDrained = false
                        }
                        UserDefaults.standard.set(isDrained, forKey: "isDrained")
                    }
                    
//                    if (blocked) {
//                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                        
//                        let currentDate = Date()
//                        let formattedDateString = formatter.string(from: currentDate)
//                        let savedDate = formatter.date(from: date ?? formattedDateString)
//                        blockManager.createBlockRequest(initDate: savedDate!)
//                    }
                    
                    Task {
                        do {
                            try await picker.auth()
                            if (!notFirstTime) {
                                isPresented = true
                                notFirstTime = true
                                UserDefaults.standard.set(true, forKey: "notFirstTime")
                            }
                        } catch {
                            throw error
                        }
                    }
                }
                .onReceive(nfcManager.$word) { newWord in
                    scannedValue = newWord
                    if (scannedValue == "KillSwitch") {
                        if (blocked) {
                            unBlock()
                            if (!didAsk) {
                                didAsk = true
                                UserDefaults.standard.set(true, forKey: "didAsk")
                                requestReview()
                            }
                        } else {
                            picker.initiateKill()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            UserDefaults.standard.set(true, forKey: "blocked")
                            let currentDate = Date()
                            let formattedDateString = formatter.string(from: currentDate)
                            UserDefaults.standard.set(formattedDateString, forKey: "date")
                            date = formattedDateString
                            withAnimation(.easeInOut(duration: 0.5)) {
                                blocked = true
                            }
                            blockManager.createBlockRequest(initDate: Date())
                        }
                    }
                }
                .onReceive(picker.$isEmpty) { isEmpty in
                    localEmpty = isEmpty
                }
                .onReceive(timer, perform: { value in
                    if (blocked) {
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        let currentDate = Date()
                        let formattedDateString = formatter.string(from: currentDate)
                        let savedDate = formatter.date(from: date ?? formattedDateString)
                        let calculatedTime = Date().timeIntervalSince(savedDate!)
                        let hours = Int(calculatedTime) / 3600
                        let minutes = (Int(calculatedTime) - (hours * 3600)) / 60
                        
                        clock = "\(hours)h \(minutes)m"
                        
                        
                    } else {
                        clock = "(✿◠‿◠)"
                    }
                })
                .padding()
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                canSee = true
            }
        }
        
    }
}

//#Preview {
//    ContentView()
//        .onAppear() {
//            resetData()
//        }
//}
