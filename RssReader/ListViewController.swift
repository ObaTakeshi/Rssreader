//
//  ListViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import PySwiftyRegex

class ListViewController: UITableViewController {
    var categoryText:String = ""
    var xml: LivtViewXmlParser?
    var nhk = false
    
    @IBOutlet weak var convertURL: UIBarButtonItem!
    //bar buttonが押されたらURLを変えてリロード
    @IBAction func nhk(_ sender: Any) {
        nhk = !self.nhk

        xml?.parse(url: nhk ? Setting.RssUrl1 : Setting.RssUrl) {
            self.tableView.reloadData()
        }
        convertURL.title = nhk ? "NHK" : " はてなブックマーク"
    }
    
    //画面が表示された直後
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        xml = LivtViewXmlParser()
        if categoryText != ""{
            self.title = categoryText
            xml?.setCategolyText(text: categoryText)
            
            convertURL.isEnabled = false
            convertURL.tintColor = UIColor(white:0,alpha:0)
            
        }
        //URLの指定
        xml?.parse(url: nhk ? Setting.RssUrl1 : Setting.RssUrl) {
            self.tableView.reloadData()
        }
    }
    
    //セルのタップ時に送るデータ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let x = xml else {
            return
        }
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let controller = segue.destination as! DetailViewController
            controller.item = x.items[indexPath.row]
        }
    }
    
    //必須メソッド(戻り値はセルの数)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nilか否か
        return xml?.items.count ?? 0
    }
    
    //必須メソッド(戻り値はセルの内容)　indexPathは現在設定しているセルの行番号を保持
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeue~Cellはセルの再利用(引数に再利用するセル(ストーリボードのIdentifer))
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as? ListViewCell else {
            fatalError("Invalid cell")
        }
        
        guard let x = xml else {
            return cell
        }
        
        cell.item = x.items[indexPath.row]
        
        return cell
    }
}

class ListViewCell: UITableViewCell {
    //宣言の際クラス名に!をつけることで以後プロパティ名の使用に!を用いなくていい
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var imageLabel: UIImageView!
    
    var item: Item? {
        didSet {
            titleLabel.text = item?.title
            descriptionLabel.numberOfLines = 4
            descriptionLabel.text = item?.detail
            imageLabel.sd_setImage(with: NSURL(string: (item?.image)!) as URL?, placeholderImage: UIImage(named: "noImage.png"))
        }
    }
}


class LivtViewXmlParser: NSObject, XMLParserDelegate {
    var categoryText:String = ""
    var categoryOn = false
    //itemクラス型プロパティ
    var item: Item?
    //複数記事を格納する配列
    var items = [Item]()
    var currentString = ""
    var completionHandler: (() -> ())?
    
    func setCategolyText(text:String){
        categoryText = text
        categoryOn = true
    }
    
    func parse(url: String, completionHandler: @escaping () -> ()) {
        //URLがない時
        guard let url = URL(string: url) else {
            return
        }
        //インスタンスの作成
        guard let xml_parser = XMLParser(contentsOf: url) else {
            return
        }
        //itemsを空にする
        items = []
        //データ解析の開始
        self.completionHandler = completionHandler
        xml_parser.delegate = self
        xml_parser.parse()
    }
    
    //要素名の開始タグが始まるごとに呼び出される
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        //currentStringを空にする
        currentString = ""
        //要素名が"item"のデータのみ取得(elementNameにはデータの要素名が格納)
        if elementName == "item" {
            item = Item()
        }
    }
    
    //タグで囲まれた中にデータがあると呼び出される
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentString += string
    }
    
    //終了タグが見つかったとき呼び出される
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard let i = item else {
            return
        }
        
        //タグの種類でswitch
        switch elementName {
        case "title": i.title = currentString
        case "description": i.detail = currentString
        case "link": i.link = currentString
        case "content:encoded":
            let regex = re.compile("src=\"(.+?)\"")
            let a = regex.findall(currentString)
            let p = re.compile("src=\"")
            let b = p.sub("",a[1])
            let c = re.compile("\"")
            let d = c.sub("",b)
            if d.hasSuffix("jpg"){
                i.image = d
            }else{
            }
        case "dc:subject": i.category = currentString
        case "item":
            if categoryOn == false {
                items.append(i)
            
            } else if i.category == categoryText{
                items.append(i)
            }
        default: break
        }
    }
    
    //Rssの解析が終了すると呼び出される
    func parserDidEndDocument(_ parser: XMLParser) {
        completionHandler?()
    }
}
