//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class OrderStatusViewController: UIViewController {
    
    private var viewModel: OrderStatusViewModel
    
    private var stackView: AloeStackView = {
       let stack = AloeStackView()
        stack.rowInset = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
        stack.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        stack.hidesSeparatorsByDefault = true
        return stack
    }()
    
    private lazy var orderIdView = OrderIdView(id: "3123-EWQ")
    
    init(viewModel: OrderStatusViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        Style.addBlueCorner(self)
        
        layoutScreen()
        setupStackView()
    }
    
    private func layoutScreen() {
        let placeholderImageView = UIImageView(image: Images.Placeholders.orderPlaced.image)
        placeholderImageView.contentMode = .scaleAspectFit
        view.addSubview(placeholderImageView)
        placeholderImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.size.equalTo(150)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(placeholderImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
		Style.addTitle(title: Localizable.OrderStatus.orderStatus, self)
        Style.addBackButton(self) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupStackView() {
		let orderConfirmedRow = OrderStateRow(title: Localizable.OrderStatus.orderConfirmed, time: "12:11", checked: true)
		let prepearingFoodRow = OrderStateRow(title: Localizable.OrderStatus.preparingFood, time: "12:11", checked: true)
		let foodOnTheWayRow = OrderStateRow(title: Localizable.OrderStatus.foodOnTheWay, time: "12:11", checked: false)
		let DeliveredToYouRow = OrderStateRow(title: Localizable.OrderStatus.deliveredToYou, time: "12:11", checked: false)
        stackView.addRow(orderIdView)
        stackView.addRow(orderConfirmedRow)
        stackView.addRow(prepearingFoodRow)
        stackView.addRow(foodOnTheWayRow)
        stackView.addRow(DeliveredToYouRow)
        
        stackView.showSeparator(forRow: orderIdView)
        stackView.showSeparator(forRow: orderConfirmedRow)
        stackView.showSeparator(forRow: prepearingFoodRow)
        stackView.showSeparator(forRow: foodOnTheWayRow)
        stackView.showSeparator(forRow: DeliveredToYouRow)
    }
    
}

// MARK: - OrderStatusView
extension OrderStatusViewController: OrderStatusView {
    
}

// MARK: - Private
private extension OrderStatusViewController {
    
}
