//
//  RegisterViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    lazy var user = {
        return Register.Request()
    }()
    
    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?

    var isNeedVerify: Bool = false
    var request = Register.Request()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        doSomething()
    }

    private func setupView() {
        
        title = "Register"
        prepareTableView()
    }
    
    func prepareTableView() {
        
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        
        tableView.bounces = false
        tableView.allowsSelectionDuringEditing = true
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        registerCells()
    }
    
    func registerCells() {
        
        tableView.register(InputWithErrorCell.self, forCellReuseIdentifier: InputWithErrorCell.identifier)
        tableView.register(UINib(nibName: InputWithErrorCell.identifier, bundle: nil),
                           forCellReuseIdentifier: InputWithErrorCell.identifier)
        
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
        tableView.register(UINib(nibName: ButtonCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ButtonCell.identifier)
        
        reloadData()
    }
    
    func reloadData() {
                
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.interactor?.setTableViewHeight(with: self.tableView.visibleCells)
        }
    }
    
    func doSomething() {
        let request = Register.Request()
        interactor?.doSomething(request: request)
    }
}

extension RegisterViewController : RegisterDisplayLogic {
    
    func setTableViewHeight(with height: CGFloat) {
        
        DispatchQueue.main.async {
            self.heightTableView.constant = height
        }
    }

    func displayLoading(_ isLoading: Bool) {
        
        LoadIndicator.displayLoading(isLoading)
    }
    
    func displayLogin() {

        LoadIndicator.displayLoading(false)
        self.navigationController?.popViewController(animated: true)
    }

    func displaySomethingOnSuccess(viewModel: Register.ViewModel) {
        
    }

    func displayErrorMessage(errorMessage: String) {
        
        displayLoading(false)
        
        let alertController = UIAlertController(title: title, message: errorMessage,
                                                preferredStyle: .alert)
        
        let okeyAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okeyAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension RegisterViewController {
    
    private func configure() {
        RegisterConfiguration.shared.configure(self)
    }
}

extension RegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return prepareInputFieldCell(with: .email)
        case 1:
            return prepareInputFieldCell(with: .password)
        case 2:
            return prepareInputFieldCell(with: .confirmPassword)
        default:
            return prepareButtonCell(with: .register)
        }
    }
    
    func prepareInputFieldCell(with type: Authen) -> UITableViewCell {
        
        let identifier: String = InputWithErrorCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? InputWithErrorCell
        cell?.delegate = self
        
        let user = Authen.ViewModel()
        
        cell?.prepareCell(with: type, user: user)

        if isNeedVerify {
            cell?.verifyCell(with: type, user: user)
        }
        
        return cell!
    }
    
    func prepareButtonCell(with type: Authen) -> UITableViewCell {
        
        let identifier: String = ButtonCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ButtonCell
        cell?.delegate = self
        
        cell?.prepareCell(with: type)
        cell?.setNormalStyle()

        return cell!
    }
}

extension RegisterViewController: InputWithErrorDelegate {
    
    func userDidUpdateText(text: String, with type: Authen) {
        
        switch type {
        case .email:
            request.email = text
        case .password:
            request.password = text
        case .confirmPassword:
            request.confirmPassword = text
        default: break
        }
    }
}

extension RegisterViewController: ButtonDelegate {
    
    func userDidTappedButton(with type: Authen) {
       
        guard type == .register else { return }
        interactor?.verifyForm(request: request)
    }
    
    func setLoading() {
    
        LoadIndicator.showDefaultLoading()
    }
    
    func verifyFormFailed() {
        
        isNeedVerify = true
        reloadData()
    }
    
    func registerSuccess(user: MD_User) {
        
        LoadIndicator.dismissLoading()
        self.navigationController?.popViewController(animated: true)
    }
}
