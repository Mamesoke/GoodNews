//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Kevin Menéndez on 26/6/22.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articlesListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2022-06-26&sortBy=popularity&apiKey=31ac06fc40f84d578dcdd0b768295390")
        else { return }
        
        Webservice().getArticles(url: url) { articles in
            guard let articles = articles else { return }

            self.articlesListVM = ArticleListViewModel(articles: articles)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articlesListVM == nil ? 0 : self.articlesListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesListVM.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleVM = self.articlesListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        
        return cell
    }
}
