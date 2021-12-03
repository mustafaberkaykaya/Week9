//
//  ViewController.swift
//  Week9
//
//  Created by Mustafa Berkay Kaya on 29.11.2021.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController { 

    @IBOutlet private weak var collectionView: UICollectionView!
    var results = [Result]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let design: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        design.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        let cellWidth = (width - 5) / 2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth / 2 + 50)
        collectionView.collectionViewLayout = design
        
        getData()
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CollectionViewCell {
            cell.setTitleLabel().text = results[indexPath.row].originalTitle
            cell.setImageView().kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(results[indexPath.row].backdropPath)"))
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            return cell
        }
     return UICollectionViewCell()
    }
    
    private func getData() {

        var parameters: Parameters = [:]
        parameters["api_key"] = "c84e29cd259b88f2aa9efb2d61a162f1"
        parameters["language"] = "en"
        parameters["page"] = 1
        
         AF.request("https://api.themoviedb.org/3/movie/popular?",
                    method: .get,
                    parameters: parameters).responseJSON {response in 
                        if let data = response.data {
                            do {
                                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                                DispatchQueue.main.async {
                                    self.results = jsonResult.results
                                    self.collectionView.reloadData()
                                }
                            } catch {
                                print(error)
                            }
                        }
         }
     }
}
