//
//  Article.swift
//  GoodNews
//
//  Created by Kevin Menéndez on 26/6/22.
//
struct ArticleList: Decodable {
    let articles: [Article]
}
struct Article: Decodable {
    let title: String
    let description: String
}
