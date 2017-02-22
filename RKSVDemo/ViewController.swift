//
//  ViewController.swift
//  RKSVDemo
//
//  Created by Nikhil Manapure on 21/02/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit
import Alamofire
import BEMSimpleLineGraph
import SocketIO

class ViewController: UIViewController{
    
    @IBOutlet weak var segmentedControl: SegmentedControl!
    @IBOutlet weak var graph: BEMSimpleLineGraphView!
    
    var historicalData : [StockPoint] = []
    var socket = SocketIOClient(socketURL: URL(string: baseUrlStr + watch)!, config: [.log(true), .forcePolling(true)])
    var canUpdateGraph = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setAverageLineDefaults()
        addSocketHandlers()
        graph.displayDotsWhileAnimating = false
        setStatusBarBackgroundColor(color: UIColor.ourColor)
        graph.labelFont = UIFont(name: (graph.labelFont?.fontName)!, size: 20.0)
        updateHistoricalData(forInterval: 1,onCompletion: {
            self.graph.reloadGraph()
//            self.socket.connect()
        })
    }
    
    func addSocketHandlers() {
        socket.on("connect") {data, ack in
            print("socket connected")
            self.socket.emit("sub", with: ["{ state: true }"])
        }
        
        socket.on("data") {data, ack in
//            ack.with("CLIENT_ACKNOWLEDGEMENT", "1")
//            // Convert data to string based on what format data is sent as.
//            if let point = StockPoint.modal(fromString: str as! String){
//                self.historicalData.append(point)
//                self.graph.reloadGraph()
//            // Can also load based on timer rather than reloading on every data recieved.
//            }
        }
        
        socket.on("error") {data, ack in
            
        }
    }
    
    func updateHistoricalData(forInterval interval: Int, onCompletion completion: @escaping () -> ()){
        let urlStr = baseUrlStr + historicalService + "?interval=\(interval)"
        Alamofire.request(urlStr).responseJSON { response in
            if let JSON = response.result.value {
                let jsonArray = (JSON as! NSArray) as Array
                self.historicalData.removeAll()
                for str in jsonArray{
                    if let point = StockPoint.modal(fromString: str as! String){
                        self.historicalData.append(point)
                    }
                }
                completion()
            }
        }
    }
    
    func setAverageLineDefaults(){
        self.graph.averageLine.enableAverageLine = true;
        self.graph.averageLine.alpha = 0.5;
        self.graph.averageLine.color = UIColor.lightGray;
        self.graph.averageLine.width = 1.5;
    }
    
    func setStatusBarBackgroundColor(color : UIColor){
        let view = UIView(frame:CGRect(x: 0, y: 0, width: (self.view.bounds.size.width), height: 22))
        view.backgroundColor = UIColor.ourColor
        self.view.addSubview(view)
        self.view.bringSubview(toFront: view)
    }
}


//MARK: - Graph DataSource

extension ViewController : BEMSimpleLineGraphDataSource {
    
    public func numberOfPoints(inLineGraph graph: BEMSimpleLineGraphView) -> Int {
        return self.historicalData.count
    }
    
    public func lineGraph(_ graph: BEMSimpleLineGraphView, valueForPointAt index: Int) -> CGFloat {
        return CGFloat(self.historicalData[index].open!)
    }
    
    public func lineGraph(_ graph: BEMSimpleLineGraphView, labelOnXAxisFor index: Int) -> String {
        if index == 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            return " \(dateFormatter.string(from: historicalData[0].timestamp!))"
        }
        return ""
    }
}

//MARK: - Graph Delegate

extension ViewController : BEMSimpleLineGraphDelegate {
    public func lineGraphDidBeginLoading(_ graph: BEMSimpleLineGraphView) {
        canUpdateGraph = false
    }
    
    public func lineGraphDidFinishDrawing(_ graph: BEMSimpleLineGraphView) {
        canUpdateGraph = true
    }
}

