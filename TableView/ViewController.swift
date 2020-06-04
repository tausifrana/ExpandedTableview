//
//  ViewController.swift
//  TableView
//
//  Created by My MAC on 4/6/20.
//  Copyright © 2020 ME. All rights reserved.
//

import UIKit

class CustomTableCell : UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var array1 = [String]()

    func loadCollectionView(with arr1 : [String]) {
           self.array1 = arr1
           
           CollectionView.dataSource = self
           CollectionView.delegate = self
           CollectionView.reloadData()
           CollectionView.layoutIfNeeded()
       }
       
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return array1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath as IndexPath) as! customCollectionCell
        
        cell.lblSubProduct.text = array1[indexPath.row]
        
        // let ObjModel = Globals.sharedInstance.arrSubCategoryData[indexPath.row]
        // cell.lblCategoryDetailName.text = "\(ObjModel.name!) (\(ObjModel.count!)) "
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("You selected table zero cell for List #\(indexPath.item)!")
        // let objData = Globals.sharedInstance.arrSubCategoryData[indexPath.row]
        print(array1[indexPath.row])
        /*
         let story = UIStoryboard(name: "Main", bundle:nil)
         let vc = story.instantiateViewController(withIdentifier: "ShowAdsSubCategoryVC") as! ShowAdsSubCategoryVC
         UIApplication.shared.windows.first?.rootViewController = vc
         UIApplication.shared.windows.first?.makeKeyAndVisible()

         */
    }
}

class customCollectionCell : UICollectionViewCell
{
    @IBOutlet weak var lblSubProduct: UILabel!
}


class ViewController: UIViewController {

   // var arrProductTittle = ["Apple","Nokia","Samsung"]
   // var arrSubProductArray = ["iPhone 5","iPhone 6","iPhone 7","iPhone 8","iPhone X"]
    
    var sortedArray : [String:[String]] = [:]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let array = [ ["SCREENTIME": "15:00","FORMAT": "2D"],["SCREENTIME": "17:00","FORMAT": "2D"],["SCREENTIME": "21:00","FORMAT": "2D"],["SCREENTIME": "12:00","FORMAT": "3D"],["SCREENTIME": "14:00","FORMAT": "3D"], ["SCREENTIME": "14:00","FORMAT": "4D"]]

        
        for dictionary in array {
        if let key = dictionary["FORMAT"]{
            if let screenTime = dictionary["SCREENTIME"] {
                if sortedArray[key] != nil {
                    sortedArray[key]?.append(screenTime)
                }else{
                    sortedArray[key] = [screenTime]
                }
            }
        }
      }
    }
}
extension ViewController : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CustomTableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableCell
        
       // cell.lblName.text = arrProductTittle[indexPath.row]
       // cell.loadCollectionView(with: arrSubProductArray)
        
        let key = Array(sortedArray.keys)[indexPath.row]

        cell.lblName.text = key
        cell.loadCollectionView(with: sortedArray[key]!)
        
        return cell
    }
}

