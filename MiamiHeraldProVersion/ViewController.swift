//
//  ViewController.swift
//  MiamiHeraldProVersion
//
//  Created by Daniel Beltran on 9/24/18.
//  Copyright © 2018 Daniel Beltran. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var tableViewWithNews: UITableView!
    var collectionViewMenu : UICollectionView!
    var loadingIndicator : UIActivityIndicatorView!
    
    var viewmodel = ViewModelFirstView()
    var indicatorItemInCollectionView : Int = 0
    var count = 0
    var isloaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        api.getApi()
//        viewmodel.apiModel
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        
        self.navigationController?.navigationBar.isHidden = true
        collectionViewMenu = UICollectionView(frame:CGRect(x: 0, y: 60, width: self.view.frame.width, height: 50), collectionViewLayout: layout)
        collectionViewMenu.register(customCell.self, forCellWithReuseIdentifier: "customCellIdentifier")
        collectionViewMenu.delegate = self
        collectionViewMenu.dataSource = self
        collectionViewMenu.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(collectionViewMenu)
        
        
      
        
//        addActivityIndicatorView()
//        view.addSubview(headerMenu)
//        self.configurateNavBar()
    
//        viewmodel.reloadData { (news) in
//            count = news.count
//            self.collectionViewMenu.reloadData()
//        }
        
//        viewmodel.api
//      loadApi()
//         loadImages ()
        loadApi ()
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableViewWithNews = UITableView(frame: CGRect(x: 0  , y: 110 , width:self.view.frame.width, height: self.view.frame.height-110))
        tableViewWithNews.register(customCellTableView.self, forCellReuseIdentifier: "MyCell")
        tableViewWithNews.rowHeight = 200
        tableViewWithNews.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tableViewWithNews.dataSource = self
        tableViewWithNews.delegate = self
        view.addSubview(tableViewWithNews)
        self.isloaded = true
        
        
        
        loadingIndicator = UIActivityIndicatorView(frame:  CGRect(x: 200, y: 200, width: 50, height: 50))
        //        loadingIndicator.frame =
        loadingIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        loadingIndicator.style = .gray
        loadingIndicator.startAnimating()
        tableViewWithNews.addSubview(loadingIndicator)
        

//        self.tableViewWithNews.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
////        tableViewWithNews.layer.transform = CATransform3DMakeTranslation(500, 0, 1)
//        view.addSubview(tableViewWithNews)
//
//        UIView.animate(withDuration: 0.5, animations: {
//            self.tableViewWithNews.layer.transform = CATransform3DMakeScale(1.1,1.1,1)
////            self.tableViewWithNews.layer.transform = CATransform3DMakeTranslation(-40, 0, 1)
//
//
//        },completion: { finished in
//            UIView.animate(withDuration: 0.2, animations: {
//                 self.tableViewWithNews.layer.transform = CATransform3DMakeScale(1,1,1)
////                self.tableViewWithNews.layer.transform = CATransform3DMakeTranslation(0, 0, 1)
//                self.isloaded = true
//            })
//        })
        
        
        self.configurateViewMenu()
//        loadImages()

    }
    
    func addActivityIndicatorView () {
   
        
        /*
         _activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(200, 200, 100 , 100)];
         _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
         _activityView.center = self.view.center;
         [_activityView startAnimating];
         [self.view addSubview:_activityView];
         */
    }
    
    
    func loadApi () {
        self.viewmodel.loadedData { (succes) in
            if succes {
//                print("Im in did load ")
                self.reload()
                OperationQueue.main.addOperation {
                    self.tableViewWithNews.reloadData()
                }
            }
        }
    }
    
//    func loadImages () {
//        self.viewmodel.dowloadImages { (succes) in
//            if succes {
//                print("Im in did load Images ")
//                self.reloadImages()
//            }
//        }
//
//    }
    
//    var load = ViewModelFirstView().loadedData { (success) in
//
//        if success {
//            // self.collectionViewMenu.reloadData()
//            print("im in")
//        }
//    }
    
    func reload () {
//        print("reload in")
        OperationQueue.main.addOperation {
            self.count = self.viewmodel.currentNews.count
//            self.collectionViewMenu.reloadData()
            self.tableViewWithNews.reloadData()
            
        }
//            self.collectionViewMenu.reloadData()
    }
    
