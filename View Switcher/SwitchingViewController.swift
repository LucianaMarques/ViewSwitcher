//
//  SwitchingViewController.swift
//  View Switcher
//
//  Created by Luciana on 17/12/18.
//  Copyright © 2018 Luciana. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {
    
    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        blueViewController =
            (storyboard?.instantiateViewController(withIdentifier: "Blue")
                as! BlueViewController)
        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)  // helper method
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if blueViewController != nil && blueViewController!.view.superview == nil {
            blueViewController = nil
        }
        if yellowViewController != nil && yellowViewController!.view.superview == nil {
            yellowViewController = nil
        }
    }
    
    private func switchViewController(from fromVC: UIViewController?, to toVC:UIViewController?){
        
        if fromVC != nil{
            fromVC!.willMove(toParent: nil)
            //fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        
        if toVC != nil{
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
        }
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem){
        // Create the new view controller, if required
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController =
                    (storyboard?.instantiateViewController(withIdentifier: "Yellow")
                        as! YellowViewController)
            }
        } else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController =
                    (storyboard?.instantiateViewController(withIdentifier: "Blue")
                        as! BlueViewController)
            } }
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        // Switch view controllers
        if blueViewController != nil
            && blueViewController!.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight,
                                          for: view, cache: true)
            yellowViewController.view.frame = view.frame
            switchViewController(from: blueViewController,
                                 to: yellowViewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft,
                                          for: view, cache: true)
            blueViewController.view.frame = view.frame
            switchViewController(from: yellowViewController,
                                 to: blueViewController)
        }
        UIView.commitAnimations()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
