//
//  StoreObserver.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/2/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

/*
Abstract:
Implements the SKPaymentTransactionObserver protocol. Handles purchasing and restoring products using paymentQueue:updatedTransactions:.
*/

import StoreKit
import Foundation

class StoreObserver: NSObject {
    // MARK: - Types
    
    static let shared = StoreObserver()
    
    let product_id:Set<String> = ["Redstone_Tutorial.Minecraft_Redstone_Guide.full_version"]
    var availableProducts:[SKProduct] = []
    
    // MARK: - Properties
    
    /**
     Indicates whether the user is allowed to make payments.
     - returns: true if the user is allowed to make payments and false, otherwise. Tell StoreManager to query the App Store when the user is
     allowed to make payments and there are product identifiers to be queried.
     */
    var isAuthorizedForPayments: Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    /// Indicates whether there are restorable purchases.
    var hasRestorablePurchases = false
    
    // MARK: - Initializer
    
    private override init() {}
    
    // MARK: - Submit Payment Request
    
    /// Create and add a payment request to the payment queue.
    func buy(_ product: SKProduct) {
        let payment = SKMutablePayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    // MARK: - Restore All Restorable Purchases
    
    /// Restores all previously completed purchases.
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: - Handle Payment Transactions
    
    /// Handles successful purchase transactions.
    fileprivate func handlePurchased(_ transaction: SKPaymentTransaction) {
        global.saveIAP(didPurchase: true)
        print("Purchase successful.")
        
        // Finish the successful transaction.
        SKPaymentQueue.default().finishTransaction(transaction)
        global.groupBuy.leave()
    }
    
    /// Handles failed purchase transactions.
    fileprivate func handleFailed(_ transaction: SKPaymentTransaction) {
        print("Purchase failed.")
        
        if let error = transaction.error {
            //Only show an error if purchase fails due to anything other than the user cancelling it
            if let error = error as? SKError, error.code != .paymentCancelled {
                print("\(error)")
                if error.errorCode == 0 {
                    global.couldNotConnectToItunesPurchasing = true
                } else {
                    global.couldNotConnectToItunesPurchasing = false
                }
            }
        }

        // Finish the failed transaction.
        SKPaymentQueue.default().finishTransaction(transaction)
        global.groupBuy.leave()
    }
    
    /// Handles restored purchase transactions.
    fileprivate func handleRestored(_ transaction: SKPaymentTransaction) {
        hasRestorablePurchases = true
        global.saveIAP(didPurchase: true)
        print("Purchase restored.")
        
        // Finishes the restored transaction.
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

// MARK: - SKPaymentTransactionObserver

/// Extends StoreObserver to conform to SKPaymentTransactionObserver.
extension StoreObserver: SKPaymentTransactionObserver {
    /// Called when there are transactions in the payment queue.
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing: break
            // Do not block your UI. Allow the user to continue using your app.
            case .deferred: print("deferred")
            // The purchase was successful.
            case .purchased: handlePurchased(transaction)
            // The transaction failed.
            case .failed: handleFailed(transaction)
            // There are restored products.
            case .restored: handleRestored(transaction)
            @unknown default: fatalError("unknown default")
            }
        }
    }
    
    /// Logs all transactions that have been removed from the payment queue.
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print ("\(transaction.payment.productIdentifier) removed")
        }
    }
    
    /// Called when an error occurs while restoring purchases. Notify the user about the error.
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let error = error as? SKError, error.code != .paymentCancelled {
            print("\(error)")
            if error.errorCode == 0 {
                global.didConnectToItunes = false
            } else {
                global.didConnectToItunes = true
            }
        }
    }
    
    /// Called when all restorable transactions have been processed by the payment queue.
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Restorable transactions complete")
        
        if !hasRestorablePurchases {
            print("Nothing has been restored.")
        }
        global.groupRestore.leave()
    }
    
    func fetchProducts() -> Bool {
        if StoreObserver.shared.isAuthorizedForPayments {
            // Initialize the product request
            let productRequest = SKProductsRequest(productIdentifiers: self.product_id)
            productRequest.delegate = self
            
            // Send the request to the App Store.
            productRequest.start()
            return true
        } else {
            print("unauthorized to make payments")
            global.groupFetch.leave()
            return false
        }
    }
}

extension StoreObserver: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
            self.availableProducts = response.products
        }
        
        // invalidProductIdentifiers contains all product identifiers not recognized by the App Store.
        if !response.invalidProductIdentifiers.isEmpty {
            print("Invalid product identifier found")
        }
        global.groupFetch.leave()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        global.groupFetch.leave()
        print("left")
    }
}
