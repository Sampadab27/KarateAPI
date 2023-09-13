Feature: Tests for Articles

Background: Define urls
Given url 'https://api.realworld.io/api/'
Given path 'users/login'
And request {"user": {"email":"karate.test98@test.com","password": "karate2716"}}
When method Post
Then status 200
* def token = response.user.token

Scenario: Create a new article
Given header Authorization = 'Token ' +token
Given path 'articles'
And request {"article": {"tagList": [],"title": "article 3","description": "article 2","body": "article 2"}}
When method Post
Then status 201
And match response.article.description == "article 8"

Scenario: Create and delete a article
Given header Authorization = 'Token ' +token
Given path 'articles'
And request {"article": {"tagList": [],"title": "article 9","description": "article 2","body": "article 2"}}
When method Post
Then status 201
* def articleId = response.article.slug

Given params { limit: 10, offset:0} 									// second way to append parameters in url in a single line
Given path 'articles'
When method Get
Then status 200
And match response.article[0].title == 'article 9'

Given header Authorization = 'Token ' +token
Given path 'articles', articleId
When method Delete
Then status 200

Given params { limit: 10, offset:0} 									// second way to append parameters in url in a single line
Given path 'articles'
When method Get
Then status 200
And match response.article[0].title != 'article 9'