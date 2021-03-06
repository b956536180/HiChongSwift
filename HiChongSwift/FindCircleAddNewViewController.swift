//
//  FindCircleAddNewViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindCircleAddNewViewController: UITableViewController {
    
    enum FindCircleAddNewType: Int {
        case textOnly = 0
        case mixed = 1
    }
    
    var currentType: FindCircleAddNewType = .textOnly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        switch currentType {
        case .textOnly:
            self.title = "文字消息"
        case .mixed:
            self.title = "图文消息"
        }
        
        self.tableView.hideExtraSeprator()
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.addRightButton("发送", action: "rightButtonPressed:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        println("right button pressed!")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        switch currentType {
        case .textOnly:
            return 2
        case .mixed:
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch currentType {
        case .textOnly:
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            default:
                return 0
            }
        case .mixed:
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            case 2:
                return 1
            default:
                return 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(FindCircleAddTextCell.identifier(), forIndexPath: indexPath) as UITableViewCell
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("pickerCell") as UITableViewCell
            switch indexPath.row {
            case 0:
                cell.imageView?.image = UIImage(named: "findCircle")
                cell.textLabel?.text = "选择宠物"
                cell.backgroundColor = UIColor.LCYTableLightGray()
            case 1:
                cell.imageView?.image = UIImage(named: "findCircle")
                cell.textLabel?.text = "选择位置"
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            default:
                break
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(FindAddImageCell.identifier()) as UITableViewCell
            let cell = cell as FindAddImageCell
            cell.collectionDataSource = self
        default:
            break
        }
        
        // Configure the cell...
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150.0
        case 1:
            return 44.0
        case 2:
            return 86.0
        default:
            return 44.0
        }
    }
    
}

extension FindCircleAddNewViewController: FindAddImageSource {
    func addImageWillTakePicture() {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "我要拍照", "从照片库选取", "取消")
        actionSheet.destructiveButtonIndex = 2
        actionSheet.showInView(self.view)
    }
    func addImageCount() -> Int {
        return 0
    }
    func addImageAt(index: Int) -> UIImage? {
        return nil
    }
}

extension FindCircleAddNewViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            // 我要拍照
            let imagePicker = UIImagePickerController()
            imagePicker.videoQuality = UIImagePickerControllerQualityType.Type640x480
            imagePicker.sourceType = .Camera
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)
            break
        case 1:
            // 从照片库中选择
            break
        default:
            break
        }
    }
}

extension FindCircleAddNewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.showHUDWithTips("处理中")
        
        let smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFitToSize: CGSize(width: 600, height: 600))
        UIImageWriteToSavedPhotosAlbum(smallImage, nil, nil, nil)
        // 处理上传之后，隐藏HUD
        self.hideHUD()
    }
}
