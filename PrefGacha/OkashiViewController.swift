//
//  OkashiViewController.swift
//  PrefGacha
//
//  Created by Nancy on 2020/08/22.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class OkashiViewController: UIViewController, UITableViewDataSource {
    
    //ResultViewController.swiftから値を受け取るString型変数searchTextを宣言する
    var searchText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //お菓子を検索
        searchOkashi(keyword: searchText!)
        //Table ViewのdataSourceを設定
        tableView.dataSource = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    
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
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=100&order=r") else {
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
                    self.alert(title: "注意", message: "条件に合うお菓子は見つかりませんでした")
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
                self.alert(title: "注意", message: "データの取得に失敗しました")
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
