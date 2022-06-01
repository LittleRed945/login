import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
class UserViewModel{
    //建立帳號
    func createUser(userEmail: String, password: String, completion: @escaping((Result<String, RegError>) -> Void)) {
        Auth.auth().createUser(withEmail: userEmail, password: password) { result, error in
            guard let user = result?.user,
                  error == nil else {
                      if (error?.localizedDescription == "The email address is badly formatted."){
                          completion(.failure(RegError.emailFormat))
                      }
                      else if(error?.localizedDescription == "The password must be 6 characters long or more."){
                          completion(.failure(RegError.pwtooShort))
                      }
                      else if(error?.localizedDescription == "The email address is already in use by another account."){
                          completion(.failure(RegError.emailUsed))
                      }
                      else {
                          completion(.failure(RegError.others))
                      }
                      return
                  }
            print(user.email, user.uid)
            completion(.success(user.uid))
        }
    }
    
    //帳密登入
    func userSingIn(userEmail: String, password: String, completion: @escaping((Result<String, LoginError>) -> Void)) {
        Auth.auth().signIn(withEmail: userEmail, password: password) { result, error in
            guard error == nil else {
                print(error?.localizedDescription)
                if (error?.localizedDescription == "The password is invalid or the user does not have a password.") {
                    completion(.failure(LoginError.pwInvalid))
                }
                else if (error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted.") {
                    completion(.failure(LoginError.noAccount))
                }
                else {
                    completion(.failure(LoginError.others))
                }
                return
            }
            completion(.success("Success"))
        }
    }
    //讀取某個collection下全部的 documents
    func fetchUsers () {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: UserData.self)
                
            }
            //print(users)
            
        }
    }
    func userSingOut() -> Void {
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
