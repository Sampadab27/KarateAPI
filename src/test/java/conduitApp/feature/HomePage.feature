Feature: Tests for Home Page

Background: Define urls
Given url 'https://api.realworld.io/api/'

	Scenario: Get all Tags
	Given path 'tags'
	When method Get
	Then status 200
	And match response.tags contains ['welcome', 'implementations'] 		// assertion - checking values exists or not
	And match response.tags == "#array" 									// Verify values are in array
	And match each response.tags == "#string" 								// Verify all the values are in String format
	
	Scenario: Get 10 articles
	#Given param limit = 10 												// first way to append parameters in url
	#Given param offset = 0
	Given params { limit: 10, offset:0} 									// second way to append parameters in url in a single line
	Given path 'articles'
	When method Get
	Then status 200
	And match response.articles == '#[10]' 									// Verify no. of article in array
	And match response.articlesCount == 197 								// verify the articles count
	