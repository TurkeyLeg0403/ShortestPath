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
    @IBOutlet weak var runBtn: UIButton!
    
    var points: [CGPoint] = [];
    
    var ActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
    }

    func putPoint(location: CGPoint) {
        // UIImage インスタンスの生成
        let manImage:UIImage = UIImage(named:"yokokara_shitsurei")!;
        // UIImageView 初期化
        let imageView = UIImageView(image:manImage);
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = manImage.size.width/10;
        let imgHeight:CGFloat = manImage.size.height/10;
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth, height:imgHeight);
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:location.x, y:location.y);
        // UIImageViewのインスタンスをビューに追加
        self.pathView.addSubview(imageView);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: pathView);
            self.putPoint(location: location );
            self.points.append(location);
            self.runBtn.isEnabled = true;
            print(location);
        }
    }
    
    @IBAction func runBtn(_ sender: Any) {
        let travelingSalesman: TravelingSalesman = TravelingSalesman(points: self.points, superView: self.view, pathView: self.pathView);
        let resultPaths = travelingSalesman.execute();
        travelingSalesman.drawPathLines(resultPaths: resultPaths, superView: self.view, pathView: self.pathView);
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
