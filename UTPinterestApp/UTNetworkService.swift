import Foundation
import PinterestSDK
import SwiftyJSON

class PinDetails {
    var url: String?
    var size: CGSize = .zero
    var color: UIColor?
}

class UTNetworkService {
    
    //MARK: Properties
    var user = PDKUser()
    
    //MARK: Methods
    
    func userData(authorizationViewController: UIViewController, completion: @escaping (String) -> ()) {
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
            self.authenticateUser(from: authorizationViewController)
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
                                                    self.userData(authorizationViewController: viewController, completion: { withGreeting in
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
    
    func loadPinDetails(_ pinIdentifier: String,
                        completion: @escaping (PinDetails) -> ()) {
        let fields: Set = ["image", "color"]
        PDKClient.sharedInstance().getPinWithIdentifier(pinIdentifier, fields: fields, withSuccess: {
            let pin = JSON($0?.pin().images["original"] as Any)
            let details = PinDetails()
            
            if let hexColor = JSON($0?.parsedJSONDictionary as Any)["color"].string {
                details.color = UIColor.hexStringToUIColor(hex: hexColor)
            }
            
            if let rawURL = pin["url"].string {
                details.url = rawURL
            }
            
            if let width = pin["width"].double {
                details.size.width = CGFloat(width)
            }
            
            if let height = pin["height"].double {
                details.size.height = CGFloat(height)
            }
            completion(details)
        }) { print($0) }
    }
}
