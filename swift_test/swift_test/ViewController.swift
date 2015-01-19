//
//  ViewController.swift
//  swift_test
//
//  Created by miokato on 12/22/14.
//  Copyright (c) 2014 miok. All rights reserved.
//

import UIKit
import CoreLocation

// classにCLLocationのdelegeteを追加
class ViewController: UIViewController, CLLocationManagerDelegate{
    
    // beacon
    var myLocationManager:CLLocationManager!
    var myBeaconRegion:CLBeaconRegion!
    
	// アプリを立ち上げて、画面が開いたあと呼ばれる
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ロケーションマネージャの作成
        myLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // 承認されていない場合は、承認のダイアログを表示
        if(status == CLAuthorizationStatus.NotDetermined){
            myLocationManager.requestAlwaysAuthorization()
        }
        
        // beaconのuuidを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-3011-1001-B000-001C4D50762E")
        
        // beaconのidentifierを設定
        let identifierStr:NSString = "mioBeacon"

        // リージョンを作成
        myBeaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "00000000-3011-1001-B000-001C4D50762E"), identifier: identifierStr)
        
        // 入退場を通知
        myBeaconRegion.notifyOnEntry = true
        myBeaconRegion.notifyOnExit  = true
        
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
        	myLocationManager.requestWhenInUseAuthorization()
        }
        
        // モニタリングをスタート
        myLocationManager.startMonitoringForRegion(myBeaconRegion)
    }

    
// MARK: iBeacon setup
    
    // 認証ステータスが変化後呼び出される。　これを呼ばないとレンジングチェックのメソッドを読んでくれない
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorization")
        manager.startRangingBeaconsInRegion(myBeaconRegion)
    }
    
    // ビーコンとの距離を測る
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        if(beacons.count > 0){
            for var i=0; i<beacons.count; i++ {
                var beacon = beacons[i] as CLBeacon
                
                switch(beacon.proximity){
                case CLProximity.Unknown:
                    println("Unknown")
                    break
                case CLProximity.Far:
                    println("Far")
                    break
                case CLProximity.Near:
                    println("Near")
                    break
                case CLProximity.Immediate:
                    println("Immediate")
                    break
                    
                }
            }
        }
    }
    
    // 現在リージョン何にいるかの通知を受け取る
//    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
//        println("locationManager: didDetermineState \(state)")
//        
//        switch(state){
//        case .Inside:
//            println("CLRegionStateInside")
//            manager.startRangingBeaconsInRegion(myBeaconRegion)
//	        break
//        case .Outside:
//            println("CLRegionStateOutside")
//            break
//        case .Unknown:
//            println("CLRegionStateUnknown")
//            break
//        default:
//            break
//            
//        }
//    }
    
    // モニタリングをスタートしたあとに呼ばれる
//    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
//		println("didStartMonitoringForRegion")
//        manager.requestStateForRegion(myBeaconRegion)
//    }
    
    // リージョン内に入ったら呼ばれる
//    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
//		println("didEnterRegion")
//        manager.startRangingBeaconsInRegion(myBeaconRegion)
//    }
    
//    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
//        manager.stopMonitoringForRegion(myBeaconRegion)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: serup User Interface

}

