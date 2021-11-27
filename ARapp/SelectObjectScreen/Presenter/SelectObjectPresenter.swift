//
//  SelectObjectPresenter.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import UIKit

class SelectObjectPresenter {
    
    var cellId = "cellId"
    
    let objects: [ObjectModel] = SelectObjectList.objects
    
    //MARK: - Dependencies
    
    weak var viewController: SelectObjectView?
}

//MARK: - Realisation of MainViewOutput
extension SelectObjectPresenter: ISelectObjectView {

    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ObjectCustomCell
        let object = objects[indexPath.row]
        cell.imageView.image = object.objectImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 0.95)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, navigationController: UINavigationController?) {
        let object = objects[indexPath.row]
        let arView = ARScreenCoordinator.configure(objectName: object.objectName)
        navigationController?.pushViewController(arView, animated: true)
    }
}
