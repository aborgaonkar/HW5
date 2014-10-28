class Movie < ActiveRecord::Base
  require 'themoviedb'
  def self.all_ratings
    %w(G PG PG-13 R)
  end
  def Movie::create_from_tmdb (mov1=Array.new)
  val=Hash.new
    
   mov1.each do |j|
    val=Tmdb::Movie.detail(j)  
    Movie.create!({:title => val.title, :rating => 'R', :description => nil, :release_date => val.release_date})
   end
   end
  def self.find_in_tmdb params
   #Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
   #f4702b08c0ac6ea5b51425788bb26562
	Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
   movies = Tmdb::Movie.find(params)
   x = Array.new

   if movies.blank?
     return []
   else
     movies.each do |mov|
       y = Hash.new
       y[:title] = mov.title
       y[:release_date] = mov.release_date
       y[:tmdb_id] = mov.id
       y[:rating] = "G"
       x.push(y)
     end
   end
   return x

 end

end
