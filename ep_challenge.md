[https://github.com/ceospfx/epoch/blob/master/README.md](https://github.com/ceospfx/epoch/blob/master/README.md)

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
> wget http://data.githubarchive.org/2015-01-01-15.json.gz
 
    $ rails generate controller Fetch 
    $ rails generate model Fetch url:string
    $ rake db:migrate
    
    $ cd db
    $ sqlite3 development.sqlite3
    sqlite > .schema
    sqlite > .quit
   
=====   
    
  $ vim app/controller/fetches_controller.rb
    
    class FethchesController < ApplicationController
      def new
        @fetch = Fetch.new
      end
      
      def create
        @fetch = Fetch.new(params[:url])
        if @fetch.save
          redirect_to new_fetch_path
      end
    end

=====   

  $ vim app/views/new.html.erb

    <h1>Fetch data from Github</h1>
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <%= form_for(@fetch) do |f| %>
          <%= f.label :url, "Input URL to get the data you want to see." %>
          <br/><br/>
          <%= f.text_field :url, class: "form-control" %>
          <br/><br/>
          <%= f.submit "Fetch Data", class: "btn btn-primary" %>
        <% end %>
      </div>
      <div>
        <h2>Display all retrieved information</h2>
          <% if !@fetches.blank? %>
            <% for item in @fetches %>
            <%= item.url %>
          <% end %>
       </div>
    </div>

#### 3. With the URL that was input through the view's form, fetch data for the 'entire day of 2014-01-01' and insert them into a database via your rails model.

wget http://data.githubarchive.org/2014-01-01-{0..23}.json.gz

    $ vim app/models/fetch.rb
    $ cd db
    $ sqlite3 development.sqlite3
    sqlite > .schema
    sqlite > .quit
    sqlite > .schema
    sqlite > select * from fetches;

**fetch data for the 'entire day of 2014-01-01'**

`Fetch.where(:date_column => date)`  

`Fetch.where("strftime('%Y', date_column) = ?", 2014) Fetch.where("strftime('%m', date_column) + 0 = ?", 01)`   `Fetch.where("strftime('%d', date_column) + 0 = ?", 01)`  

`def self.by_year(year) `  
  `where('extract(year from date_column) = ?', year) `  
`end`  

`def self.by_year(year)`   
 ` dt = DateTime.new(year) `  
 ` boy = dt.beginning_of_year `  
  `eoy = dt.end_of_year `  
  `where("published_at >= ? and published_at <= ?", boy, eoy) `  
`end`

**insert them into a database via your rails model**

Assuming that your "date attribute" is a date (rather than a full timestamp) then a simple wherewill give you your "find by date":

+ [ActiveSupport/TimeWithZone/strftime](http://apidock.com/rails/ActiveSupport/TimeWithZone/strftime)
+ [active_record_querying.html](http://guides.rubyonrails.org/v2.3.11/active_record_querying.html)
+ [activerecord-find-by-year-day-or-month-on-a-date-field](http://stackoverflow.com/questions/9624601/activerecord-find-by-year-day-or-month-on-a-date-field)
+ [Learn how to use your database to make your Ruby on Rails applications rock solid.](http://www.pluralsight.com/courses/database-your-friend)

==============

+ [ActionView/Helpers/FormHelper.html#method-i-url_field](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-url_field)

`url_field(object_name, method, options = {})Link`
`Returns a #text_field of type “url”.`
`url_field("user", "homepage")`
`# => <input id="user_homepage" name="user[homepage]" type="url" />`

`<%= url_field(:user, :homepage) %>`
+ [form_helpers.html](http://guides.rubyonrails.org/form_helpers.html)

+ [building-your-first-rails-application-models/](http://www.sitepoint.com/building-your-first-rails-application-models/)

+ [issues-creating-a-url-form-field-using-action-view-and-form-for](http://stackoverflow.com/questions/21630750/issues-creating-a-url-form-field-using-action-view-and-form-for)

------

### Displaying a report:

#### 1. Create another model called Report with controllers and views.

###### 2. Here you will create a form that will take a time range (put this in a partial so it can be reused). Query your database for the 'type' of 'PushEvent' within that time range.

    $ rail g scaffold Report timerange:
    $ rake db:migrate
    $ vim app/views/shared/_timerange.rb

**Query your database for the 'type' of 'PushEvent' within that time range.**

------

#### 3. Output the results in a bar graph showing only the top ten ['repository']['name'] and the count. (hint some ['repository']['name'] have multiple PushEvents)

+ [display-in-a-graph-just-unique-values-for-a-column](http://stackoverflow.com/questions/19856714/display-in-a-graph-just-unique-values-for-a-column)
+ [graphing](https://www.ruby-toolbox.com/categories/graphing)
[Graphs](https://books.google.com/books?id=87YaAtJn5BQC&pg=PA155&lpg=PA155&dq=rails+Output+the+results+in+a+bar+graph&source=bl&ots=Y182B3tPyl&sig=R0YJJ12tj1h2rsLn0_9bfOtfXG4&hl=en&sa=X&ei=-KLlVLfwOZekoQTZnoC4Bg&ved=0CD0Q6AEwBA#v=onepage&q=rails%20Output%20the%20results%20in%20a%20bar%20graph&f=false)
+ [githubarchive.org/](https://www.githubarchive.org/)
+ [Railscasts Episodes/223 Charts](http://railscasts.com/episodes/223-charts?view=comments)

------

#### 4. Create a second page that outputs the results in a datatable showing only the top 25 by ['repository']['name'], ['repository']['url'], and count.   
Hyperlink the name to the repository url.  
(Hint: here's a plugin that helps draw datatables - https://datatables.net)

**tutorials:**
+ [Railscasts Episodes Datatables](http://railscasts.com/episodes?utf8=%E2%9C%93&search=datatables)
+ [Sitepoint working-jquery-datatables/](http://www.sitepoint.com/working-jquery-datatables/)
+ [jquery-datatables-column-filter](https://jquery-datatables-column-filter.googlecode.com/svn/trunk/default.html)
+ [Enhancing-HTML-tables-using-a-JQuery-DataTables](http://www.codeproject.com/Articles/194916/Enhancing-HTML-tables-using-a-JQuery-DataTables-pl)

------

#### Extra Credit:

#### Give the report a dropdown option for all EventTypes that gets the same report via ajax.

+ [Ajax and Rails](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&es_th=1&ie=UTF-8#q=drop+down+report+via+ajax+rails)


------
#### Add styling using Twitter Bootstrap.

    $ vim Gemfile

    source 'https://rubygems.org'

    gem 'rails',                          '4.2.0'
    gem 'bootstrap-sass',       '3.2.0.0'

    $ bundle install
    $ vim app/assets/stylesheets/custom.css.scss

    @import "bootstrap-sprockets";
    @import "bootstrap";

/* universal */

body {
  padding-top: 60px;
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

#logo {
  float: left;
  margin-right: 10px;
  font-size: 1.7em;
  color: #fff;
  text-transform: uppercase;
  letter-spacing: -1px;
  padding-top: 9px;
  font-weight: bold;
}

#logo:hover {
  color: #fff;
  text-decoration: none;
}



app/views/layouts/application.html.erb
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

app/views/layouts/_shim.html.erb
<!--[if lt IE 9]>
  <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/r29/html5.min.js">
  </script>
<![endif]-->

app/views/layouts/_header.html.erb
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



