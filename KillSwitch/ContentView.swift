//
//  ContentView.swift
//  KillSwitch
//
//  Created by GooseMooz on 2024-08-29.
//

import Foundation
import SwiftUI
import FamilyControls

struct CircleButtonStyle: ButtonStyle {
    var isActive: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(85)
            .contentShape(Circle())
            .background(
                Group {
                    if !configuration.isPressed {
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
                }
            )
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

struct ContentView: View {
    @StateObject var picker = AppPicker.shared
    @StateObject var nfcManager = NFCScan()
    @State private var isPresented: Bool = false
    @State private var scannedValue: String = "No NFC data"
    @State private var blocked: Bool = UserDefaults.standard.bool(forKey: "blocked")
    @State private var localEmpty: Bool = true
    @State private var date: String? = UserDefaults.standard.string(forKey: "date")
    @State private var clock: String = "(✿◠‿◠)"
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    let formatter = DateFormatter()
    
    var body: some View {
        
        ZStack {
            Color("FillColor")
                .ignoresSafeArea()
            
            ZStack(alignment: .center) {
                
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
                
                
                if (!localEmpty) {
                    Button(action: {
                        Task {
                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                            generator.impactOccurred()
                            
                            nfcManager.scan(message: blocked ? "Hold near the KillSwitch to leash yourself back in" : "Hold near the KillSwitch to unleash your creativity")
                            scannedValue = nfcManager.word
                        }
                    }) {
                        Image(systemName: "power")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(Color("AccentColor"))
                    }.buttonStyle(CircleButtonStyle(isActive: blocked))
                        .offset(y: -15)
                }
                
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
                
                Task {
                    do {
                        try await picker.auth()
                    } catch {
                        throw error
                    }
                }
            }
            .onReceive(nfcManager.$word) { newWord in
                scannedValue = newWord
                if (scannedValue == "KillSwitch") {
                    if (blocked) {
                        picker.initiateRevive()
                        blocked = false
                        UserDefaults.standard.set(false, forKey: "blocked")
                    } else {
                        picker.initiateKill()
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        UserDefaults.standard.set(true, forKey: "blocked")
                        let currentDate = Date()
                        let formattedDateString = formatter.string(from: currentDate)
                        UserDefaults.standard.set(formattedDateString, forKey: "date")
                        date = formattedDateString
                        blocked = true
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
}

#Preview {
    ContentView()
}
