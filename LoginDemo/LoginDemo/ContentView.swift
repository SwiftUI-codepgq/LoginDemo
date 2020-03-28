//
//  ContentView.swift
//  LoginDemo
//
//  Created by 盘国权 on 2020/3/27.
//  Copyright © 2020 pgq. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var loginAccountIsActive: Bool = false
    @State private var loginPhoneIsActive: Bool = false
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: LoginAccountView(),
                    isActive: $loginAccountIsActive) {
                        Text("使用账户密码登录")
                }
                NavigationLink(
                    destination: LoginPhoneView(),
                    isActive: $loginPhoneIsActive) {
                        Text("使用手机号验证码登录")
                }
            }

            .navigationBarTitle(Text("登录Demo"), displayMode: .large)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
