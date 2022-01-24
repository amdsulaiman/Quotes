//
//  HomeVC.swift
//  Quotes
//
// 
//

import UIKit
import Foundation
struct Favourites : Codable {
    var Content : String
    var Id : String
    var authorName : String
}

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var arrHomeFeed:[Results] = []
    var favouritesQuotesArr = [String]()
    var pageNumber = "1"
    var authorName = ""
    var vcValue = ""
    var quotesCount = 0
    var isFavourite  = true
    let defaults = UserDefaults.standard
    var MyFavArr : [Favourites]!
    var myfavArray = [Favourites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PageCount()
        callHomeQuoteWebservice()
//        do {
//            let storedObjects = UserDefaults.standard.object(forKey: "MyFavourites")
//            myfavArray = try JSONDecoder().decode([Favourites].self, from: storedObjects as! Data)
//            print(myfavArray.count)
//        }
//        catch let err {
//            print(err)
//        }
    }
    func setupTableview() {
        tblView.register(QuotesTableViewCell.nib(), forCellReuseIdentifier: "QuotesTableViewCell")
        tblView.backgroundColor = .white
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions1 = UIContextualAction(style: .normal, title: "", handler: { [self] action, view, completionHaldler in
            print("action1 performed")
            let data : Favourites = Favourites.init(Content:self.arrHomeFeed[indexPath.row].content.unsafelyUnwrapped, Id: self.arrHomeFeed[indexPath.row]._id.unsafelyUnwrapped, authorName: self.arrHomeFeed[indexPath.row].author.unsafelyUnwrapped)
            myfavArray.append(data)
            let storeItems = try! JSONEncoder().encode(myfavArray)
            UserDefaults.standard.set(storeItems, forKey: "MyFavourites")
            completionHaldler(true)
        })
        actions1.backgroundColor = .white
        actions1.image = #imageLiteral(resourceName: "favourite")
        return UISwipeActionsConfiguration(actions: [actions1])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions1 = UIContextualAction(style: .normal, title: "", handler: {  action, view, completionHaldler in
            print("action2 performed")
            let vc = self.storyboard?.instantiateViewController(identifier: "CreaterVC") as! CreaterVC
            vc.quoteContent = self.arrHomeFeed[indexPath.row].content.unsafelyUnwrapped
            vc.authorName = self.arrHomeFeed[indexPath.row].author.unsafelyUnwrapped
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            completionHaldler(true)
        })
        actions1.backgroundColor = .white
        actions1.image = #imageLiteral(resourceName: "create")
        return UISwipeActionsConfiguration(actions: [actions1])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHomeFeed.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuotesTableViewCell.identifier, for: indexPath) as! QuotesTableViewCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius = 8
        cell.baseView.layer.cornerRadius = 8
        cell.quotesContentLbl.text = "  “" + "\(arrHomeFeed[indexPath.row].content.unsafelyUnwrapped)"
        cell.authorNameLbl.text = "~ " + "\(arrHomeFeed[indexPath.row].author.unsafelyUnwrapped)"
        cell.isUserInteractionEnabled = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "QuotesDetailVC") as! QuotesDetailVC
        vc.quoteContent = arrHomeFeed[indexPath.row].content.unsafelyUnwrapped
        vc.authorName = arrHomeFeed[indexPath.row].author.unsafelyUnwrapped
        vc.tags = arrHomeFeed[indexPath.row].tags!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func callHomeQuoteWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForHomePageQuotes(Page:pageNumber,params: [:]) { [self]
            (result) in
            if let respCode = result.count{
                if respCode == 20{
                    if let arrDate = result.results{
                        if self.arrHomeFeed.count>0{
                            self.arrHomeFeed.removeAll()
                        }
                        for objData in arrDate {
                            self.arrHomeFeed.append(objData)
                        }
                        setupTableview()
                        self.tblView.reloadData()
                    }
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }
            GlobalObj.displayLoader(true, show: false)
        }
    }
        func PageCount() {
            let currentPageNumber = UserDefaults.standard.string(forKey: "pageNumber")
            if currentPageNumber == nil {
                pageNumber = "1"
            }
            else {
                pageNumber = currentPageNumber.unsafelyUnwrapped
            }
            if pageNumber < String(95) {
                let sum = Int(pageNumber)! + 1
                pageNumber = String(sum)
                UserDefaults.standard.set(pageNumber, forKey: "pageNumber")
            }
            else {
                pageNumber = "1"
                UserDefaults.standard.set(pageNumber, forKey: "pageNumber")
    
            }
            print("Current page Number is ====\(pageNumber)")
        }
    
}
