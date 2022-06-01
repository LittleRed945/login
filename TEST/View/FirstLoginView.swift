//
//  UserView.swift
//  TEST
//
//  Created by  Erwin on 2022/5/31.
//

import Foundation
import SwiftUI
struct FirstLoginView: View {
    var mail: String
    var password: String
    @State private var userNickName = ""
    @State private var userGender = ""
    @State private var userFirstLoginStr = ""
    @State private var userBD = Date()
    @State private var currentDate = Date()
    let myDateFormatter = DateFormatter()
    let flgFormatter = DateFormatter()
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack{
                    Form{
                        Text("設定個人資料")
                            .font(.system(size: 27))
                            .bold()
                        Group{
                            HStack{
                                Image(systemName: "person.crop.circle")
                                TextField("輸入暱稱", text: $userNickName)
                            }
                            HStack{
                                Image(systemName: "g.circle")
                                Text("性別")
                                Spacer()
                                Picker(selection: $userGender, label: Text("性別")) {
                                    Text("男生").tag(0)
                                    Text("女生").tag(1)
                                }.pickerStyle(SegmentedPickerStyle())
                                    .frame(width: 100)
                                    .shadow(radius: 5)
                            }
                            HStack{
                                Image(systemName: "calendar")
                                Text("生日")
                                Spacer()
                                Text(myDateFormatter.string(from: userBD))
                            }
                            DatePicker("生日", selection: $userBD, in: ...Date(), displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                            
                        }
                        
                    }
                    NavigationLink(destination: {CustomizedCharacterView()}, label: {Button("創建你的角色"){}})
                }.background(Image("background").resizable().scaledToFill())
                    .onAppear(){
                        myDateFormatter.dateFormat = "y MMM dd"
                        flgFormatter.dateFormat = "y MMM dd HH:mm"
                                        //記錄第一次登入時間
                                        self.userFirstLoginStr = flgFormatter.string(from: currentDate)
                    }
            }
        }
    }
}
