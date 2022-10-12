//
//  MovieDetailViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Material

protocol MovieDetailDelegate {
    
    func hasUpdateMovieStatus(with movie: MD_Movie?)
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var widthVLeft: NSLayoutConstraint!
    
    @IBOutlet weak var vFooter: UIView!
    @IBOutlet weak var btnOpenWebsite: Button!
    @IBOutlet weak var btnFav: Button!
    
    var interactor: MovieDetailBusinessLogic?
    var router: (MovieDetailRoutingLogic & MovieDetailDataPassing)?
    
    var delegate: MovieDetailDelegate?
    var hasChange: Bool = false
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if hasChange {
            delegate?.hasUpdateMovieStatus(with: router?.dataStore?.movie)
        }
    }
    
    func doSomething() {
        let request = MovieDetail.Request()
        interactor?.doSomething(request: request)
    }
    
    private func setupView() {
        
        title = "Detail"
        widthVLeft.constant = Constants.Padding.Field
        
        btnOpenWebsite.setTitle("Open Website", for: .normal)
        btnOpenWebsite.setTitleColor(.green, for: .normal)
        btnOpenWebsite.layer.borderWidth = 1
        btnOpenWebsite.layer.borderColor = UIColor.green.cgColor
        btnOpenWebsite.layer.cornerRadius = 5
        
        setupBtnFav()
        prepareTableView()
    }
    
    func setupBtnFav() {
        
        let isFav: Bool = (router?.dataStore?.movie?.isFav ?? false)
        let color: UIColor = isFav ? .black : .orange
        
        btnFav.setTitle(isFav ? "Unfavorite" : "Add Favorite", for: .normal)
        btnFav.setTitleColor(color, for: .normal)
        btnFav.layer.borderWidth = 1
        btnFav.layer.borderColor = color.cgColor
        btnFav.layer.cornerRadius = 5
        btnFav.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnFav.tintColor = color
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
        
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.identifier)
        tableView.register(UINib(nibName: MovieDetailCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MovieDetailCell.identifier)
        
        reloadData()
    }
    
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func btnOpenWebsiteDidTapped(_ sender: Any) {
        
        interactor?.displayWebsite(with: router?.dataStore?.movie)
    }
    
    func presentSafari(with url: URL) {
       
        router?.presentSafari(with: url)
    }
    
    @IBAction func btnAddToFavDidTapped(_ sender: Any) {
        
        updateMovieStatus()
    }
    
    func updateMovieStatus() {
        
        LoadIndicator.showDefaultLoading()
        
        guard let user = AuthenLocal.shared.fetchUser(),
              let selectedMovie = router?.dataStore?.movie else { return }
        
        selectedMovie.isFav = !selectedMovie.isFav
        
        let request = MovieDetail.Request(movie: selectedMovie, userId: user.userId)
        interactor?.updateMovieStatus(request: request)
    }
}

extension MovieDetailViewController : MovieDetailDisplayLogic {
    
    func updateMovieStatusSuccess() {
        
        hasChange = true
        LoadIndicator.dismissLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.closeView()
        }
    }
    
    func closeView() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func displaySomethingOnSuccess(viewModel: MovieDetail.ViewModel) {
        
    }
    
    func displayErrorMessage(errorMessage: String) {
        
    }
}

extension MovieDetailViewController {
    private func configure() {
        MovieDetailConfiguration.shared.configure(self)
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return prepareMovieDetailCell()
    }
    
    func prepareMovieDetailCell() -> UITableViewCell {
        
        let identifier: String = MovieDetailCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieDetailCell
        cell?.prepareCell(with: router?.dataStore?.movie)
        return cell!
    }
}
