//
//  ContentView.swift
//  TEST
//
//  Created by User02 on 2022/5/4.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift
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
        
            
            LoginView(mail:$mail,password:$password)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
