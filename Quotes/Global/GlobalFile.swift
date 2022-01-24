//
//  GlobalFile.swift
//  Quotes
//
//  
//

import Foundation
import Foundation
import UIKit
import KRProgressHUD
import Alamofire
let GlobalObj = Global()
class Global {
    
    //MARK:- Network Alert
      func isNetworkAvailable() -> Bool{
          if !NetworkReachabilityManager()!.isReachable{

              return false
          }else{
              return true
          }
      }
      func showNetworkAlert(){
          let alert = UIAlertController(title: "No network", message: "Please check your internet connection.", preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          // show the alert
          UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

  //        alert.show()
      }
    
    // MARK: - Loading-
    func displayLoader(_ shouldDisplay: Bool, show: Bool) {
        if shouldDisplay {
            if show {
                // display loader
                presentIndicator()
            } else {
                // hide loader
                dismissIndicator()
            }
        }
    }
    
    //Present Loader
    func presentIndicator() {
        DispatchQueue.main.async {
           UIApplication.shared.windows.first?.isUserInteractionEnabled = false
            KRProgressHUD.show()
        }
    }
    
    //MARK:-Loader Function
    func dismissIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.isUserInteractionEnabled = true
            KRProgressHUD.dismiss()
        }
    }
    
}
