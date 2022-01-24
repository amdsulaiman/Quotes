//
//  CreaterVC.swift
//  Quotes
//
// 
//

import UIKit
import Lottie

class CreaterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var showAuthorLbl: UILabel!
    @IBOutlet weak var authorSwitch: UISwitch!
    @IBOutlet weak var quotesLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var commonCollectionView: UICollectionView!
    @IBOutlet weak var sliderRef: UISlider!
    @IBOutlet weak var dismissCollectionView: UIView!
    @IBOutlet weak var currentCollectionViewTitleLbl: UILabel!
    @IBOutlet weak var backgroundCollectionView: UICollectionView!
    @IBOutlet weak var fontColorCollectionView: UICollectionView!
    @IBOutlet weak var fontCollectionView: UICollectionView!
    @IBOutlet weak var animationView: AnimationView!
    var customFontSize : CGFloat = 0
    var quoteContent = ""
    var authorName = ""
    var commonArr1 = ["BG Color","Font Color","Font Size","Font"]
    var bgColorArr  = [#colorLiteral(red: 0.8705882353, green: 0.9647058824, blue: 0.7921568627, alpha: 1),#colorLiteral(red: 0.8549019608, green: 0.9960784314, blue: 0.462745098, alpha: 1),#colorLiteral(red: 0.9607843137, green: 0.7333333333, blue: 0, alpha: 1),#colorLiteral(red: 0.8941176471, green: 0.8509803922, blue: 0.003921568627, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.2039215686, blue: 0.4117647059, alpha: 1),#colorLiteral(red: 0.2470588235, green: 0.2039215686, blue: 0.2470588235, alpha: 1),#colorLiteral(red: 0.9568627451, green: 0.8352941176, blue: 0.5529411765, alpha: 1),#colorLiteral(red: 0.9764705882, green: 0.9058823529, blue: 0.9058823529, alpha: 1),#colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.003921568627, alpha: 1)]
    var fontColorArr = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)]
    var fontNameArr = [UIFont(name: "PlayfairDisplay-Regular", size:18),UIFont(name: "PlayfairDisplay-Medium", size: 18),UIFont(name: "PlayfairDisplay-Italic", size: 18),UIFont(name: "PlayfairDisplay-SemiBold", size: 18),UIFont(name: "PlayfairDisplay-Bold", size: 18)]
    var collectionViewValue = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.isHidden = true
        setupCollectionView()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
        setupView()
    }
    func setupCollectionView() {
        //Common Collectionview
        commonCollectionView.register(CommonCollectionViewCell.nib(), forCellWithReuseIdentifier: "CommonCollectionViewCell")
        commonCollectionView.delegate = self
        commonCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        commonCollectionView.collectionViewLayout = layout
        commonCollectionView.backgroundColor = .white
        //background color
        backgroundCollectionView.register(CommonCollectionViewCell.nib(), forCellWithReuseIdentifier: "CommonCollectionViewCell")
        backgroundCollectionView.delegate = self
        backgroundCollectionView.dataSource = self
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        layout1.minimumInteritemSpacing = 0
        layout1.minimumLineSpacing = 0
        backgroundCollectionView.collectionViewLayout = layout1
        backgroundCollectionView.backgroundColor = .white
        //Font color
        fontColorCollectionView.register(CommonCollectionViewCell.nib(), forCellWithReuseIdentifier: "CommonCollectionViewCell")
        fontColorCollectionView.delegate = self
        fontColorCollectionView.dataSource = self
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        layout2.minimumInteritemSpacing = 0
        layout2.minimumLineSpacing = 0
        fontColorCollectionView.collectionViewLayout = layout2
        fontColorCollectionView.backgroundColor = .white
        //font
        fontCollectionView.register(CommonCollectionViewCell.nib(), forCellWithReuseIdentifier: "CommonCollectionViewCell")
        fontCollectionView.delegate = self
        fontCollectionView.dataSource = self
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal
        layout3.minimumInteritemSpacing = 0
        layout3.minimumLineSpacing = 0
        fontCollectionView.collectionViewLayout = layout3
        fontCollectionView.backgroundColor = .white
    }
    func setupView() {
        quotesLbl.text = quoteContent
        authorNameLbl.text = "~ " + "\(authorName)"
        if collectionViewValue == "1" {
            currentCollectionViewTitleLbl.text = "Customize Quote"
            commonCollectionView.isHidden = false
            dismissCollectionView.isHidden = true
            backgroundCollectionView.isHidden = true
            fontColorCollectionView.isHidden = true
            fontCollectionView.isHidden = true
            sliderRef.isHidden = true
            commonCollectionView.reloadData()
            print("value is \(collectionViewValue)")
            
        }
        else if collectionViewValue == "2" {
            currentCollectionViewTitleLbl.text = "Select background color"
            commonCollectionView.isHidden = true
            dismissCollectionView.isHidden = false
            backgroundCollectionView.isHidden = false
            fontColorCollectionView.isHidden = true
            fontCollectionView.isHidden = true
            sliderRef.isHidden = true
        }
        else if collectionViewValue == "3" {
            currentCollectionViewTitleLbl.text = "Select font color"
            commonCollectionView.isHidden = true
            dismissCollectionView.isHidden = false
            backgroundCollectionView.isHidden = true
            fontColorCollectionView.isHidden = false
            fontCollectionView.isHidden = true
            sliderRef.isHidden = true
            
        }
        else if collectionViewValue == "4" {
            currentCollectionViewTitleLbl.text = "Select font size"
            fontNameArr = [UIFont(name: "PlayfairDisplay-Regular", size:customFontSize),UIFont(name: "PlayfairDisplay-Medium", size: customFontSize),UIFont(name: "PlayfairDisplay-Italic", size: customFontSize),UIFont(name: "PlayfairDisplay-SemiBold", size: customFontSize),UIFont(name: "PlayfairDisplay-Bold", size: customFontSize)]
            sliderRef.isHidden = false
            dismissCollectionView.isHidden = false
            commonCollectionView.isHidden = true
            backgroundCollectionView.isHidden = true
            fontColorCollectionView.isHidden = true
            fontCollectionView.isHidden = true
        }
        else if collectionViewValue == "5" {
            currentCollectionViewTitleLbl.text = "Select font"
            commonCollectionView.isHidden = true
            dismissCollectionView.isHidden = false
            sliderRef.isHidden = true
            backgroundCollectionView.isHidden = true
            fontColorCollectionView.isHidden = true
            fontCollectionView.isHidden = false
        }
        else {
            sliderRef.isHidden = true
        }
    }
    func setupAnimationView() {
        UIApplication.shared.windows.first?.isUserInteractionEnabled = false
        baseView.isHidden = true
        animationView.isHidden = false
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
    }
    @IBAction func downloadImageBtnAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "If editing is finished,Press Download", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let download = UIAlertAction(title: "Download", style: .default) { _ in
            self.setupAnimationView()
            let img = self.quoteView.getImage()
            UIImageWriteToSavedPhotosAlbum(img,nil,nil,nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.dismiss(animated: true, completion: nil)
                UIApplication.shared.windows.first?.isUserInteractionEnabled = true
            }
        }
        alert.addAction(cancel)
        alert.addAction(download)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func dismissViewBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "Your saved changes will be lost!", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let download = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(download)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onClickShowAuthor(_ sender: UISwitch) {
        if authorSwitch.isOn {
            authorNameLbl.isHidden = false
        }
        else {
            authorNameLbl.isHidden = true
        }
    }
    
    @IBAction func didTapSlider(_ sender: UISlider) {
        customFontSize = CGFloat(Int(sender.value))
        quotesLbl.font = quotesLbl.font.withSize(CGFloat(Int(sender.value)))
        authorNameLbl.font = authorNameLbl.font.withSize(CGFloat(Int(sender.value)))
    }
    
    @IBAction func dismissCollectionViewBtnAction(_ sender: UIButton) {
        collectionViewValue = "1"
        setupView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == commonCollectionView) {
            return commonArr1.count
        }
        else if (collectionView == backgroundCollectionView) {
            return bgColorArr.count
        }
        else if (collectionView == fontColorCollectionView) {
            return fontColorArr.count
        }
        else if (collectionView == fontCollectionView) {
            return fontNameArr.count
        }
        return 10
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = commonCollectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
        if (collectionView == commonCollectionView) {
            cell.titleFontLbl.text  = commonArr1[indexPath.row]
            if indexPath.row == 0 {
                cell.bgView.backgroundColor = .black
                cell.fontTextLbl.isHidden = true
                cell.bgView.layer.cornerRadius = cell.bgView.layer.bounds.width / 2
                cell.bgView.clipsToBounds = true
            }
           else if indexPath.row == 1 {
            cell.bgView.backgroundColor = .white
            cell.bgView.layer.borderWidth = 1
            cell.bgView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.fontTextLbl.isHidden = true
            cell.bgView.layer.cornerRadius = cell.bgView.layer.bounds.width / 2
            cell.bgView.clipsToBounds = true

            }
           else if indexPath.row == 2 {
            cell.bgView.backgroundColor = .systemGray6
            cell.bgView.layer.cornerRadius = cell.bgView.layer.bounds.width / 2
            cell.bgView.clipsToBounds = true
            cell.fontTextLbl.isHidden = false
            cell.fontTextLbl.text = "22"

                
            }
           else if indexPath.row == 3 {
            cell.bgView.backgroundColor = .systemGray6
            cell.bgView.layer.cornerRadius = cell.bgView.layer.bounds.width / 2
            cell.bgView.clipsToBounds = true
            cell.fontTextLbl.isHidden = false
            cell.fontTextLbl.text = "Ag"
            }
            
        }
        else if (collectionView == backgroundCollectionView) {
            cell.bgView.backgroundColor = bgColorArr[indexPath.row]
            cell.bgView.layer.cornerRadius = cell.bgView.layer.bounds.width / 2
            cell.bgView.layer.borderWidth = 1
            cell.bgView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.bgView.clipsToBounds = true
            cell.fontTextLbl.isHidden = true
            cell.titleFontLbl.isHidden = true
    
        }
        else if (collectionView == fontColorCollectionView) {
            cell.bgView.backgroundColor = fontColorArr[indexPath.row]
            cell.bgView.layer.cornerRadius = cell.bgView.layer.bounds.width / 2
            cell.bgView.layer.borderWidth = 1
            cell.bgView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.bgView.clipsToBounds = true
            cell.fontTextLbl.isHidden = true
            cell.titleFontLbl.isHidden = true
        }
        else if (collectionView == fontCollectionView) {
            cell.bgView.backgroundColor = .systemGray6
            cell.bgView.layer.cornerRadius = cell.bgView.layer.bounds.width / 2
            cell.bgView.clipsToBounds = true
            cell.titleFontLbl.isHidden = true
            cell.fontTextLbl.isHidden = false
            if indexPath.row == 0 {
                cell.fontTextLbl.font = fontNameArr[indexPath.row]
                cell.fontTextLbl.text = "Ag"
            }
           else if indexPath.row == 1 {
            cell.fontTextLbl.font = fontNameArr[indexPath.row]
            cell.fontTextLbl.text = "Ag"
            }
           else if indexPath.row == 2 {
            cell.fontTextLbl.font = fontNameArr[indexPath.row]
            cell.fontTextLbl.text = "Ag"
            }
           else if indexPath.row == 3 {
            cell.fontTextLbl.font = fontNameArr[indexPath.row]
            cell.fontTextLbl.text = "Ag"
            }
           else if indexPath.row == 4 {
            cell.fontTextLbl.font = fontNameArr[indexPath.row]
            cell.fontTextLbl.text = "Ag"
            }
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.commonCollectionView.frame.size.width / 4, height: 126)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == commonCollectionView){
            if indexPath.row == 0 {
                print("Bg Color is Tapped")
                collectionViewValue = "2"
                setupCollectionView()
                setupView()
            }
            else if indexPath.row == 1 {
                print("Font Color is Tapped")
                collectionViewValue = "3"
                setupCollectionView()
                setupView()
                
            }
            else if indexPath.row == 2 {
                print("Font Size is Tapped")
                collectionViewValue = "4"
                setupView()
            }
            else if indexPath.row == 3 {
                print(" Font name is Tapped")
                collectionViewValue = "5"
                setupView()
                setupCollectionView()
                print(".....\(collectionViewValue)")
                
            }
        }
        else if (collectionView == backgroundCollectionView) {
            quoteView.backgroundColor = bgColorArr[indexPath.row]
        }
        else if (collectionView == fontColorCollectionView) {
            quotesLbl.textColor = fontColorArr[indexPath.row]
            authorNameLbl.textColor = fontColorArr[indexPath.row]
        }
        else if (collectionView == fontCollectionView) {
            quotesLbl.font = fontNameArr[indexPath.row]
            authorNameLbl.font = fontNameArr[indexPath.row]
        }
}
}
extension UIView {
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }

    func getImage(scale: CGFloat? = nil) -> UIImage {
        let newScale = scale ?? UIScreen.main.scale
        self.scale(by: newScale)

        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale

        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)

        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
        return image
    }

}
