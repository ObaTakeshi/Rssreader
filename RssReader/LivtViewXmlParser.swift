//
//  XMLParser.swift
//  RssReader
//
//  Created by oba on 2017/06/14.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import PySwiftyRegex

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
//            do{
            let regex = re.compile("src=\"(.+?)\"")
            let a = regex.findall(currentString)
            if a.isEmpty == false{
                for l in 0...a.count-1{
                    if a[l].hasSuffix("jpg\"") || a[l].hasSuffix("png\"") {
                        let p = re.compile("src=\"")
                        let b = p.sub("",a[l])
                        let c = re.compile("\"")
                        let d = c.sub("",b)
                        i.image = d
                    }
                }
            }
 //               let p = re.compile("src=\"")
 //               let b = p.sub("",a[1])
 //               let c = re.compile("\"")
//                let d = c.sub("",b)
//                if d.hasSuffix("jpg"){
 //                  i.image = d
 //               }
//            }catch {
//            }
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
