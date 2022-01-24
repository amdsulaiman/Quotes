//
//  OnboardVC.swift
//  Quotes
//
//  
//

import UIKit

class OnboardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var nextBtnRef: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1
            {
                nextBtnRef.setTitle("Get Started", for: .normal)
            }
            else
            {nextBtnRef.setTitle("Next", for: .normal)
                
            }
        }
    }
    var slides : [OnboardingSlide] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtnRef.layer.cornerRadius = 8
        onboardCollectionView.delegate = self
        onboardCollectionView.dataSource = self
        
        slides = [OnboardingSlide(title: "Daily New Quotes", description: "lots of new Quotes only for you ,Updated Daily", image: #imageLiteral(resourceName: "slide1")),
                  OnboardingSlide(title: "Categories", description: " lots of categories for you to explore", image: #imageLiteral(resourceName: "slide2")),
                  OnboardingSlide(title:  "Quote Customization", description: "You can Customize Quote , according to your favour", image: #imageLiteral(resourceName: "slide3")), OnboardingSlide(title: "Downloadable", description: "You can customize Quotes and it is Downloadable", image: #imageLiteral(resourceName: "slide4"))
        ]
        
        if UserDefaults.standard.bool(forKey: "ISLOGGEDIN") == true {
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "TabbarVC") as! UITabBarController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
       
    }
    @IBAction func onClickNext(_ sender: UIButton) {
        if currentPage == slides.count - 1{
            let vc = storyboard?.instantiateViewController(identifier: "TabbarVC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
           //ok 
            UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
            self.present(vc, animated: true)

        }
        else {
            currentPage += 1
            let indexpath = IndexPath(item: currentPage, section:0)
            onboardCollectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardCollectionView.dequeueReusableCell(withReuseIdentifier: "onboardCollectionViewCell", for: indexPath) as! onboardCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onboardCollectionView.frame.size.width, height:  onboardCollectionView.frame.size.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
    

   
}
