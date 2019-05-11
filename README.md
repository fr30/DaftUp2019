Jakub Frąc 

In order to start the app, you have to type standard commands for starting ruby server and generate a database, namely:

rake db:setup


rails server

List of available endpoints can be obtained by:

rails routes

List of few hand-mande tests for subtask 3 is in file tests.txt

Every test case contains query to POST request /cart/items and /cart/discounts. Those queries predefine the state of cart before each test. Then there's my ouput from GET /cart/total.