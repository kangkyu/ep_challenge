## 1. Generate a new rails app

    $ rails new ep_challenge
    $ rails server

**Create a git repository**  
`$ git init`

**Check status**  
`$ git status`
 
**Add everything to the repository**  
`$ git add .`

**Check status**  
`$ git status`

**Commit everything**  
`$ git commit -m 'Initial commit'`

**Check status**  
`$ git status`

[**Create a Github repository**](https://github.com/jendiamond/ep_challenge)   

**Add the remote host to your local git**  
`$ git remote add origin git@github.com:jendiamond/ep_challenge.git`

**Check your remotes**  
`$ git remote -v`

**Push commit to Github**  
`$ git push -u origin master`

**Update the README**

`$ git mv README.rdoc README.md`
 
-----

**[https://www.youtube.com/watch?v=VPor5ErX_90](https://www.youtube.com/watch?v=VPor5ErX_90)**

### 2. Perform this task in "Rails" using MVC

#### Create a Fetch Model with Controllers and Views with a form that takes a url. 

See example form [http://www.githubarchive.org](http://www.githubarchive.org)   
> **Query**   
> Activity for 1/1/2015 @ 3PM UTC

> **Command**  
> wget http://data.githubarchive.org/2015-01-01-{0..23}.json.gz
 
    $ rails generate controller fetches 
    $ rails generate model Fetch get_info:string
    $ rake db:migrate
    
    $ cd db
    $ sqlite3 development.sqlite3
    sqlite > .schema
    sqlite > .quit
   
=====   
    
  $ vim app/controllers/fetch_controller.rb
    
    class FetchController < ApplicationController
      def new
        @fetch = Fetch.new
      end
      
      def create
        @fetch = Fetch.new(fetch_params)
        if @fetch.save
          redirect_to new_fetch_path
        end
      end

      private

      def fetch_params
        params.require(:fetch).permit(:get_info)
      end 
    end

=====

  $ vim app/views/fetches/new.html.erb

    <h1>Fetch data from Github</h1>

    <%= form_for(@fetch) do |f| %>
      <%= f.text_field :get_info %>
      <br/><br/>
      <%= f.submit %>
    <% end %>

=====  

  $ vim config/routes.rb

    Rails.application.routes.draw do
      root 'fetch#new'

      resources :fetches    

    end

=====  

 $ vim app/view/fetches/show.html.erb

    Get info: <%= @fetch.get_info %> <%# get_info method on the @fetch object %>

====

##### Show any errors, like a blank field, resulting from bad input in the form. 
 
Added to this block of code to app/models/fetch.rb
 
    class Fetch < ActiveRecord::Base
      validates :get_info, presence: true
    end

And this block of code to app/views/fetches/new.html.erb

    <hr />

      <% if @fetch.errors.present? %>
        <h2>Errors</h2>
        <% @fetch.errors.full_messages.each do |message| %>
          <%= message %>
        <% end %>
      <% end %>

=====

##### Enter in the url: 

http://data.githubarchive.org/2014-01-01-1.json.gz

###### To display information from the fetched url

Added to this block of code to app/views/fetch/new.html.erb

    <h2>Display all retrieved information</h2>
      <% if !@fetches.blank? %>
        <% for item in @fetches %>
        <%= item.get_info %>
      <% end %>
    </div>

Added this line to app/controllers/fetch_controller.rb
 
    @fetches = Fetch.find

-----

#### 3. With the URL that was input through the view's form, fetch data for the 'entire day of 2014-01-01' and insert them into a database via your rails model.

##### To load, read and write the information fetched from the Github url

###### Added the [gem yajl](https://github.com/brianmario/yajl-ruby) to the Gemfile

    gem "yajl-ruby"

###### Added to the app/views/fetches/show.html.erb

    Get info: <%= @fetch.get_info %> <%# Comment: get_info method on the @fetch object %>  
    <br />  
    <% Yajl::Parser.parse(@fetch.events_js) do |event| %>  
      <%= event %>  
    <% end %>


###### Added this block of code to the app/models/fetch.rb

    require 'open-uri'  
    require 'zlib'  
    require 'yajl'

    class Fetch < ActiveRecord::Base  
      validates :get_info, presence: true

      def events_js  
        gz = open(get_info)  
        js = Zlib::GzipReader.new(gz).read  
      end  
    end

=====

Save each json element as an ActiveRecord object do this in the fetch create method in the controller or in the fetch model

hash = JSON.parse string

-----

### Displaying a report:

#### 1. Create another model called Report with controllers and views.

    $ rails generate controller reports
    $ rails generate model Report time_range:string


#### 2. Here you will create a form that will take a time range **(put this in a partial so it can be reused)**.   
Query your database for the 'type' of 'PushEvent' within that time range.

    $ rake db:migrate
    $ vim app/views/shared/_timerange.rb

**Query your database for the 'type' of 'PushEvent' within that time range.**

------

#### 3. Output the results in a bar graph showing only the top ten ['repository']['name'] and the count. (hint some ['repository']['name'] have multiple PushEvents)

+ [graphing](https://www.ruby-toolbox.com/categories/graphing)
[Graphs](https://books.google.com/books?id=87YaAtJn5BQC&pg=PA155&lpg=PA155&dq=rails+Output+the+results+in+a+bar+graph&source=bl&ots=Y182B3tPyl&sig=R0YJJ12tj1h2rsLn0_9bfOtfXG4&hl=en&sa=X&ei=-KLlVLfwOZekoQTZnoC4Bg&ved=0CD0Q6AEwBA#v=onepage&q=rails%20Output%20the%20results%20in%20a%20bar%20graph&f=false)
+ [githubarchive.org/](https://www.githubarchive.org/)
+ [Railscasts Episodes/223 Charts](http://railscasts.com/episodes/223-charts?view=comments)
+ [display-in-a-graph-just-unique-values-for-a-column](http://stackoverflow.com/questions/19856714/display-in-a-graph-just-unique-values-for-a-column)

------

#### 4. Create a second page that outputs the results in a datatable showing only the top 25 by ['repository']['name'], ['repository']['url'], and count.   
Hyperlink the name to the repository url.  
(Hint: here's a plugin that helps draw datatables - https://datatables.net)

**Resources:**
+ [Railscasts Episodes Datatables](http://railscasts.com/episodes?utf8=%E2%9C%93&search=datatables)
+ [Sitepoint working-jquery-datatables/](http://www.sitepoint.com/working-jquery-datatables/)
+ [jquery-datatables-column-filter](https://jquery-datatables-column-filter.googlecode.com/svn/trunk/default.html)
+ [Enhancing-HTML-tables-using-a-JQuery-DataTables](http://www.codeproject.com/Articles/194916/Enhancing-HTML-tables-using-a-JQuery-DataTables-pl)

------

#### Extra Credit:

#### Give the report a dropdown option for all EventTypes that gets the same report via ajax.

+ [Ajax and Rails](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&es_th=1&ie=UTF-8#q=drop+down+report+via+ajax+rails)

------

#### Add styling using Twitter Bootstrap

###### Added bootstrap to the Gemfile

    gem 'bootstrap-sass',       '3.2.0.0'

  $ bundle install

=====

###### Added SCSS in the app/assets/stylesheets/custom.css.scss

    @import "bootstrap-sprockets";  
    @import "bootstrap";  

    /* mixins, variables, etc. */

    $gray-medium-light: #eaeaea;

    @mixin box_sizing {  
      -moz-box-sizing:    border-box;  
      -webkit-box-sizing: border-box;  
      box-sizing:         border-box;  
    }

    /* universal */

    html {  
      overflow-y: scroll;
    }

    body {  
      padding-top: 60px;  
      background-color: #ccc;  
    }

    section {  
      overflow: auto;  
    }

    textarea {  
      resize: vertical;   
    }

    .center {  
      text-align: center;  
    }

    .center h1 {  
      margin-bottom: 10px;  
    }

    #fetch_box {  
      background-color: #ddd;  
      width: 50%;  
      margin: 0 auto;  
      padding: 20px;  
      border: 1px solid #939393  
    }

    /* typography */

    h1, h2, h3, h4, h5, h6 {  
      line-height: 1;  
    }  

    h1 {  
      font-size: 3em;  
      letter-spacing: -2px;  
      margin-bottom: 30px;  
      text-align: center;  
    }

    h2 {  
      font-size: 1.2em;  
      letter-spacing: -1px;  
      margin-bottom: 30px;  
      text-align: center;  
      font-weight: normal;  
      color: #777;  
    }

    p {  
      font-size: 1.1em;  
      line-height: 1.7em;  
    }

    /* header */ 

    header {
      float: left;  
      margin-right: 10px;  
      font-size: 1em;  
      color: white;  
      font-style: bold;  
      text-transform: uppercase;    
      letter-spacing: -1px;  
      padding-top: 3px;  
      font-weight: bold;  
      h1 {  
      float: left;  
      }  
      &:hover {  
        color: white;  
        text-decoration: none;  
      }  
    }

    /* footer */

    footer {  
      margin-top: 45px;  
      padding: 5px;  
      border-top: 1px solid $gray-medium-light;  
      color: $gray-light;  
      a {  
        color: $gray;  
        &:hover {  
          color: $gray-darker;  
        }  
      }
      small {  
        float: left;  
      }  
      ul {
        float: right;  
        list-style: none;  
        li {  
          float: left;  
          margin-left: 15px;  
      }  
    }

=====   

###### Added a header and a footer in app/views/layouts/application.html.erb

    <!DOCTYPE html>  
    <html>  
      <head>  
        <title><%= full_title(yield(:title)) %></title>  
        <%= stylesheet_link_tag 'application', media: 'all',  
                                           'data-turbolinks-track' => true %>  
        <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>  
        <%= csrf_meta_tags %>  
        <%= render 'layouts/shim' %>  
      </head>  
      <body>  
        <%= render 'layouts/header' %>  
        <div class="container">  
          <%= yield %>  
        </div>  
      </body>  
    </html>

=====

###### Add a partial for Internet Explorer Compatibilty app/views/layouts/_shim.html.erb

    <!--[if lt IE 9]>  
      <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/r29/html5.min.js">  
      </script>  
    <![endif]-->

=====

###### Added a header partial app/views/layouts/_header.html.erb

    <header class="navbar navbar-fixed-top navbar-inverse">  
      <div class="container">  
        <%= link_to "sample app", '#', id: "logo" %>  
        <nav>  
          <ul class="nav navbar-nav navbar-right">  
            <li><%= link_to "Home",   '#' %></li>  
            <li><%= link_to "Help",   '#' %></li>  
            <li><%= link_to "Log in", '#' %></li>  
          </ul>  
        </nav>  
  </div>  
</header>  

=====

###### Added a footer partial app/views/layouts/_footer.html.erb
    <footer class="footer">  
      <p><small>  
        Jen Diamond - thejendiamond@gmail.com  
      </small>  
      <nav>  
        <ul>  
          <li><%= link_to "Home",   '#' %></li>  
          <li><%= link_to "Top 10", '#' %></li>  
          <li><%= link_to "Top 25", '#' %></li>  
        </ul>  
      </nav>  
    </footer>

-----
