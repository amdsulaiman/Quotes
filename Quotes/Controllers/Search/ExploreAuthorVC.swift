//
//  ExploreAuthorVC.swift
//  Quotes
//
//  
//

import UIKit

class ExploreAuthorVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var getAuthors : [AuthorBioResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callforGetAuthors()

        
    }
    func setupTableview() {
        tblView.register(ExploreAuthorTableViewCell.nib(), forCellReuseIdentifier: "ExploreAuthorTableViewCell")
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
    }
    

    @IBAction func dismissActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAuthors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier:ExploreAuthorTableViewCell.identifier , for: indexPath) as!  ExploreAuthorTableViewCell
        let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.authorNameLbl.text = getAuthors[indexPath.row].name.unsafelyUnwrapped
        cell.authorSubTitleLbl.text = getAuthors[indexPath.row].description.unsafelyUnwrapped
        cell.quotesCountLbl.text = "Quotes Count:" + " \(getAuthors[indexPath.row].quoteCount.unsafelyUnwrapped)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  vc = self.storyboard?.instantiateViewController(identifier: "AuthorQuotesVC") as! AuthorQuotesVC
        vc.authorName = getAuthors[indexPath.row].name.unsafelyUnwrapped
        vc.Vcvalue = "2"
        vc.quotesCount = getAuthors[indexPath.row].quoteCount.unsafelyUnwrapped
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    func callforGetAuthors() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForGetAuthor(params: [:]) { [self]
            (result) in
            
            if let respCode = result.page{
                if respCode == 1{
                    if let arrDate = result.results{
                        if self.getAuthors.count>0{
                            self.getAuthors.removeAll()
                        }
                        for objData in arrDate {
                            self.getAuthors.append(objData)
                        }
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
