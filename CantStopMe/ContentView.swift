//
//  ContentView.swift
//  CantStopMe
//
//  Created by fridakitten on 03.05.25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isEvil") var isEvil: Bool = false
    @AppStorage("stayalivev2") var stayalivev2: Bool = false
    
    init() {
        EvilFind()
        if isEvil {
            EvilWorkspace(mode: .stayalive)
        }
    }
    
    var body: some View {
        VStack {
            Text("Evil")
                .foregroundColor(.red)
                .font(.system(size: 40)) +
            Text("Workspace")
                .foregroundColor(.primary)
                .font(.system(size: 40))
            Spacer()
            List {
                Section(header: Text("Persistence"),
                        footer: Text("This option makes ur phone even more unresposive than before! THIS IS A WARNING!")) {
                    Toggle("Switcher Trolling", isOn: $stayalivev2)
                }
                Section(footer: Text("Triggers the persistence exploit")) {
                    Button(isEvil ? "Dont be Evil" : "Be Evil") {
                        if !isEvil {
                            EvilWorkspace(mode: .stayalive)
                        }
                        isEvil = !isEvil
                    }
                    .foregroundColor(isEvil ? .red : .blue)
                }
                Section(header: Text("App life cycle"),
                        footer: Text("Restarts the app.")) {
                    Button("Restart App") {
                        EvilWorkspace(mode: .restart)
                    }
                    .disabled(isEvil)
                }
            }
            .cornerRadius(20)
            Spacer()
            Text("PID: \(String(getpid()))")
            Text("Discovered by.SeanIsTethered")
            Section {
                
            }
        }
        .padding()
    }
}