//    func reloadImages () {
//        print("reload Images In")
//
//        OperationQueue.main.addOperation {
////            self.count = self.viewmodel.currentNews.count
//            //            self.collectionViewMenu.reloadData()
//            self.tableViewWithNews.reloadData()
//        }
//        //            self.collectionViewMenu.reloadData()
//    }
    
//    func reloadData (completionHandler: (Bool) -> Void) {
//        viewmodel.loadedData { (Bool) in
//            if Bool {
//                self.collectionViewMenu.reloadData()
//            }
//        }
//    }
    
    
    
// func getApi (completionHandler: @escaping ([jsonInfo] ) -> Void) {
 
//    func configurateNavBar (){
//        self.navigationController?.navigationBar.backgroundColor =  #colorLiteral(red: 0.5572708845, green: 0.9404334426, blue: 1, alpha: 1)
//        self.navigationController?.navigationBar.isTranslucent = true
//        navigationItem.title = "Miami Herald"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont(name: "CartaMagna-Line", size: 35)!, NSAttributedStringKey.foregroundColor : UIColor.darkGray]
//    }

    func configurateViewMenu() {
        self.view.addSubview(headerMenu)
        self.view.addSubview(tittleHeader)
        self.view.addSubview(buttonIconWheater)
        self.view.addSubview(buttonIconNews)
        self.view.addSubview(buttonIconMore)
    }

    
    var  tittleHeader : UILabel = {
        let tittle = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 50))
        tittle.text = "ENDAVA NEWS"
        tittle.textColor =  UIColor .black
        tittle.font = UIFont(name: "CartaMagna-Line", size: 20)
        return tittle
    }()
    
    var buttonIconWheater : UIButton = {
        let button = UIButton(frame: CGRect(x: 280, y: 20, width: 25, height: 25))
        let image = UIImage(named: "sun.png")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: UIControl.State.normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    var buttonIconNews : UIButton = {
        let button = UIButton(frame: CGRect(x: 320, y: 20, width: 25 ,height: 25))
        let image = UIImage(named: "news.png")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: UIControl.State.normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    var buttonIconMore : UIButton = {
        let button = UIButton(frame: CGRect(x: 360, y: 20, width: 25, height: 25))
        let image = UIImage(named: "more2.png")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: UIControl.State.normal)
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return button
    }()
    
    
    var headerMenu : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 700, height: 60))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewmodel.countrys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCellIdentifier", for: indexPath) as! customCell
        
        if indexPath.item == indicatorItemInCollectionView {
            customCell.indicatorCellCollectionView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            customCell.nameLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }else {
        customCell.indicatorCellCollectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        customCell.nameLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        }
        customCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        customCell.layer.cornerRadius = 4
        customCell.clipsToBounds =  true
        customCell.layer.masksToBounds = true
        customCell.nameLabel.text = viewmodel.countrys[indexPath.item]
//        customCell.nameLabel.text = "\(indexPath.item)"
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 150, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        drawSelectedLine(cellNumber: indexPath.item)
        indicatorItemInCollectionView = indexPath.item
        viewmodel.changeCountryApi(city: viewmodel.countrys[indexPath.item])
        loadApi()
//        loadImages()
//        tableViewWithNews.reloadData()
        collectionView.reloadData()
    }
//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
   

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! customCellTableView
//        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MyCell")
        
        cell.selectionStyle = .none
        if (viewmodel.images.count > indexPath.row){
             cell.imageBackground.image = viewmodel.images[indexPath.row]
            self.loadingIndicator.stopAnimating()
        }
        cell.imageBackground.contentMode = .scaleAspectFit
        
        if self.isloaded {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//            cell.layer.transform = CATransform3DMakeTranslation(500, 0, 1)
            
            UIView.animate(withDuration: 0.2, animations: {
                cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
//                cell.layer.transform = CATransform3DMakeTranslation(-40, 0, 1)
                
                
            },completion: { finished in
                UIView.animate(withDuration: 0.1, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1,0.9,1)
//                    cell.layer.transform = CATransform3DMakeTranslation(0, 0, 1)
                    
                })
            })

        }
        
