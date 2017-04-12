//
//  purchaseViewController.swift
//  In-App Purchase Demo
//
//  Created by Andrew Voelker on 4/9/17.
//  Copyright © 2017 Andrew Voelker. All rights reserved.
//

import UIKit
import StoreKit

var productID: String?

class purchaseViewController: UIViewController,SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    @IBOutlet weak var buyButton: UIButton!
    var product: SKProduct?
    var paymentQue: SKPaymentQueue?
    override func viewDidLoad() {
        super.viewDidLoad()
        buyButton.isEnabled = false
        SKPaymentQueue.default().add(self)
        getProductInfo()
        // Do any additional setup after loading the view.
    }
    
    func getProductInfo()
    {
        //self.paymentQue = [SKPaymentQueue defaultQueue];
        if SKPaymentQueue.canMakePayments() {
            
            let request = SKProductsRequest(productIdentifiers:
                NSSet(objects: productID) as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("cant make in app purchase")
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var products = response.products
        
        if (products.count != 0) {
            product = products[0]
            buyButton.isEnabled = true
            print(product!.localizedTitle)
            print(product!.localizedDescription)
            
        } else {
            print("Product not found")
        }
        
        let invalids = response.invalidProductIdentifiers
        
        for product in invalids
        {
            print("Product not found: \(product)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buyProduct(_ sender: Any) {
        let payment = SKPayment(product: product!)
        //SKPaymentQueue.default().remove(payment)
        SKPaymentQueue.default().add(payment)
    }
    override func viewDidDisappear(_ animated: Bool) {
        SKPaymentQueue.default().remove(self)
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case SKPaymentTransactionState.purchased:
                print("pyament purchase complete")
                self.unlockFeature()
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case SKPaymentTransactionState.failed:
                print("payment failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    func unlockFeature() {
        let appdelegate = UIApplication.shared.delegate
            as! AppDelegate
        if (productID == "keiretsuv.InAppPurchaseDemo"){
            appdelegate.homeViewController?.enableLevel1()
        }
        else if (productID == "keiretsuv.InAppPurchaseDemo2"){
            appdelegate.homeViewController?.enableFeature2()
        }
        buyButton.isEnabled = false
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
