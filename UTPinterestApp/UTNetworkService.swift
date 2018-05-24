import Foundation
import PinterestSDK

class UTNetworkService {
    
    //MARK: Properties
    var user = PDKUser()
    var greetingWithName: String!
    
    
    //MARK: Methods
    func authenticateUser(from viewController: UIViewController) {
        let permissions = [PDKClientReadPublicPermissions,
                           PDKClientWritePublicPermissions,
                           PDKClientReadRelationshipsPermissions,
                           PDKClientWriteRelationshipsPermissions]
        PDKClient.sharedInstance().authenticate(withPermissions:permissions,
                                                from: viewController,
                                                withSuccess: { response in
                                                    self.userData(completion: { withGreeting in
                                                        self.greetingWithName = withGreeting
                                                        print(self.greetingWithName ?? "fuck")
                                                    })
        }, andFailure: { error in
            print("Error:`\(String(describing: error?.localizedDescription))`")
        })
    }
    
    func userData(completion: @escaping (String) -> ()) {
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
    }
}
