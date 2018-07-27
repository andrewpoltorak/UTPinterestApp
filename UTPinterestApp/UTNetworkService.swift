import Foundation
import PinterestSDK

class UTNetworkService {
    
    //MARK: Properties
    var user = PDKUser()
    
    //MARK: Methods
    
    func userData(completion: @escaping (String) -> ()) {
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
            self.authenticateUser()
        }
    }
    
    func authenticateUser() {
        let permissions = [PDKClientReadPublicPermissions,
                           PDKClientWritePublicPermissions,
                           PDKClientReadRelationshipsPermissions,
                           PDKClientWriteRelationshipsPermissions]
        PDKClient.sharedInstance().authenticate(withPermissions:permissions,
                                                from: ViewControllerAuthorization(),
                                                withSuccess: { response in
                                                    self.userData(completion: { withGreeting in
                                                        print(withGreeting)
                                                    })
        }, andFailure: { error in
            print("Error:`\(String(describing: error?.localizedDescription))`")
        })
    }
}
