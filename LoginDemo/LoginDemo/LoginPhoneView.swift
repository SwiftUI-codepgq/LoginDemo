//
//  LoginPhoneView.swift
//  LoginDemo
//
//  Created by 盘国权 on 2020/3/27.
//  Copyright © 2020 pgq. All rights reserved.
//

import SwiftUI

struct LoginPhoneView: View {
     @State private var phoneNumber: String = ""
     @State private var code: String = ""
     @State private var phoneNumIsEdit = false
     @State private var codeIsEdit = false
     @State private var timer: Timer?
     @State private var countDown = 60
     var isPhoneNum: Bool {
         if phoneNumIsEdit {
             return phoneNumber.count == 11
         }
         return true
     }
     var isCode: Bool {
         if codeIsEdit {
             return code.count == 4
         }
         return true
     }
     var isCanLogin: Bool {
         isPhoneNum && isCode
     }
     var body: some View {
         VStack {
             VStack {
                 HStack {
                     Image(systemName: "phone.down.circle")
                         .rotationEffect(Angle(degrees: 90))
                     
                     PQTextField(placeholder: "请输入号码", maxLength: 11,text: phoneNumber, onEditing: { tf in
                        self.phoneNumIsEdit = true
                        self.phoneNumber = tf.text ?? ""
                     }, onCommit:  { tf in
                        self.phoneNumIsEdit = false
                        self.phoneNumber = tf.text ?? ""
                     })
                    .frame(height: 40)
                 }
                 if !isPhoneNum {
                     Text("手机号码应该是11位数字")
                         .font(.caption)
                         .foregroundColor(.red)
                 }
                 Divider()
             }
             
             VStack {
                 HStack {
                     PQTextField(placeholder: "请输入验证码", maxLength: 4, text: code, onEditing: { tf in
                        self.codeIsEdit = true
                        self.code = tf.text ?? ""
                     }, onCommit: { tf in
                        self.codeIsEdit = false
                        self.code = tf.text ?? ""
                     })
                         .frame(height: 40)
                     Button(action: {
          	               // get code
                        self.timer?.fireDate = Date.distantPast
                     }, label: {
                         Text((countDown == 60) ? "获取验证码" : "请\(countDown)s之后重试")
                     }).disabled(countDown != 60 || phoneNumber.count != 11)
                 }
                 if !isCode {
                     Text("请输入正确的验证码(4位数字)")
                         .font(.caption)
                         .foregroundColor(.red)
                         .frame(alignment: .top)
                 }
                 
                 Divider()
             }
             
             Button(action: {
                 print("login action", self.phoneNumber, self.code)
             }) {
                 Text("Login")
                     .foregroundColor(.white)
             }.frame(width: 100, height: 45, alignment: .center)
                 .background(isCanLogin ? Color.blue: Color.gray)
                 .cornerRadius(10)
                 .disabled(!isCanLogin)
             
             DismissKeyboardSpacer()
         }
         .onAppear {
             self.createTimer()
         }
         .onDisappear {
             self.invalidate()
         }
         .padding()
         
     }
     
     private func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                if self.countDown < 0 {
                    self.countDown = 0
                    t.invalidate()
                }
                self.countDown -= 1
            })
            // 先不触发定时器
            timer?.fireDate = .distantFuture
        }
     }
     
     private func invalidate() {
        timer?.invalidate()
     }
}

struct LoginPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPhoneView()
    }
}
