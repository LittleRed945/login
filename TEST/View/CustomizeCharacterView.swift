//
//  CustomizeCharacterView.swift
//  TEST
//
//  Created by  Erwin on 2022/5/18.
//

import Foundation
import SwiftUI
import FirebaseAuth
struct CustomizedCharacterView:View{
    //character model
    @State private var character=Character()
    //
    @State private var show_style_all=false
    @State private var now_style:Style = .none
    @State private var hair_contrast:Double=1
    @State private var shirt_contrast:Double=1
    @State private var pants_contrast:Double=1
    @State private var shoes_contrast:Double=1
    var body: some View{
        HStack(spacing:0.0){
            ShowComponentsView(character: $character, style_name: now_style)
            VStack(spacing: 0.0){
                
                //                    Button("down"){
                //                        character.action=(character.action+1)%8
                //                        character.offset.height+=1
                //                    }.
                //
                //                    Button("change direction"){
                //                        character.direction=(character.direction+1)%4
                //                    }
                Button(action: {
                    show_style_all=true
                    now_style = .hair
                    hair_contrast=1
                    shirt_contrast=0.5
                    pants_contrast=0.5
                    shoes_contrast=0.5
                }, label: {
                    Image("hair_button").contrast(hair_contrast)
                    //.resizable().scaledToFit().frame(width: 108, height: 108)
                })
                Button(action: {
                    show_style_all=true
                    now_style = .shirt
                    hair_contrast=0.5
                    shirt_contrast=1
                    pants_contrast=0.5
                    shoes_contrast=0.5
                }, label: {
                    Image("hair_button").contrast(shirt_contrast)
                })
                Button(action: {
                    show_style_all=true
                    now_style = .pants
                    hair_contrast=0.5
                    shirt_contrast=0.5
                    pants_contrast=1
                    shoes_contrast=0.5
                }, label: {
                    Image("pants_button").contrast(pants_contrast)
                })
                Button(action: {
                    show_style_all=true
                    now_style = .shoes
                    hair_contrast=0.5
                    shirt_contrast=0.5
                    pants_contrast=0.5
                    shoes_contrast=1
                }, label: {
                    Image("shoes_button").contrast(shoes_contrast)
                })
                Button("logout"){
                    do {
                        try Auth.auth().signOut()
                        if Auth.auth().currentUser == nil {
                            print("登出成功")
                        }
                    }
                    catch {
                        print("登出錯誤")
                    }
                }
            }
            Spacer()
            ZStack{
                Image("char\(character.char)-\(character.direction)-\(character.action)").resizable().scaledToFit().frame(width: 108, height: 108).offset(character.offset)
                Image("hair\(character.hair)-\(character.direction)-\(character.action)").resizable().scaledToFit().frame(width: 108, height: 108).offset(character.offset)
                Image("shirt\(character.shirt)-\(character.direction)-\(character.action)").resizable().scaledToFit().frame(width: 108, height: 108).offset(character.offset)
                Image("pants\(character.pants)-\(character.direction)-\(character.action)").resizable().scaledToFit().frame(width: 108, height: 108).offset(character.offset)
                Image("shoes\(character.shoes)-\(character.direction)-\(character.action)").resizable().scaledToFit().frame(width: 108, height: 108).offset(character.offset)
            }
        }.background(Image("background").resizable().scaledToFill())
    }
    
    
}

