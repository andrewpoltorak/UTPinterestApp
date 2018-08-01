import Foundation
import PinterestSDK

class UTNetworkService {
    
    //MARK: Properties
    var user = PDKUser()
    
    //MARK: Methods
    
    func userData(viewControllerAuthorization: UIViewController, completion: @escaping (String) -> ()) {
        if PDKClient.sharedInstance().authorized == true {
            let parameters: [String : String] = ["fields": "first_name,id,last_name,url,image,username,bio,counts,created_at,account_type"]
            PDKClient.sharedInstance().getPath("/v1/me/",
                                               parameters: parameters,
                                               withSuccess: { response in
                                                self.user = (response?.user())!
                                                var greeting: String!
                                                greeting = "Welcome " + self.user.firstName + self.user.lastName
                                                completion(greeting)
                                                
            }, andFailure: { error in
                print("Error:`\(String(describing: error?.localizedDescription))`")
            })
        } else {
            self.authenticateUser(from: viewControllerAuthorization)
        }
    }
    
    func authenticateUser(from viewController: UIViewController) {
        let permissions = [PDKClientReadPublicPermissions,
                           PDKClientWritePublicPermissions,
                           PDKClientReadRelationshipsPermissions,
                           PDKClientWriteRelationshipsPermissions]
        PDKClient.sharedInstance().authenticate(withPermissions:permissions,
                                                from: viewController,
                                                withSuccess: { response in
                                                    self.userData(viewControllerAuthorization: viewController, completion: { withGreeting in
                                                        print(withGreeting)
                                                    })
        }, andFailure: { error in
            print("Error:`\(String(describing: error?.localizedDescription))`")
        })
    }
    
    func getPins(completion: @escaping ([PDKPin]) -> ()) {
        PDKClient.sharedInstance().getPath("/v1/me/pins/",
                                           parameters: [:],
                                           withSuccess: { (response) in
                                            var pins: [PDKPin] = []
                                            pins = response?.pins() as! [PDKPin]
                                            completion(pins)
        }) { (Error) in
            print(Error ?? "Error")
        }
    }
}
