#Introduction of Recommender Algorithms for E-Commerce
***


##Introduction

Recommender systems in e-commerce can be seen as a sales personal.  Like a good sales personal in a store helps increasing sales and building loyalty customer base, recommender system handles sales three ways: browser into buyers, cross-sell and loyalty.

* Browsers into buyers: Visitors to a Web site often look over the site without ever purchasing anything. Recommender systems can help customers find products they wish to purchase.  

* Cross-sell: Recommender systems improve cross-sell by suggesting additional products for the customer to purchase. If the recommendations are good, the average order size should increase. For instance, a site might recommend additional products in the checkout process, based on those products already in the shopping cart.  

* Loyalty: In a world where a site’s competitors are only a click or two away, gaining customer loyalty is an essential business strategy. [4,5] Recommender systems improve loyalty by creating a value-added relationship between the site and the customer. Sites invest in learning about their users, use recommender systems to operationalize that learning, and present custom interfaces that match customer needs. Customers repay these sites by returning to the ones that best match their needs. [3]

Hence, it is not surprising that Recommender Systems are essential part of e-commerce solutions in this era.  At present day, many recommender algorithms exist which can be employed into recommender systems built for e-commerce.  In this blog-post we will have high level overview of the classification of such recommender algorithms.


##Algorithms

Recommender Algorithms are mainly classified into two categories as described below:

1. ###Content based recommendation systems
> Content-based recommendation systems recommend an item to a user based upon a description of the item and a profile of the user’s interests. While a user profile may be entered by the user, it is commonly learned from feedback and/or the interaction of the user on items. A variety of learning algorithms have been adapted to learning user profiles. [1]  
> 
> Algorithms: Relevance feedback, genetic algorithms, neural networks, and the Bayesian classifier are among the learning techniques for learning a user profile. The vector space representation and latent semantic indexing can both be used by these learning methods to represent documents.
> 
> Pros: It does not depend on other user's feedback. Provides purely feature based recommendations. It Does not suffer from cold start.
> 
> Cons: Limited content analysis and limited degree of novelty, resulting in lower recommendation value.
> 
2. ###collaborative-filtering
> From all different approaches for obtaining recommendations, the most popular one is by far the collaborative-filtering. This approach makes recommendations by discovering correlation between users of the recommender system. It is a unified approach for discovering the list of potentially interesting items (items not been accessed by the active user) and predicting its relevancy to the active user. The idea is to reach the final recommendation only on the basis of similar users and their actions. [6]
> 
> Two main categories of collaborative-filtering algorithms:
> 
> 1. **User-based Collaborative Filtering (Memory-based):** Memory-based algorithms utilize the entire user-item database to generate a prediction. These systems employ statistical techniques to find a set of users, known as neighbors, that have a history of agreeing with the target user (i.e., they either rate different items similarly or they tend to buy similar set of items). Once a neighborhood of users is formed, these systems use different algorithms to combine the preferences of neighbors to produce a prediction or top-N recommendation for the active user. The techniques, also known as nearest-neighbor or user-based collaborative filtering are more popular and widely used in practice. User-based collaborative filtering systems have been very successful in past, but their widespread use has revealed some potential challenges such as Sparsity and Scalability.[2]
> 2. **Item-based Collaborative Filtering (Model-based):** Model-based collaborative filtering algorithms provide item recommendation by first developing a model of user ratings. Algorithms in this category take a probabilistic approach and envision the collaborative filtering process as computing the expected value of a user prediction, given his/her ratings on other items.[2] The model building process is performed by different machine learning algorithms such as Bayesian networks, clustering models, latent semantic models such as singular value decomposition, probabilistic latent semantic analysis, multiple multiplicative factor, latent Dirichlet allocation and Markov decision process based models.      
The Bayesian network model[7] formulates a probabilistic model for collaborative filtering problem. Clustering model treats collaborative filtering as a classification problem [7,8,9] and works by clustering similar users in same class and estimating the probability that a particular user is in a particular class C, and from there computes the conditional probability of ratings. The rule-based approach applies association rule discovery algorithms to find association between co-purchased items and then generates item recommendation based on the strength of the association between items [10].
> 
> Pros: Higher recommendation value. Produces higher degree of novelty. Well tested in production environment.
> 
> Cons: Suffers heavily from cold start.


##Conclusion
There are no rules when it comes to choose algorithms while designing recommender system.  It has been observed that multiple techniques and algorithms are used togather to achieve high quality results from the recommender system depending on given problem space.  For an example User-based Collaborative Filtering and Item-based Collaborative Filtering techniques are often used togather.  Also data-mining techniques, dimensionality-reduction algorithm and link analysis are used for meeting specific needs of such system. 


##References

1. Michael J. Pazzani and Daniel Billsus. Content-based Recommendation Systems.
2. Badrul Sarwar, George Karypis, Joseph Konstan, and John Riedl Item-based Collaborative Filtering Recommendation Algorithms.
3. J. Ben Schafer, Joseph Konstan, John Riedl. Recommender Systems in E-Commerce.
4. Frederick F. Reichheld and W. Earl Sasser, Jr. Zero Defections: Quality Comes to Services. Harvard Business School Review, 1990(5).
5. Frederick F. Reichheld. Loyalty-Based Management. Harvard Business School Review, 1993(2).
6. Saša Bošnjak, Mirjana Marić and Zita Bošnjak. (2008). Choosing a Collaborative Filtering Algorithm for e-Commerce.
7. Breese, J. S., Heckerman, D., and Kadie, C. (1998). Empirical Analysis of Predictive Algorithms for Collaborative Filtering. In Proceedings of the 14th Conference on Uncertainty in Artificial Intelligence, pp. 43-52.
8. Basu, C., Hirsh, H., and Cohen, W. (1998). Recommendation as Classification: Using Social and Content-based Information in Recommendation. In Recommender System Workshop ’98. pp. 11-15.
9. Ungar, L. H., and Foster, D. P. (1998) Clustering Methods for Collaborative Filtering. In Workshop on Recommender Systems at the 15th National Conference on Artificial Intelligence.
10. Sarwar, B. M., Karypis, G., Konstan, J. A., and Riedl, J. (2000). Analysis of Recommendation Algorithms for E-Commerce. In Proceedings of the ACM EC’00 Conference. Minneapolis, MN. pp. 158-167
