//
//  ViewController.swift
//  ShortestPath
//
//  Created by Takaki Otsu on 2019/07/20.
//  Copyright © 2019 Takaki Otsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pathView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func putPoint(location: CGPoint) {
        // UIImage インスタンスの生成
        let manImage:UIImage = UIImage(named:"yokokara_shitsurei")!
        // UIImageView 初期化
        let imageView = UIImageView(image:manImage)
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = manImage.size.width/10
        let imgHeight:CGFloat = manImage.size.height/10
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth, height:imgHeight)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:location.x, y:location.y)
        // UIImageViewのインスタンスをビューに追加
        self.pathView.addSubview(imageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: pathView)
            self.putPoint(location: location )
            Swift.print(location)
        }
    }
    
    @IBAction func runBtn(_ sender: Any) {
    }
    
}

