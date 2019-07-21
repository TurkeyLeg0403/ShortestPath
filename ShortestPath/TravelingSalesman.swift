import UIKit

class TravelingSalesman {
    private var points: [CGPoint] = [];
    private let exeCount: Int = 100000;
    private let tempreture: CGFloat = 10.0;
    private let cooler: CGFloat = 0.9;
    
    private let superView: UIView;
    private let pathView: UIView;
    
    init(points: [CGPoint], superView: UIView, pathView:UIView) {
        self.points = points;
        self.superView = superView;
        self.pathView = pathView;
    }
    
    public func execute() -> [CGPoint] {
        do {
            if self.points.isEmpty {
                throw NSError(domain: "in execute, points is empty.", code: -1, userInfo: nil)
            }
            var minPaths: [CGPoint] = self.points;
            for i in 0..<exeCount {
                var random1 = Int.random(in: 0..<self.points.count);
                var random2 = Int.random(in: 0..<self.points.count);
                if(random1 > random2){
                    swap(&random1, &random2)
                }
                let testPaths: [CGPoint] = self.reverseArray(array: minPaths, head: random1, tail: random2) as! [CGPoint];
                let dE = try self.sumDist(points: testPaths) - self.sumDist(points: minPaths);
                if(dE > 0) {
                    let exp_dE = exp(dE * -1 / tempreture);
                    let random_dE = CGFloat.random(in: 0..<1);
                    if(exp_dE > random_dE) {
//                        print("not minimum, but change paths.");
                        minPaths = testPaths;
                    }
                } else {
//                    print("change paths. \(i)");
                    minPaths = testPaths;
                }
            }
//            print("minPaths is \(minPaths)");
            print("sumDist is \(try self.sumDist(points: minPaths))");
            return minPaths;
        } catch {
            print("Error: in TravelingSalesman, execute().")
            return [];
        }
    }
    
    public func drawPathLines(resultPaths: [CGPoint], superView: UIView, pathView: UIView) {
        superView.viewWithTag(999)?.removeFromSuperview();
        let draw2D: Draw2D = Draw2D(frame: pathView.frame);
        draw2D.tag = 999;
        draw2D.isOpaque = false;
        draw2D.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0);
        draw2D.getResultPaths(resultPaths: resultPaths);
        superView.addSubview(draw2D);
    }
    
    private func reverseArray(array: Array<Any>, head: Int, tail: Int) -> Array<Any>{
        var results: Array<Any> = array;
        let swapCount: Float = (Float(tail) - Float(head))/2.0;
        for i in 0..<Int(swapCount.rounded()) {
            results.swapAt(head+i, tail-i);
        }
        return results;
    }
    
    private func dist(p1: CGPoint, p2: CGPoint) -> CGFloat {
        let dx = CGFloat(p1.x - p2.x);
        let dy = CGFloat(p1.y - p2.y);
        return sqrt(dx*dx + dy*dy);
    }
    
    private func sumDist(points: [CGPoint]) throws -> CGFloat {
        if points.isEmpty {
            throw NSError(domain: "in sumDist, points is empty.", code: -1, userInfo: nil)
        }
        var sum: CGFloat = 0.0;
        var lastPoint: CGPoint = points[0];
        for point in points {
            sum += self.dist(p1: lastPoint, p2: point);
            lastPoint = point;
        }
        return sum;
    }
}
