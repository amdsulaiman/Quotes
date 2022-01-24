//
//  QuotesDetailVC.swift
//  Quotes
//
//  
//

import UIKit
import TTGTagCollectionView

class QuotesDetailVC: UIViewController, TTGTextTagCollectionViewDelegate {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var quoteTxtView: UITextView!
    @IBOutlet weak var authorView: UIView!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var quoteTxHC: NSLayoutConstraint!
    @IBOutlet weak var tagTopLbl: UILabel!
    @IBOutlet weak var shareQuotes: UIView!
    
    var quoteContent = ""
    var authorName = ""
    var tags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        quoteTxHC.constant = self.quoteTxtView.contentSize.height
        setupTagView()
        setupAction()
    
       
    }
    
    func setupData() {
        quoteTxtView.isEditable = false
        quoteTxtView.text = "“ " + "\(quoteContent)"
        authorNameLbl.text = authorName
        print("The tags is \(tags)")
    }
    func setupTagView() {
        let tagView = TTGTextTagCollectionView()
        tagView.backgroundColor = .white
        self.view.addSubview(tagView)
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor).isActive = true
        tagView.topAnchor.constraint(equalTo: tagTopLbl.bottomAnchor, constant: 0).isActive = true
        tagView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 12).isActive = true
        tagView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: 12).isActive = true
        tagView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 16).isActive = true
        
        for text in tags {
            let content = TTGTextTagStringContent.init(text: text)
            content.textColor = UIColor.white
            content.textFont = (UIFont(name: fontBold, size: 18.0))!
            let normalStyle = TTGTextTagStyle.init()
            normalStyle.backgroundColor = UIColor.black
            normalStyle.extraSpace = CGSize.init(width: 8, height: 8)
    
            let tag = TTGTextTag.init()
            tag.content = content
            tag.style = normalStyle
            tagView.addTag(tag)
            
        }
        tagView.reload()
    }
    func setupAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AuthorDetail))
        authorView.addGestureRecognizer(gesture)
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(shareQuoteFunc))
        shareQuotes.addGestureRecognizer(gesture1)
    }
    @objc func AuthorDetail() {
        let vc = self.storyboard?.instantiateViewController(identifier: "AuthorDetailVC") as! AuthorDetailVC
        vc.authorName = authorNameLbl.text.unsafelyUnwrapped
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @objc func shareQuoteFunc() {
        let text = quoteTxtView.text
                
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view //
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authorDetailBtn(_ sender: UIButton) {
        
    }
    
}

