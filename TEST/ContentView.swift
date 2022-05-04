//
//  ContentView.swift
//  TEST
//
//  Created by User02 on 2022/5/4.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift
func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let fileReference = Storage.storage().reference().child(UUID().uuidString + ".jpg")
        if let data = image.jpegData(compressionQuality: 0.9) {
            
            fileReference.putData(data, metadata: nil) { result in
                switch result {
                case .success(_):
                    fileReference.downloadURL { result in
                        switch result {
                        case .success(let url):
                            completion(.success(url))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
struct ContentView: View {
    @State var mail = ""
    @State var password=""
    var body: some View {
        VStack(spacing:10){
            TextField("Email",text:$mail)
                .padding(.leading)
            TextField("Password",text:$password)
                .padding(.leading)
                
            HStack{
                Button(action: {
                    Auth.auth().signIn(withEmail: mail, password: password) { result, error in
                         guard error == nil else {
                            print(error?.localizedDescription)
                            return
                         }
                    }
                }, label: {
                    ZStack{
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                        
                    }
                })
                Button("create user"){
                    Auth.auth().createUser(withEmail: mail, password: password) { result, error in
                                
                         guard let user = result?.user,
                               error == nil else {
                             print(error?.localizedDescription)
                             return
                         }
                         print(user.email, user.uid)
                    }
                }

            }
            Button("upload image"){
                let uiImage = UIImage(named: "heart")
                uploadPhoto(image: uiImage!) { result in
                    switch result {
                    case .success(let url):
                       print(url)
                    case .failure(let error):
                       print(error)
                    }
                }
            }
        }
        
            }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
