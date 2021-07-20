# Ruby application without Rails

#SETUP
* Run migration using 'rake db:migrate'
* Add default user by run 'rake db:seed'
* 'rake run' to run the application

#API
* User Login 
   * curl -i -X POST -H "Content-Type: application/json" -d '{"email":"{email}", "password":"#{password}"}' http://localhost:8080/users/login
   * Response will be user id and token
   * token will valid only for the day

* List Users
  * curl -i  http://localhost:8080/users/index  
* User creation
  * curl -i -X POST -H "Content-Type: application/json" -d '{"email":"{email}","name":"{name}","password":"{password}"}' http://localhost:8080/users/create

* Post creation
  * curl -i -X POST -H "Content-Type: application/json" -d '{"user_id": "{user_id}", "token": "{token}", "post": {"title":"post3", "content": "contttt"}}' http://localhost:8080/posts/create

* List all posts
  * curl -i -X GET -H "Content-Type: application/json" -d '{"user_id": "{user_id}", "token": "{token}"}'  http://localhost:8080/posts/index  

  * curl -i  'http://localhost:8080/posts/index?user_id=1&token={token}'
* Rate a post
  * curl -i  'http://localhost:8080/posts/rate?id={post_id}&rate={rate}'
  * Rate should be a value within 1 to 5

* List top N posts, based on Average rate
  * curl -i  'http://localhost:8080/posts/top_posts?n={N}'
*List Posts Group by Ip address
  * curl -i  'http://localhost:8080/posts/ips'

