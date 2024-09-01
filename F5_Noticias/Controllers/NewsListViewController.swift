//
//  ViewController.swift
//  F5_Noticias
//
//  Created by Milena Alegre on 19/08/24.
//

import UIKit

class NewsListViewController: UIViewController {
    
    
    @IBOutlet weak var newsListTableView: UITableView!
    
    private var newsList: [NewsModel]?{
        didSet{
            self.newsListTableView.reloadData()
        }
    }
    
    var localDataProvider: NewsListLocalDataProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.initLocalDataProvider()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNewsViewController", let destination = segue.destination as? NewsViewController {
            destination.news = sender as? NewsModel
        }
    }
    
    private func setupTableView(){
        self.newsListTableView.delegate = self
        self.newsListTableView.dataSource = self
        self.newsListTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    private func initLocalDataProvider (){
        self.localDataProvider = NewsListLocalDataProvider()
        self.localDataProvider?.delegate = self
        self.localDataProvider?.getNewsList()
    }
    
   
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let newsList = newsList else{
            fatalError("Erro ao carregar noticia, mals")
        }
        performSegue(withIdentifier: "ShowNewsViewController", sender: newsList[indexPath.row])
    
    }
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList?.count ?? 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Deu ruim rapaziada ao desempilhar") }
        
        guard let newsList = newsList else{
            fatalError("sem noticia")
        }
        
        cell.news = newsList[indexPath.row]
        cell.selectionStyle = .none //sem estilo de selecao (click/tap)
        return cell
        
        //return UITableViewCell()
    }
}

extension NewsListViewController: NewsListLocalDataProviderProtocol{
    func sucess(model: Any) {
        self.newsList = model as? [NewsModel]
       // self.newsListTableView.reloadData()
    }
    
    func errorData(_provide provide: GenericDataProvider?, error: Error) {
        print("erro:: \(error.localizedDescription)")
    }

              }
