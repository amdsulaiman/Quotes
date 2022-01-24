//
//  APIClient.swift
//  Quotes
//
//
//

import Foundation
import Alamofire
import KRProgressHUD

class APIClient {
    //Get Page number based Quotes
    static func webserviceForHomePageQuotes(Page:String,params:[String:Any],completion:@escaping(HomePage) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = base_url + get_quote_url+Page
      
       
        AF.request(url, method: .get)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                   
                    print("Response Error")
                    return }
                
                do{
                    let objRes: HomePage = try JSONDecoder().decode(HomePage.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    
    //Author Detail
       static func webserviceForAuthorDetails(AuthorName:String,params:[String:Any],completion:@escaping(AuthorBio) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
               GlobalObj.displayLoader(true, show: false)
                   GlobalObj.showNetworkAlert()
                     return
           }
           let url = base_url + get_author_with_slugname + AuthorName

           AF.request(url, method: .get)
               .responseJSON { response in
                   
                guard let dataResponse = response.data else {
                       print("Response Error")
                       return }
                   
                   do{
                       let objRes: AuthorBio = try JSONDecoder().decode(AuthorBio.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                       GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                       GlobalObj.displayLoader(true, show: false)
                   }
               }
       }
 
    //Author Quotes
    static func webserviceForAuthorQuotes(AuthorName:String,params:[String:Any],completion:@escaping(AuthorQuotes) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                GlobalObj.showNetworkAlert()
                  return
        }
        let url = base_url + get_quotes_for_author + AuthorName

        AF.request(url, method: .get)
            .responseJSON { response in
                
             guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: AuthorQuotes = try JSONDecoder().decode(AuthorQuotes.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    // Get Tags
     static func webserviceForGetTags(completion:@escaping([GetTags]) -> Void){
         if !NetworkReachabilityManager()!.isReachable{
             GlobalObj.displayLoader(true, show: false)

                   GlobalObj.showNetworkAlert()
                   return
         }
         let url = base_url + get_tags_url
        

         AF.request(url, method: .get)
             .responseJSON { response in
                 
                 guard let dataResponse = response.data else {
                     print("Response Error")
                     return }
                 
                 do{
                    let objRes : [GetTags]  = try JSONDecoder().decode([GetTags].self, from: dataResponse)
                     switch response.result{
                                    case .success( _):
                                            completion(objRes)
                                    case .failure(let error):
                                        print(error)
                                     GlobalObj.displayLoader(true, show: false)

                                    }
                 }catch let error{
                     print(error)
                     GlobalObj.displayLoader(true, show: false)

                 }
             }
     }
     
    //Get Quotes by Tags
    static func webserviceForGetQuotesbtTags(Tag:String,params:[String:Any],completion:@escaping(Tags) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                GlobalObj.showNetworkAlert()
                  return
        }
        let url = base_url + get_quotes_for_tags+Tag

        AF.request(url, method: .get)
            .responseJSON { response in
                
             guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: Tags = try JSONDecoder().decode(Tags.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    
    //Get Authors
       static func webserviceForGetAuthor(params:[String:Any],completion:@escaping(AuthorBio) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
               GlobalObj.displayLoader(true, show: false)
                   GlobalObj.showNetworkAlert()
                     return
           }
           let url = base_url + get_authors_url

           AF.request(url, method: .get)
               .responseJSON { response in
                   
                guard let dataResponse = response.data else {
                       print("Response Error")
                       return }
                   
                   do{
                       let objRes: AuthorBio = try JSONDecoder().decode(AuthorBio.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                       GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                       GlobalObj.displayLoader(true, show: false)
                   }
               }
       }
    
    
    
    
    
    
    
    
}

 
