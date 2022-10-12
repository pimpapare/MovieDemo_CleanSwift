//
//  LoginViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnRegister: AppButton!
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    var request = Login.Request()

    var isNeedVerify: Bool = false
    
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
        
        btnRegister.setTitle("Register", for: .normal)
        btnRegister.setTitleColor(.black, for: .normal)
        btnRegister.backgroundColor = .clear
        
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = UIColor.black.cgColor
        
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
        
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        tableView.register(UINib(nibName: TitleCell.identifier, bundle: nil),
                           forCellReuseIdentifier: TitleCell.identifier)
        
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(UINib(nibName: ImageCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ImageCell.identifier)
        
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
        }
    }
    
    func doSomething() {
        let request = Login.Request()
        interactor?.doSomething(request: request)
    }
    
    @IBAction func btnRegisterDidTapped(_ sender: Any) {
        router?.displayRegister()
    }
}

extension LoginViewController: LoginDisplayLogic {
    
    func displayMovieList(with user: MD_User?) {
        
        LoadIndicator.dismissLoading()
        self.dismiss(animated: true)
    }
    
    func displayLoading(_ isLoading: Bool) {
        
        LoadIndicator.displayLoading(isLoading)
    }

    func displaySomethingOnSuccess(viewModel: Login.ViewModel) {
        
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

extension LoginViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return prepareTitleCell(with: "Anime")
        case 1:
            return prepareImageCell(with: "logo")
        case 2:
            return prepareInputFieldCell(with: .email)
        case 3:
            return prepareInputFieldCell(with: .password)
        default:
            
            return prepareButtonCell(with: .login)
        }
    }
    
    func prepareTitleCell(with text: String) -> UITableViewCell {
        
        let identifier: String = TitleCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TitleCell
        cell?.prepareCell(with: text)
        return cell!
    }
    
    func prepareImageCell(with imageName: String) -> UITableViewCell {
        
        let identifier: String = ImageCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ImageCell
        cell?.prepareCell(with: imageName)
        return cell!
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
        
        return cell!
    }
}

extension LoginViewController: InputWithErrorDelegate {
    
    func userDidUpdateText(text: String, with type: Authen) {
                
        switch type {
        case .email:
            request.email = text
        case .password:
            request.password = text
        default: break
        }
    }
}

extension LoginViewController: ButtonDelegate {
    
    func userDidTappedButton(with type: Authen) {
        
        guard type == .login else { return }
        interactor?.verifyForm(request: request)
    }
    
    func setLoading() {
        
        LoadIndicator.showDefaultLoading()
    }
    
    func verifyFormFailed() {
        
        isNeedVerify = true
        reloadData()
    }
    
    func loginSuccess(with user: MD_User) {
        closeView()
    }
    
    func closeView() {
        
        LoadIndicator.dismissLoading()
        self.dismiss(animated: true)
    }
}

extension LoginViewController {
    
    private func configure() {
        LoginConfiguration.shared.configure(self)
    }
}