//        if(cell.frame.height == 200){
//            let gradient = CAGradientLayer()
//            gradient.frame = cell.bounds
//            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//            gradient.locations = [0.7, 1]
//    //        cell.layer.insertSublayer(gradient, at: 0)
//            //        cell.layer.mask = gradient
//            //        cell.backgroundImage.layer.mask = gradient
//            //        cell.imageBackground.layer.mask = gradient
//            cell.imageBackground.layer.insertSublayer(gradient, at: 0)
//        }
        
        if (viewmodel.lapsetdate.count > indexPath.row){
            
//            let calendar = Calendar.current
//            let hour = calendar.component(.hour, from: viewmodel.datesFormatted[indexPath.item])
//            let minute = calendar.component(.minute, from: viewmodel.datesFormatted[indexPath.item])
//            cell.dateLabel.text = "\(hour):\(minute)"
            cell.dateLabel.text = "published \(viewmodel.lapsetdate[indexPath.row]) ago"
        }
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        cell.bringSubviewToFront(cell.descriptionLabel)
        cell.descriptionLabel.text = viewmodel.newsTittles[indexPath.item]
        
//        cell.layer.masksToBounds = true

//        cell.textLabel?.text = viewmodel.newsTittles[indexPath.item]
//        cell.detailTextLabel?.text = viewmodel.newsImages[indexPath.item]
        return cell
    }
    
    
    class customCell:UICollectionViewCell{
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
       
        var nameLabel : UILabel = {
            let label = UILabel()
            label.text = "Hello World"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = UIColor.darkGray
            return label
        }()
        
        var indicatorCellCollectionView : UIView = {
            var frame  = UIView()
            frame.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0)
            return frame
        }()
        
        func setupViews() {
            nameLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
            nameLabel.textAlignment = .center
            indicatorCellCollectionView.frame = CGRect(x: 0, y: 48, width: 150, height: 2)
            self.addSubview(nameLabel)
            self.addSubview(indicatorCellCollectionView)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
    
    class customCellTableView: UITableViewCell{
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
         var tableFrame = ViewController()
        
        
        var descriptionLabel : UILabel = {
            let label = UILabel()
            label.text = "Hello World"
            label.numberOfLines = 3
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = UIColor.white
//            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1121575342)
            return label
        }()
        
        var dateLabel : UILabel = {
            let label = UILabel()
            label.text = "1/1/1"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = UIColor.white
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2332512842)

            return label
        }()
        
        
        //TODO:EScale Image
        
        var imageBackground : UIImageView = {
            let image = UIImageView()
            return image
        }()
        
       
        func addContraintsToView(view : UIImageView) {
            let view = view
            view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            view.leftAnchor.constraint(equalTo: tableFrame.tableViewWithNews.leftAnchor).isActive = true
            view.topAnchor.constraint(equalTo: tableFrame.tableViewWithNews.topAnchor, constant: 10)
            view.widthAnchor.constraint(equalToConstant: 416)
            view.heightAnchor.constraint(equalToConstant: 200)
        }

        func setupViews() {
            
            if let widthTable =  tableFrame.tableViewWithNews{
////                backgroundImage.frame = CGRect(x: 0, y: 0, width: widthTable.frame.width, height: 200)
////                imageBackground.draw(in: CGRect(x: 0, y: 0, width: widthTable.frame.width, height: 200))
                imageBackground.frame = CGRect(x: 25, y: 0, width: widthTable.frame.width-50, height: 200)
////                addContraintsToView(view: imageBackground)
////                backgroundImage.backgroundColor =
//                addContraintsToView(view: imageBackground)

            }
        else {
//                backgroundImage.frame = CGRect(x: 0, y: 0, width: 700, height: 200)
//                imageBackground.draw(in: CGRect(x: 0, y: 0, width: 700, height: 200))
                imageBackground.frame = CGRect(x: 0, y: 0, width: 416, height: 200)
//                addContraintsToView(view: imageBackground)
//                addContraintsToView(view: imageBackground)


            }
            let gradient = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: 0, width: 416, height: 200)
            gradient.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor]
            gradient.locations = [0.7, 1]
            //        cell.layer.insertSublayer(gradient, at: 0)
            //        cell.layer.mask = gradient
            //        cell.backgroundImage.layer.mask = gradient
            //        cell.imageBackground.layer.mask = gradient
            self.imageBackground.layer.insertSublayer(gradient, at: 0)
            
            
//            self.addSubview(backgroundImage)
            self.addSubview(imageBackground)

            descriptionLabel.frame = CGRect(x: 0, y: 140, width: 410, height: 50)
            descriptionLabel.textAlignment = .center
            self.addSubview(descriptionLabel)
            dateLabel.frame = CGRect(x: 0, y: 0, width: 416, height: 20)
//            dateLabel.textAlignment = .center
            self.addSubview(dateLabel)
      
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    


}

