//
//  ResultViewController.swift
//  PrefGacha
//
//  Created by Nancy on 2020/08/22.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    //ViewController.swiftから値を受け取るString型変数receiveTextを宣言する
    var receiveText: String?
    
    @IBOutlet weak var resultImageView: UIImageView!
    var figureName: String!
    
    @IBOutlet weak var searchOkashiButton: UIButton!
    
    //navigationControllerを使用して画面遷移&値渡し
    @IBAction func searchOkashiButtonAction(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OkashiView") as! OkashiViewController
        nextVC.searchText = self.receiveText
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //receiveTextからfigureNameを決定する
    func decideResultFigure() {
        switch receiveText {
        //北海道
        case "北海道":
            figureName = "1_hokkaidou"
            
        //東北
        case "青森県":
            figureName = "2_touhoku1__aomori"
        case "岩手県":
            figureName = "2_touhoku2__iwate"
        case "宮城県":
            figureName = "2_touhoku3__miyagi"
        case "秋田県":
            figureName = "2_touhoku4__akita"
        case "山形県":
            figureName = "2_touhoku5__yamagata"
        case "福島県":
            figureName = "2_touhoku6__fukushima"
        
        //関東
        case "茨城県":
            figureName = "3_kantou1__ibaraki"
        case "栃木県":
            figureName = "3_kantou2__tochigi"
        case "群馬県":
            figureName = "3_kantou3__gunma"
        case "埼玉県":
            figureName = "3_kantou4__saitama"
        case "千葉県":
            figureName = "3_kantou5__chiba"
        case "東京都":
            figureName = "3_kantou6__tokyo"
        case "神奈川県":
            figureName = "3_kantou7__kanagawa"
       
        //中部
        case "山梨県":
            figureName = "4_chuubu1_yamanashi"
        case "長野県":
            figureName = "4_chuubu2_nagano"
        case "新潟県":
            figureName = "4_chuubu3_niigata"
        case "富山県":
            figureName = "4_chuubu4_toyama"
        case "石川県":
            figureName = "4_chuubu5_ishikawa"
        case "福井県":
            figureName = "4_chuubu6_fukui"
        case "静岡県":
            figureName = "4_chuubu7_shizuoka"
        case "愛知県":
            figureName = "4_chuubu8_aichi"
        case "岐阜県":
            figureName = "4_chuubu9_gifu"
            
        //近畿
        case "三重県":
            figureName = "5_kinki1_mie"
        case "滋賀県":
            figureName = "5_kinki2_shiga"
        case "京都府":
            figureName = "5_kinki3_kyouto"
        case "大阪府":
            figureName = "5_kinki4_osaka"
        case "兵庫県":
            figureName = "5_kinki5_hyougo"
        case "奈良県":
            figureName = "5_kinki6_nara"
        case "和歌山県":
            figureName = "5_kinki7_wakayama"
        
        //中国
        case "鳥取県":
            figureName = "6_chuugoku1_tottori"
        case "島根県":
            figureName = "6_chuugoku2_shimane"
        case "岡山県":
            figureName = "6_chuugoku3_okayama"
        case "広島県":
            figureName = "6_chuugoku4_hiroshima"
        case "山口県":
            figureName = "6_chuugoku5_yamaguchi"
          
        //四国
        case "香川県":
            figureName = "7_shikoku1_kagawa"
        case "愛媛県":
            figureName = "7_shikoku2_ehime"
        case "徳島県":
            figureName = "7_shikoku3_tokushima"
        case "高知県":
            figureName = "7_shikoku4_kouchi"
        
        //九州
        case "福岡県":
            figureName = "8_kyuusyuu1_fukuoka"
        case "佐賀県":
            figureName = "8_kyuusyuu2_saga"
        case "長崎県":
            figureName = "8_kyuusyuu3_nagasaki"
        case "熊本県":
            figureName = "8_kyuusyuu4_kumamoto"
        case "大分県":
            figureName = "8_kyuusyuu5_ooita"
        case "宮崎県":
            figureName = "8_kyuusyuu6_miyazaki"
        case "鹿児島県":
            figureName = "8_kyuusyuu7_kagoshima"
        case "沖縄県":
            figureName = "9_okinawa"
        
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        resultLabel.text = "\(receiveText ?? "")です！"
        decideResultFigure()
        resultImageView.image = UIImage(named: figureName)
        searchOkashiButton.setTitle("\(receiveText ?? "")のお菓子をみる", for: .normal)
        
        //ResultViewControllerのNavigationItemを"戻る"に変更する
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
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
