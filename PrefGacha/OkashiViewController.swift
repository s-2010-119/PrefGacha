//
//  OkashiViewController.swift
//  PrefGacha
//
//  Created by Nancy on 2020/08/22.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class OkashiViewController: UIViewController, UITableViewDataSource {
    
    //ResultViewController.swiftから値を受け取るString型変数receiveTextを宣言する
    var receiveText: String?
    
    var searchText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        decideSearchText()
        
        //お菓子を検索
        searchOkashi(keyword: searchText!)
        //Table ViewのdataSourceを設定
        tableView.dataSource = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    //receiveTextからsearchTextを決定する
    func decideSearchText() {
        switch receiveText {
        //北海道
        case "北海道":
            searchText = "北海道"
            
        //東北
        case "青森県":
            searchText = "青森"
        case "岩手県":
            searchText = "岩手"
        case "宮城県":
            searchText = "仙台"
        case "秋田県":
            searchText = "秋田"
        case "山形県":
            searchText = "山形"
        case "福島県":
            searchText = "福島"
        
        //関東
        case "茨城県":
            searchText = "茨城"
        case "栃木県":
            searchText = "栃木"
        case "群馬県":
            searchText = "群馬"
        case "埼玉県":
            searchText = "埼玉"
        case "千葉県":
            searchText = "千葉"
        case "東京都":
            searchText = "東京"
        case "神奈川県":
            searchText = "横浜"
       
        //中部
        case "山梨県":
            searchText = "山梨"
        case "長野県":
            searchText = "信州"
        case "新潟県":
            searchText = "新潟"
        case "富山県":
            searchText = "富山"
        case "石川県":
            searchText = "石川"
        case "福井県":
            searchText = "福井"
        case "静岡県":
            searchText = "静岡"
        case "愛知県":
            searchText = "名古屋"
        case "岐阜県":
            searchText = "岐阜"
            
        //近畿
        case "三重県":
            searchText = "三重"
        case "滋賀県":
            searchText = "滋賀"
        case "京都府":
            searchText = "京都"
        case "大阪府":
            searchText = "大阪"
        case "兵庫県":
            searchText = "神戸"
        case "奈良県":
            searchText = "奈良"
        case "和歌山県":
            searchText = "和歌山"
        
        //中国
        case "鳥取県":
            searchText = "鳥取"
        case "島根県":
            searchText = "島根"
        case "岡山県":
            searchText = "岡山"
        case "広島県":
            searchText = "広島"
        case "山口県":
            searchText = "山口"
          
        //四国
        case "香川県":
            searchText = "讃岐"
        case "愛媛県":
            searchText = "愛媛"
        case "徳島県":
            searchText = "徳島"
        case "高知県":
            searchText = "高知"
        
        //九州
        case "福岡県":
            searchText = "福岡"
        case "佐賀県":
            searchText = "佐賀"
        case "長崎県":
            searchText = "長崎"
        case "熊本県":
            searchText = "熊本"
        case "大分県":
            searchText = "大分"
        case "宮崎県":
            searchText = "宮崎"
        case "鹿児島県":
            searchText = "鹿児島"
        case "沖縄県":
            searchText = "沖縄"
        
        default:
            return
        }
    }
    
    //お菓子のリスト(タプル配列)
    var okashiList : [(name: String, maker: String, link: URL, image: URL)] = []
    
    //JSONのitem内のデータ構造
    struct ItemJson: Codable {
        //お菓子の名前
        let name: String?
        //メーカー
        let maker: String?
        //掲載URL
        let url: URL?
        //画像URL
        let image: URL?
    }
    
    //JSONのデータ構造
    struct ResultJson: Codable {
        //複数要素
        let item:[ItemJson]?
    }
    
    //searchOkashiメソッド
    //第1引数: keyword 検索したいワード
    func searchOkashi(keyword : String) {
        //お菓子の検索キーワードをエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        //リクエストURLの組み立て
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=1000&order=r") else {
            return
        }
        print(req_url)
        
        //リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        //データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            //セッションを終了
            session.finishTasksAndInvalidate()
            //do try catchエラーハンドリング
            do {
                //JSONDecoderのインスタンス取得
                let decoder = JSONDecoder()
                //受け取ったJSONデータをパス(解析)して格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                print (json)
                
                //お菓子の情報が取得できているか確認
                guard json.item != nil else {
                    self.alert(title: "エラー", message: "条件に合うお菓子は見つかりませんでした")
                    return
                }
                if let items = json.item {
                    //お菓子のリストを初期化
                    self.okashiList.removeAll()
                    //取得しているお菓子の数だけ処理
                    for item in items {
                        //お菓子の名称，メーカー名，掲載URL，画像URLをアンラップ
                        if let name = item.name, let maker = item.maker, let url = item.url, let image = item.image {
                            //1つのお菓子をタプルでまとめて管理
                            let okashi = (name, maker, url, image)
                            //お菓子の配列へ追加
                            self.okashiList.append(okashi)
                        }
                    }
                    //Table Viewを更新する
                    self.tableView.reloadData()
                    
                    if let okashidbg = self.okashiList.first {
                        print("-----------------")
                        print("okashiList[0] = \(okashidbg)")
                    }
                    
                }
            } catch {
                //エラー処理
                self.alert(title: "エラー", message: "データの取得に失敗しました")
            }
        })
        //ダウンロード開始
        task.resume()
    }
    
    //Cellに総数を返すdatasourceメソッド．必ず記述する必要があります
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //お菓子リストの総数
        return okashiList.count
    }
    
    //Cellに値を設定するdatasourceメソッド，必ず記述する必要があります
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //今回表示を行う，Cellオブジェクト(1行)を取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "okashiCell", for: indexPath)
        //お菓子のタイトル設定
        cell.textLabel?.text = okashiList[indexPath.row].name
        //お菓子画像を取得
        if let imageData = try? Data(contentsOf: okashiList[indexPath.row].image) {
            //正常に取得できた場合は，UIImageで画像オブジェクトを生成して，Cellにお菓子画像を設定
            cell.imageView?.image = UIImage(data: imageData)
        }
        //設定済みのCellオブジェクトを画面に反映
        return cell
    }
    
    var alertController: UIAlertController!
    
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
        
        //
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
