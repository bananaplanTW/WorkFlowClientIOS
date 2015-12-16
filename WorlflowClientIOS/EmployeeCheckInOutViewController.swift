//
//  EmployeeCheckInOutViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/14/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit
import CoreLocation

class EmployeeCheckInOutPromptViewController: UIViewController, CLLocationManagerDelegate {

    var employee: Employee!
    var logMgr: CLLocationManager!
    let logMgrInstance = LocationManager.sharedInstance()

    @IBOutlet var background: UIView!
    @IBOutlet weak var promptContainer: UIView!
    @IBOutlet weak var checkInTime: UILabel!
    @IBOutlet weak var checkOutTime: UILabel!
    @IBOutlet weak var checkInOutButton: UIButton!
    @IBOutlet weak var location: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNotificationObservers()
        initData()
        initViews()
        initGestures()
        initLocationManager()
    }
    override func viewWillDisappear(animated: Bool) {
        unloadLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func registerNotificationObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onEmployeeUpdated", name: WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE, object: nil)
    }
    func onEmployeeUpdated() {
        employee = WorkingDataStore.sharedInstance().getEmployee()
        renderActions()
    }


    func initData () {
        employee = WorkingDataStore.sharedInstance().getEmployee()
    }


    func initViews () {
        promptContainer.layer.borderWidth = 1
        promptContainer.layer.borderColor = UIColor.grayColor().CGColor
        promptContainer.layer.cornerRadius = 10

        location.text = logMgrInstance.getAddress()

        renderActions()
    }
    func renderActions () {
        switch employee.status {
        case .STOP, .OFF:
            checkInTime.text = NSLocalizedString("still_stop", comment: "尚未上班")
            checkOutTime.text = NSLocalizedString("still_stop", comment: "尚未上班")
            checkInOutButton.setTitle(NSLocalizedString("check_in", comment: "打卡上班"), forState: UIControlState.Normal)
            break
        case .WIP, .PENDING, .PAUSE:
            if let timecard = employee.timecard {
                checkInTime.text = NSDateFormatter.localizedStringFromDate(timecard.startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                checkOutTime.text = NSLocalizedString("still_working", comment: "尚未下班")
                checkInOutButton.setTitle(NSLocalizedString("check_out", comment: "打卡下班"), forState: UIControlState.Normal)
            } else {
                // 打卡錯誤
            }
            break;
        }
    }


    func initGestures () {
        let promptContainerGesture = UITapGestureRecognizer(target: self, action: "onTapPromptContainer:")
        promptContainer.addGestureRecognizer(promptContainerGesture)

        let backgroundGesture = UITapGestureRecognizer(target: self, action: "onTapBackground:")
        background.addGestureRecognizer(backgroundGesture)
    }
    func onTapPromptContainer (sender: UITapGestureRecognizer) {
        // no ops
    }
    func onTapBackground (sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    func initLocationManager () {
        logMgr = logMgrInstance.getLocationManager()
        logMgr.delegate = self
        logMgr.startUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        CLGeocoder().reverseGeocodeLocation(location) { placemarkers, errors in
            if errors != nil {
                print(errors)
                return
            }
            if placemarkers?.count > 0 {
                let pm = placemarkers![0] as CLPlacemark
                let address = self.logMgrInstance.parseAddress(pm)
                self.logMgrInstance.setAddress(address)

                self.location.text = address
            }
        }
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error when location when location changes", error)
    }
    func unloadLocationManager () {
        logMgr.stopUpdatingLocation()
        logMgr.delegate = nil
    }


    @IBAction func checkInOut(sender: UIButton) {
        if let loc: CLLocation = logMgr.location {
            PostAPI.checkInOut(loc.coordinate.latitude as Double, lng: loc.coordinate.longitude as Double, address: logMgrInstance.getAddress())
        } else {
            PostAPI.checkInOut(nil, lng: nil, address: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
