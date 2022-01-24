//
//  AuthorDetailVC.swift
//  Quotes
//
//  
//

import UIKit
import KRProgressHUD

class AuthorDetailVC: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var authorDetailView: UIView!
    @IBOutlet weak var authorNameView: UIView!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var authorTitleLbl: UILabel!
    @IBOutlet weak var authorWikiLinkView: UIView!
    @IBOutlet weak var authorWikiTitleLbl: UILabel!
    @IBOutlet weak var authorQuotesView: UIView!
    @IBOutlet weak var authorQuotesLbl: UILabel!
    @IBOutlet weak var quotesCountLbl: UILabel!
    @IBOutlet weak var authorBiotxtView: UITextView!
    @IBOutlet weak var authorBiotxtViewHC: NSLayoutConstraint!
    
    
    var authorName = ""
    var authorbioLink = ""
    var authorDetailArr : [AuthorBioResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseView.isHidden = true
        let string = authorName
        let formattedString = string.replacingOccurrences(of: " ", with: "")
        print(formattedString)
        callForAurhorDetail(with: formattedString)
        
    }
  
    func setupData() {
        
        authorNameLbl.text = authorDetailArr[0].name.unsafelyUnwrapped
        authorTitleLbl.text = authorDetailArr[0].description.unsafelyUnwrapped
        authorBiotxtView.text = authorDetailArr[0].bio.unsafelyUnwrapped
        quotesCountLbl.text = String(authorDetailArr[0].quoteCount.unsafelyUnwrapped)
        authorWikiTitleLbl.text = "\(authorDetailArr[0].name.unsafelyUnwrapped)" + " Wiki"
        authorbioLink = authorDetailArr[0].link.unsafelyUnwrapped
        authorBiotxtViewHC.constant = self.authorBiotxtView.contentSize.height
    }
    func setupAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AuthorWikiLink))
        authorWikiLinkView.addGestureRecognizer(gesture)
        //authorQuotesView
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(AuthorQuotes))
        authorQuotesView.addGestureRecognizer(gesture2)
        
    }
    @objc func AuthorWikiLink() {
        if let url = URL(string: authorbioLink) {
            UIApplication.shared.open(url)
        }
        
    }
    @objc func AuthorQuotes() {
        //homeNav
       
        let vc = self.storyboard?.instantiateViewController(identifier: "AuthorQuotesVC") as! AuthorQuotesVC
        vc.modalPresentationStyle = .fullScreen
        vc.authorName = authorName
        vc.vcValue = "1"
        vc.quotesCount = authorDetailArr[0].quoteCount.unsafelyUnwrapped
        self.present(vc, animated: true)
    }
    @IBAction func dismissActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authorWikiAction(_ sender: UIButton) {
        if let url = URL(string: authorbioLink) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func authorQuotesAction(_ sender: UIButton) {
    }
    
    
    func callForAurhorDetail(with authorName :String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForAuthorDetails(AuthorName: authorName,params: [:]) { [self]
            (result) in
            
            if let respCode = result.count{
                if respCode == 1{
                    if let arrDate = result.results{
                        if self.authorDetailArr.count>0{
                            self.authorDetailArr.removeAll()
                        }
                        for objData in arrDate {
                            self.authorDetailArr.append(objData)
                        }
                        self.baseView.isHidden = false
                        setupData()
                        setupAction()
                    }
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }
            GlobalObj.displayLoader(true, show: false)
        }
    }
   
}
