//
//  AuthorQuotesVC.swift
//  Quotes
//
//
//

import UIKit

class AuthorQuotesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var quotesCountLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var arrAuthorQuotes:[AuthorQuotesResults] = []
    var authorName = ""
    var vcValue = ""
    var quotesCount = 0
    var Vcvalue = ""
    var TagName = ""
    var arrTags:[TagsDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseView.isHidden = true
        if Vcvalue ==  "1" {
            callforGetQuotesbyTags(with: TagName)
        }
        else if vcValue == "2" {
            let string = authorName
            let formattedString = string.replacingOccurrences(of: " ", with: "")
            print(formattedString)
            CallforAuthorQuoesWebServices(with: formattedString)
        }
        else {
            let string = authorName
            let formattedString = string.replacingOccurrences(of: " ", with: "")
            print(formattedString)
            CallforAuthorQuoesWebServices(with: formattedString)
        }
        
        
        
    }
    
    @IBAction func dismissActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func setupTableview() {
        tblView.register(QuotesTableViewCell.nib(), forCellReuseIdentifier: "QuotesTableViewCell")
        if Vcvalue == "1" {
            quotesCountLbl.isHidden = true
            titleLbl.text = TagName.uppercased()
        }
        else if vcValue == "2"  {
            titleLbl.text = authorName
            quotesCountLbl.isHidden = true
        }
        else {
            titleLbl.text = authorName
            quotesCountLbl.isHidden = true
        }
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
       
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Vcvalue == "1" {
            return arrTags.count
        }
        else  if vcValue == "2"{
            return arrAuthorQuotes.count
        }
        else {
            return arrAuthorQuotes.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuotesTableViewCell.identifier, for: indexPath) as! QuotesTableViewCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius = 8
        cell.baseView.layer.cornerRadius = 8
        cell.favouritesBtnRef.isHidden = true
        
        if Vcvalue == "1" {
            cell.quotesContentLbl.text = "  “" + "\(arrTags[indexPath.row].content.unsafelyUnwrapped)"
            cell.authorNameLbl.text = "~ " + "\(arrTags[indexPath.row].author.unsafelyUnwrapped)"
        }
        else if vcValue == "2" {
            cell.quotesContentLbl.text = "  “" + "\(arrAuthorQuotes[indexPath.row].content.unsafelyUnwrapped)"
            cell.authorNameLbl.isHidden = true
            cell.isUserInteractionEnabled = true
        }
        else {
            cell.quotesContentLbl.text = "  “" + "\(arrAuthorQuotes[indexPath.row].content.unsafelyUnwrapped)"
            cell.authorNameLbl.isHidden = true
            cell.isUserInteractionEnabled = true
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func CallforAuthorQuoesWebServices(with Authorname : String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForAuthorQuotes(AuthorName: Authorname,params: [:]) { [self]
            (result) in
            
            if let respCode = result.count{
                
                if respCode == quotesCount{
                    
                    if let arrDate = result.results{
                        if self.arrAuthorQuotes.count>0{
                            self.arrAuthorQuotes.removeAll()
                        }
                        for objData in arrDate {
                            self.arrAuthorQuotes.append(objData)
                        }
                        print(self.arrAuthorQuotes)
                        self.baseView.isHidden = false
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
    func callforGetQuotesbyTags(with Tagname : String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForGetQuotesbtTags(Tag: Tagname,params: [:]) { [self]
            (result) in
            
            if let respCode = result.page{
                
                if respCode == 1 {
                    
                    if let arrDate = result.results{
                        if self.arrTags.count>0{
                            self.arrTags.removeAll()
                        }
                        for objData in arrDate {
                            self.arrTags.append(objData)
                        }
                        print(arrTags.count)
                        self.baseView.isHidden = false
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
    
}
