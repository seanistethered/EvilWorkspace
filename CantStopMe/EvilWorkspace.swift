//
//  EvilWorkspace.swift
//  EvilWorkspace
//
//  Created by fridakitten on 03.05.25.
//

import Foundation
import SwiftUI
import os

func pthread_dispatch(_ code: @escaping () -> Void) {
    var thread: pthread_t?
    let blockPointer = UnsafeMutableRawPointer(Unmanaged.passRetained(code as AnyObject).toOpaque())
    
    pthread_create(&thread, nil, { ptr in
        let unmanaged = Unmanaged<AnyObject>.fromOpaque(ptr)
        let block = unmanaged.takeRetainedValue() as! () -> Void
        block()
        return nil
    }, blockPointer)
}

enum EvilEnum: Int {
    case stayalive = 0
    case restart = 2
}

let trollapps: [String] = [
    "com.apple.Preferences",
    "com.apple.mobilesafari",
    "com.apple.MobileSMS"
]

func EvilWorkspace(mode: EvilEnum) {
    
    @AppStorage("isEvil") var isEvil: Bool = false
    @AppStorage("stayalivev2") var stayalivev2: Bool = false
    
    pthread_dispatch {
        while true {
            EvilOpen(Bundle.main.bundleIdentifier!)
            if !isEvil, mode == .stayalive { return }
        }
    }
    
    if stayalivev2 {
        pthread_dispatch {
            while true {
                for app in trollapps {
                    EvilOpen(app)
                    if !isEvil, mode == .stayalive { return }
                }
            }
        }
    }
    
    switch mode {
    case .restart:
        pthread_dispatch {
            Thread.sleep(forTimeInterval: 1.0)
            exit(0)
        }
        break
    case .stayalive:
        break
    }
}
