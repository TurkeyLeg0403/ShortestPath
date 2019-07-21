import UIKit

class TravelingSalesman {
    private var points: [CGPoint] = [];
    private let exeCount: Int = 10^6;
    private let tempreture: CGFloat = 10.0;
    private let cooler: CGFloat = 0.9;
    
    init(points: [CGPoint] ) {
        self.points = points;
    }
    
    public func execute() -> [CGPoint] {
        do {
            var minPaths: [CGPoint] = self.points;
            for _ in 0..<exeCount {
                var random1 = Int.random(in: 0..<self.points.count)
                var random2 = Int.random(in: 0..<self.points.count)
                if(random1 > random2){
                    swap(&random1, &random2)
                }
                print("random1 is \(random1)");
                print("random2 is \(random2)");
                let testPaths: [CGPoint] = self.reverseArray(array: self.points, head: random1, tail: random2) as! [CGPoint];
                let dE = try self.sumDist(points: testPaths) - self.sumDist(points: minPaths);
                print("dE is \(dE).");
                if(dE > 0) {
                    let exp_dE = exp(dE * -1 / tempreture);
                    let random_dE = CGFloat.random(in: 0..<1);
                    if(exp_dE > random_dE) {
                        print("not minimum, but chage paths.");
                        minPaths = testPaths;
                    }
                } else {
                    minPaths = testPaths;
                }
            }
            print("minPaths is \(minPaths)");
            return minPaths;
        } catch {
            print("Error: in TravelingSalesman, execute().")
            return [];
        }
    }
    
    private func reverseArray(array: Array<Any>, head: Int, tail: Int) -> Array<Any>{
        var results: Array<Any> = array;
        for i in 0..<(tail-head)/2 {
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
