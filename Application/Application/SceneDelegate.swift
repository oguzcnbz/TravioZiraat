//
//  SceneDelegate.swift
//  Bilge_Adam_iOS2
//
//  Created by İsmail Caferoğlu on 3.10.2023.
//

import UIKit
import TinyConstraints

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
      //  let dispatchGroup = DispatchGroup()

//        let vc = LoginVC()
//
//        let rootViewController = UINavigationController(rootViewController: vc)
//        window.rootViewController = rootViewController
//        window.makeKeyAndVisible()
//        self.window = window


        
        hasUserLoggedIn { isLoggedIn in
                if isLoggedIn {
                    let vc = MainTabbar()
                    let rootViewController = UINavigationController(rootViewController: vc)
                    self.window?.rootViewController = rootViewController
                    self.window?.makeKeyAndVisible()
                } else {
                    let vc = LoginVC()
                    let rootViewController = UINavigationController(rootViewController: vc)
                    self.window?.rootViewController = rootViewController
                    self.window?.makeKeyAndVisible()
                }
            }
        
    }
    /// Description: Accestoken aktıf mı kontrolu için   accesToken kullanarak kullanıcı verısı çekme yapıyorum. obj?.fullName veri varsa acces token aktıf ana sayfaya yönlendırıyorum aktıf degılse logıne donuyor.
  
    func hasUserLoggedIn(completion: @escaping (Bool) -> Void) {
        guard let accessToken = KeychainHelper.shared.read(service: "user-key", account: "accessToken") else {
            print("accessToken bulunamadı")
            completion(false)
            return
           
                               
        }

        guard let refreshToken = KeychainHelper.shared.read(service: "user-key", account: "refreshToken") else {
            print("refreshToken bulunamadı")
            completion(false)
            return
          
        }

        checkAccessTokenValid { isValid in
            completion(isValid)
        }
    }
    
    func checkAccessTokenValid(completion: @escaping (Bool) -> Void) {
      
        
        
           NetworkingHelper.shared.getDataFromRemote(urlRequest: .profileGet) { (result: Result<ProfileModel, Error>) in
               switch result {
               case .success(let success):
                   print(success)
                   completion(true)
                   
               case .failure(_):
                   // isAccessTokenValid(false)
                   completion(false)
               }
           }
       }

    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

