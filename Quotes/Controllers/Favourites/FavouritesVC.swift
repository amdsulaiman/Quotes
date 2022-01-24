//
//  FavouritesVC.swift
//  Quotes
//
//  
//

import UIKit

class FavouritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noFavoView: UIView!
    
    var myArray = [Favourites]()
    override func viewDidLoad() {
        super.viewDidLoad()
        noFavoView.isHidden = true
        setupFavouriteData()
        
    }
    func setupFavouriteData() {
        let storedObjects = UserDefaults.standard.object(forKey: "MyFavourites")
        if storedObjects == nil {
            noFavoView.isHidden = false
            print("No Favourites")
        }
        else {
            do {
                myArray = try JSONDecoder().decode([Favourites].self, from: storedObjects as! Data)
                noFavoView.isHidden = true
                tblView.isHidden = false
                setupTableview()
            }
            catch let err {
                print(err)
            }
        }
    }


override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupFavouriteData()
}
func setupTableview() {
    tblView.register(QuotesTableViewCell.nib(), forCellReuseIdentifier: "QuotesTableViewCell")
    tblView.backgroundColor = .white
    tblView.delegate = self
    tblView.dataSource = self
    tblView.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuotesTableViewCell.identifier, for: indexPath) as! QuotesTableViewCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius = 8
        cell.baseView.layer.cornerRadius = 8
        cell.quotesContentLbl.text = "  “" + "\(myArray[indexPath.row].Content)"
        cell.authorNameLbl.text = "~ " + "\(myArray[indexPath.row].authorName)"
        cell.isUserInteractionEnabled = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
