//
//  LoginView.swift
//  TEST
//
//  Created by  Erwin on 2022/5/17.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseStorage

import FirebaseFirestoreSwift
struct LoginView:View{
    let userViewModel=UserViewModel()
    @Binding var mail:String
    @Binding var password:String
    @State private var alertMsg = ""
    @State private var showAlert = false
    @State private var showView = false
    @State private var not_first_login = false
    @FirestoreQuery(collectionPath: "users") var users: [UserData]
    var body: some View{
        NavigationView {
            VStack(spacing:10){
                TextField("Email",text:$mail)
                    .padding(.leading)
                TextField("Password",text:$password)
                    .padding(.leading)
                
                HStack{
                    Button(action: {
                        userViewModel.userSingIn(userEmail: mail, password: password){
                            (result) in
                            switch result {
                            case .success( _):
                                
                                if let user = Auth.auth().currentUser {
                                    print("\(user.uid) 登入成功")
                                    for u in users{
                                        if u.id == user.uid{
                                            not_first_login=true
                                        }
                                    }
                                    showView=true
                                } else {
                                    print("登入失敗")
                                }
                            case .failure(let errormsg):
                                switch errormsg {
                                case .pwInvalid:
                                    alertMsg = "密碼錯誤"
                                    showAlert = true
                                case .noAccount:
                                    alertMsg = "帳號不存在，請註冊或使用其他帳號"
                                    showAlert = true
                                case .others:
                                    alertMsg = "不明原因錯誤，請重新登入"
                                    showAlert = true
                                }
                            }
                        }
                    }, label: {
                        ZStack{
                            Text("登入")
                            
                        }
                    })
                    if not_first_login{
                        EmptyView().fullScreenCover(isPresented: $showView)
                        { UserView()}
                    }else{
                        EmptyView().fullScreenCover(isPresented: $showView)
                        { FirstLoginView(mail: mail, password: password)
                        }
                        
                        
                    }
                    NavigationLink{RegisterView()} label:{
                            Text("註冊")
                        }
                }
            }.background(Image("background").edgesIgnoringSafeArea(.all))
                .alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: Text("錯誤"), message: Text(alertMsg),  dismissButton: .default(Text("重新輸入")))
                }
        }
        
    }
    
}
