//  Created by Uladzimir Pryhazhanau
//  2019


import Foundation

//MARK: - View
protocol CheckoutView: class {

}

//MARK: - ViewModel
protocol CheckoutViewModel {

var view: CheckoutView? { get set }

}

//MARK: - Implementation
final class CheckoutViewModelImplementation: CheckoutViewModel {

  weak var view: CheckoutView?

  init() {
  }

}


