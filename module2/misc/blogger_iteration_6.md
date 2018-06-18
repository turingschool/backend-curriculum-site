
## I6: Extras

Here are some ideas for extension exercises:

* Add a site-wide sidebar that holds navigation links
* Create date-based navigation links. For instance, there would be a list of links with the names of the months and when you click on the month it shows you all the articles published in that month.
* Track the number of times an article has been viewed. Add a `view_count` column to the article, then in the `show` method of `articles_controller.rb` just increment that counter. Or, better yet, add a method in the `article.rb` model that increments the counter and call that method from the controller.
* Once you are tracking views, create a list of the three "most popular" articles
* Create a simple RSS feed for articles using the `respond_to` method and XML view templates
