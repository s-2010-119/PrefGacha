//
//  ViewController.swift
//  PrefGacha
//
//  Created by Nancy on 2020/08/22.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ResultViewControllerのNavigationItemを"もう一度ガチャる"に変更する
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "もう一度ガチャる", style: .plain, target: nil, action: nil)
    }
    
    //各スイッチの結果を格納するBool型配列switchCnt[]を定義する
    var switchCnt = [Bool](repeating: false, count: 8)
    
    //switchCnt[i]がtrueならば，iを格納するInt型コレクションregionSetを定義する
    var regionSet = Set<Int>()
    
    //地域の番号Int型変数myRegionを定義する
    var myRegion = -1
    
    //それぞれの地域ごとの都道府県が格納されたString型配列prefList[]を宣言する
    var prefList:[String] = []
    
    //乱数を格納するInt型変数randを定義する
    var rand = -1
    
    //結果を格納するString型変数myPrefを定義する
    var myPref = ""
    
    var alertController: UIAlertController!
    
    @IBOutlet weak var hokkaidoSwitch: UISwitch!
    @IBOutlet weak var tohokuSwitch: UISwitch!
    @IBOutlet weak var kantoSwitch: UISwitch!
    @IBOutlet weak var chubuSwitch: UISwitch!
    @IBOutlet weak var kinkiSwitch: UISwitch!
    @IBOutlet weak var chugokuSwitch: UISwitch!
    @IBOutlet weak var shikokuSwitch: UISwitch!
    @IBOutlet weak var kyushuSwitch: UISwitch!
    @IBOutlet weak var gachaButton: UIButton!
    
    @IBAction func hokkaidoSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[0] = true
        } else {
            switchCnt[0] = false
        }
    }
    
    @IBAction func tohokuSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[1] = true
        } else {
            switchCnt[1] = false
        }
    }
    
    @IBAction func kantoSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[2] = true
        } else {
            switchCnt[2] = false
        }
    }
    
    @IBAction func chubuSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[3] = true
        } else {
            switchCnt[3] = false
        }
    }
    
    @IBAction func kinkiSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[4] = true
        } else {
            switchCnt[4] = false
        }
    }
    
    @IBAction func chugokuSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[5] = true
        } else {
            switchCnt[5] = false
        }
    }
    
    @IBAction func shikokuSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[6] = true
        } else {
            switchCnt[6] = false
        }
    }
    
    @IBAction func kyushuSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            switchCnt[7] = true
        } else {
            switchCnt[7] = false
        }
    }
    
    //エラーメッセージを表示する
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
     //navigationControllerを使用して画面遷移&値渡し
     func byNavigationPush(_ sender: UIButton) {
         let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultView") as! ResultViewController
         nextVC.receiveText = self.myPref
         self.navigationController?.pushViewController(nextVC, animated: true)
     }
    
    @IBAction func gachaButtonAction(_ sender: Any) {
        //switchCnt[i]を決定する
          hokkaidoSwitchAction(hokkaidoSwitch)
          tohokuSwitchAction(tohokuSwitch)
          kantoSwitchAction(kantoSwitch)
          chubuSwitchAction(chubuSwitch)
          kinkiSwitchAction(kinkiSwitch)
          chugokuSwitchAction(chugokuSwitch)
          shikokuSwitchAction(shikokuSwitch)
          kyushuSwitchAction(kyushuSwitch)
          
          //switchCnt[i]がtrueならば，regionSetにiを格納する
          for i in 0..<8 {
              if switchCnt[i] == true {
                  regionSet.insert(i)
              }
          }
        
          //myRegionが空のときにエラーメッセージを表示する
          guard regionSet != [] else {
              alert(title: "注意", message: "地域を選択してください")
              return
          }
          //その他のときはmyRegionにregionSet[0]を代入する
          myRegion = regionSet.first!
          
          //myRegionによって地方を決定し，prefListに格納する
          switch myRegion {
          case 0:
              prefList = ["北海道"]
          case 1:
              prefList = ["青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県"]
          case 2:
              prefList = ["茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県"]
          case 3:
              prefList = ["新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県"]
          case 4:
              prefList = ["三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県"]
          case 5:
              prefList = ["鳥取県", "島根県", "岡山県", "広島県", "山口県"]
          case 6:
              prefList = ["徳島県", "香川県", "愛媛県", "高知県"]
          case 7:
              prefList = ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]
          default:
              prefList = []
          }
          
          //prefList[]から，ランダムに1つ都道府県を選択する
          rand = Int.random(in: 0..<prefList.count)
          myPref = prefList[rand]
          
          //遷移する
          byNavigationPush(gachaButton)
          
          //switchCnt[i]を初期化する
          switchCnt = [Bool](repeating: false, count: 8)
          
          //regionSetを初期化する
          regionSet.removeAll()
          
          //myRegionを初期化する
          myRegion = -1
          
          //prefList[]を初期化する
          prefList = []
          
          //randを初期化する
          rand = -1
          
          //myPrefを初期化する
          myPref = ""
    }
}

