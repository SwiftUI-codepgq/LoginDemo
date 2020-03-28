//
//  LoginAccountView.swift
//  LoginDemo
//
//  Created by 盘国权 on 2020/3/27.
//  Copyright © 2020 pgq. All rights reserved.
//

import SwiftUI

struct LoginAccountView: View {
    @State var account: String = ""
    @State var password: String = ""
    @State var showPwd = false
    var isCanLogin: Bool {
        account.count > 0 &&
        password.count > 0
    }
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                TextField("请输入账号", text: $account, onCommit: {
                    
                })
            }
            Divider()
            HStack {
                Image(systemName: "lock")
                if showPwd {
                    TextField("请输入密码", text: $password, onCommit: {
                        
                    })
                } else {
                    SecureField("请输入密码", text: $password, onCommit: {
                        
                    })
                }
                Button(action: {
                    self.showPwd.toggle()
                }) {
                    Image(systemName: self.showPwd ? "eye" : "eye.slash")
                }
                
            }
            Divider()
            Button(action: {
                print("login action")
            }) {
                Text("Login")
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 45, alignment: .center)
            .background(isCanLogin ? Color.blue: Color.gray)
            .cornerRadius(10)
            .disabled(!isCanLogin)
            Spacer()
        }
        .padding(.top, 100)
        .padding(.leading)
        .padding(.trailing)
    }
}

struct LoginAccountView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAccountView()
    }
}


struct XXX {
    var x = 0
    
    mutating func update() {
        x=1
    }
}
