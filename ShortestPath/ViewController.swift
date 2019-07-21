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
    var points: [CGPoint] = [];
    
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
            self.points.append(location);
            Swift.print(location)
        }
    }
    
    func drawPathLines(resultPaths: [CGPoint] ) {
        self.view.viewWithTag(999)?.removeFromSuperview();
        let draw2D: Draw2D = Draw2D(frame: pathView.frame);
        draw2D.tag = 999;
        draw2D.isOpaque = false;
        draw2D.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0);
        draw2D.getResultPaths(resultPaths: resultPaths);
        print(draw2D.frame);
        self.view.addSubview(draw2D);
    }
    
    @IBAction func runBtn(_ sender: Any) {
        let travelingSalesman: TravelingSalesman = TravelingSalesman(points: self.points);
        let resultPaths = travelingSalesman.execute();
        self.drawPathLines(resultPaths: resultPaths);
    }
    
}

class Draw2D: UIView {
    
    private var resultPaths: [CGPoint] = [];
    
    func getResultPaths(resultPaths: [CGPoint] ) {
        self.resultPaths = resultPaths;
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 1.0, 1.0]
        let color = CGColor(colorSpace: colorSpace, components: components)
        context?.setStrokeColor(color!)
        context?.move(to: resultPaths[0]);
        for i in 1..<resultPaths.count {
            context?.addLine(to: resultPaths[i]);
        }
        context?.strokePath()
    }
}
