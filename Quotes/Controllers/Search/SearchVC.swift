//
//  SearchVC.swift
//  Quotes
//
//  
//

import UIKit

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    

    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var exploreAuthorView: UIView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    
    var tagsArr : [GetTags] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
        callforTags()
        
       
    }
    func setupCollectionview(){
        exploreCollectionView.register(ExploreCollectionViewCell.nib(), forCellWithReuseIdentifier: "ExploreCollectionViewCell")
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        exploreCollectionView.collectionViewLayout = layout
        
        
    }
    
    func setupAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ExploreView))
        exploreAuthorView.addGestureRecognizer(gesture)
        
    }
    @objc func ExploreView() {
        let vc = self.storyboard?.instantiateViewController(identifier: "ExploreAuthorVC") as! ExploreAuthorVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func dismissActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exploreCollectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionViewCell.identifier, for: indexPath) as! ExploreCollectionViewCell
        cell.titleLbl.text = tagsArr[indexPath.row].name.unsafelyUnwrapped.uppercased()
        cell.quotesCountLbl.text = "Quote Count :" + "\(String(tagsArr[indexPath.row].quoteCount.unsafelyUnwrapped))"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: self.exploreCollectionView.frame.size.width / 2, height: 110)
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let  vc = self.storyboard?.instantiateViewController(identifier: "AuthorQuotesVC") as! AuthorQuotesVC
        vc.Vcvalue = "1"
        vc.TagName = tagsArr[indexPath.row].name.unsafelyUnwrapped
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    func callforTags() {
        GlobalObj.displayLoader(true, show: false)
        APIClient.webserviceForGetTags { [self]
            (result) in
            print(result)

            self.tagsArr.append(contentsOf: result)
                        setupCollectionview()
                        self.exploreCollectionView.reloadData()
                
            GlobalObj.displayLoader(true, show: false)

        }
        }
    }

