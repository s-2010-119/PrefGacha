//
//  DetailOkashiViewController.swift
//  PrefGacha
//
//  Created by yuma fujita on 2020/08/24.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class DetailOkashiViewController: UIViewController {
    
    //OkashiViewController.swiftから値を受け取るString型変数receiveNameを宣言する
    var receiveName: String?
    var receiveImage: URL?
    
    @IBOutlet weak var detailOkashiLabel: UILabel!
    @IBOutlet weak var detailOkashiView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailOkashiLabel.text = receiveName
        if let imageData = try? Data(contentsOf: receiveImage!) {
            detailOkashiView?.image = UIImage(data: imageData)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
