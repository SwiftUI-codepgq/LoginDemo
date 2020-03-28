//
//  DismissKeyboard.swift
//  SwiftUI-project-Login
//
//  Created by pgq on 2020/3/25.
//  Copyright © 2020 pq. All rights reserved.
//

/**
 隐藏键盘的方法，在你需要的隐藏的时候调用
 ...
 .modifier(DismissKeyboard())
 
  或者在你需要的时候
 self.endEditing()
 */

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

struct DismissKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content.onTapGesture {
            content.endEditing()
        }
    }
}

struct DismissKeyboardBuilder<Content: View>: View {
    let content: Content
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content.onTapGesture {
            self.content.endEditing()
        }
    }
}

extension Spacer {
    func tapDismissKeyboard() -> some View {
        ZStack {
            Color.black.opacity(0.001)
                .modifier(DismissKeyboard())
            self
        }
    }
}


public struct DismissKeyboardSpacer: View {
    public private(set) var minLength: CGFloat? = nil
    
    public init(minLength: CGFloat? = nil) {
        self.minLength = minLength
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.001)
                .modifier(DismissKeyboard())
            Spacer(minLength: minLength)
        }
        .frame(height: minLength)
    }
    
}
