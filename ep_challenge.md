[https://github.com/ceospfx/epoch/blob/master/README.md](https://github.com/ceospfx/epoch/blob/master/README.md)

## Generate a new rails app.

    $ rails new epoch_fetch_and_insert_in_db
    $ rake db:create
    $ bundle install
    $ rails server
    
==========

**Create a git repository**  
 $ git init
 
**Add everything to the repository**  
`$ git add .`

**Commit everything**  
`$ git commit -m 'Initial commit'`

**Create a Github repository**  

**Add the remote host to your local git**  
`$ git remote add origin git@github.com:jendiamond/ep_challenge.git`

**Push commit to Github**  
`$ git push -u origin master`

=====
    
You can write `$ rails s`, `$ rails g` and `$ bundle` but it is good practice to be specific about what you are doing.

Migrations are Ruby classes that are designed to make it simple to create and modify database tables. Rails uses rake commands to run migrations.

##### Perform this task in "Rails" using MVC. Create a Fetch Model with Controllers and Views with a form that takes a url. See example from http://www.githubarchive.org. ( eg. http://data.githubarchive.org/2014-01-01-1.json.gz )
 
    $ rail generate scaffold Fetch url:string 
    $ rake db:migrate

------

#### With the URL that was input through the view's form, fetch data for the 'entire day of 2014-01-01' and insert them into a database via your rails model.

    $ vim app/models/fetch.rb

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

+ [http://apidock.com/rails/ActiveSupport/TimeWithZone/strftime](http://apidock.com/rails/ActiveSupport/TimeWithZone/strftime)
+ [http://guides.rubyonrails.org/v2.3.11/active_record_querying.html](http://guides.rubyonrails.org/v2.3.11/active_record_querying.html)
+ [http://stackoverflow.com/questions/9624601/activerecord-find-by-year-day-or-month-on-a-date-field](http://stackoverflow.com/questions/9624601/activerecord-find-by-year-day-or-month-on-a-date-field)

==============

+ [http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-url_field](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-url_field)

`url_field(object_name, method, options = {})Link`
`Returns a #text_field of type “url”.`
`url_field("user", "homepage")`
`# => <input id="user_homepage" name="user[homepage]" type="url" />`

`<%= url_field(:user, :homepage) %>`
+ [http://guides.rubyonrails.org/form_helpers.html](http://guides.rubyonrails.org/form_helpers.html)

+ [http://www.sitepoint.com/building-your-first-rails-application-models/](http://www.sitepoint.com/building-your-first-rails-application-models/)

+ [http://stackoverflow.com/questions/21630750/issues-creating-a-url-form-field-using-action-view-and-form-for](http://stackoverflow.com/questions/21630750/issues-creating-a-url-form-field-using-action-view-and-form-for)

------

### Displaying a report:

#### Create another model called Report with controllers and views.

###### Here you will create a form that will take a time range (put this in a partial so it can be reused). Query your database for the 'type' of 'PushEvent' within that time range.

    $ rail g scaffold Report timerange:
    $ rake db:migrate
    $ vim app/views/shared/_timerange.rb

**Query your database for the 'type' of 'PushEvent' within that time range.**

------

#### Output the results in a bar graph showing only the top ten ['repository']['name'] and the count. (hint some ['repository']['name'] have multiple PushEvents)

+ [http://stackoverflow.com/questions/19856714/display-in-a-graph-just-unique-values-for-a-column](http://stackoverflow.com/questions/19856714/display-in-a-graph-just-unique-values-for-a-column)
+ [https://www.ruby-toolbox.com/categories/graphing](https://www.ruby-toolbox.com/categories/graphing)
[https://books.google.com/books?id=87YaAtJn5BQC&pg=PA155&lpg=PA155&dq=rails+Output+the+results+in+a+bar+graph&source=bl&ots=Y182B3tPyl&sig=R0YJJ12tj1h2rsLn0_9bfOtfXG4&hl=en&sa=X&ei=-KLlVLfwOZekoQTZnoC4Bg&ved=0CD0Q6AEwBA#v=onepage&q=rails%20Output%20the%20results%20in%20a%20bar%20graph&f=false](https://books.google.com/books?id=87YaAtJn5BQC&pg=PA155&lpg=PA155&dq=rails+Output+the+results+in+a+bar+graph&source=bl&ots=Y182B3tPyl&sig=R0YJJ12tj1h2rsLn0_9bfOtfXG4&hl=en&sa=X&ei=-KLlVLfwOZekoQTZnoC4Bg&ved=0CD0Q6AEwBA#v=onepage&q=rails%20Output%20the%20results%20in%20a%20bar%20graph&f=false)
+ [https://www.githubarchive.org/](https://www.githubarchive.org/)
+ [http://railscasts.com/episodes/223-charts?view=comments](http://railscasts.com/episodes/223-charts?view=comments)

------

#### Create a second page that outputs the results in a datatable showing only the top 25 by ['repository']['name'], ['repository']['url'], and count.   
Hyperlink the name to the repository url.  
(Hint: here's a plugin that helps draw datatables - https://datatables.net)

**tutorials:**
+ [http://railscasts.com/episodes?utf8=%E2%9C%93&search=datatables](http://railscasts.com/episodes?utf8=%E2%9C%93&search=datatables)
+ [http://www.sitepoint.com/working-jquery-datatables/](http://www.sitepoint.com/working-jquery-datatables/)
+ [https://jquery-datatables-column-filter.googlecode.com/svn/trunk/default.html](https://jquery-datatables-column-filter.googlecode.com/svn/trunk/default.html)
+ [http://www.codeproject.com/Articles/194916/Enhancing-HTML-tables-using-a-JQuery-DataTables-pl](http://www.codeproject.com/Articles/194916/Enhancing-HTML-tables-using-a-JQuery-DataTables-pl)

------

#### Extra Credit:

#### Give the report a dropdown option for all EventTypes that gets the same report via ajax.

+ [https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&es_th=1&ie=UTF-8#q=drop+down+report+via+ajax+rails](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&es_th=1&ie=UTF-8#q=drop+down+report+via+ajax+rails)


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



