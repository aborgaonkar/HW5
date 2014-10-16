# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
   assert result
 end

When /^I am on "(.*?)"$/ do |title|
	if title=="Movie Title"
	click_on("title_header")	
	end
end

Then /^I should see "(.*)" before "(.*)"$/ do |x,y|
	if page.body.index(x)<page.body.index(y)
	
	else
	 assert false
	end
end
When /^I am selecting "(.*?)"$/ do |date|
	if date=="Release Date"
	click_on("release_date_header")
	end
end

Then /^I should view "(.*)" before "(.*)"$/ do |x,y|
	if page.body.index(x)<page.body.index(y)

	else
	assert false 
	end
end
 

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    expect(page).to have_content(text)
  else
    assert page.has_content?(text)
  end
end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW3. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
	movies_table.hashes.each do |movie|
	Movie.create!(movie)
  
  
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # You should arrange to add that movie to the database here.
    # You can add the entries directly to the databasse with ActiveRecord methodsQ
  end
 # flunk "Unimplemented"
end

When /^I have opted to see movies rated: "(.*?)"$/ do |ratings|
	var=ratings.split(",")
	var.each { |a| a.strip! if a.respond_to? :strip!}

	var.each do |rating|
	check "ratings_#{rating}"
	end
	click_button 'Refresh'  
#movie_rating.split().eachdo |rating|
#if opted
#	uncheck "movie-rating_#{rating}"
#else	
#	uncheck "movie_rating_#{rating}"
#end
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)
  #flunk "Unimplemented"
end

Then /^I should see only movies rated "(.*?)"$/ do |rating|
	var1=0
	arg=rating.split(",")
	arg.each {|a| a.strip! if a.respond_to? :strip!}
	all("td").each do
	var1 = var1+1
        end

        arg1=Movie.where(:rating => arg[0]).count
	arg2=Movie.where(:rating => arg[1]).count
	var3=arg1+arg2
	assert_equal(var1/8,var3)
end

Then /^I should see all of the movies$/ do
 # movies=Movie.all
  #movies.each do |movie|
  #assert page.body=~/#{movie.title}/m
#end
row= page.all('tr').count
row.should==11
  #flunk "Unimplemented"

end


