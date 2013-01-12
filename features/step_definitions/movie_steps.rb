# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.

     Movie.create!(movie) #create databae table
  end
  #flunk "Unimplemented" # remove when done
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

  first_pos = page.body.index(e1) #find index of first movie name
  second_pos = page.body.index(e2) #find index of second movie name
  first_pos.should < second_pos #compare index

  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(%r{,\s*}).each do | rating |
      rating = "ratings[" + rating + "]"  #concat string ==> ratings[R]
      if uncheck
        step %{I uncheck "#{rating}"}  #do it when uncheck rating
      else
        step %{I check "#{rating}"} #do it when check rating
      end
    end
    
end

Then /I should see all the movies/ do
  value = Movie.count(:all) +1 #+1 because table in html page have a title
  rows = page.body.scan(/<tr>/).length
  rows.should == value 
end