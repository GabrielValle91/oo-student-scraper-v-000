require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_list = doc.css(".student-card")
    student_list.each do |student|
      student_hash = {}
        student_hash[:name] = student.css("h4").text
        student_hash[:location] = student.css("p").text
        student_hash[:profile_url] = student.css("a").attribute("href").value

      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_links = doc.css(".social-icon-container")
    
    student_hash = {}
    student_links.each do |link|
      if link.css("a").attribute("href").value.contains?("twitter")
        student_hash[:twitter] = link.css("a").attribute("href").value
      elsif link.css("a").attribute("href").value.contains?("linkedin")
        student_hash[:linkedin] = link.css("a").attribute("href").value
      elsif link.css("a").attribute("href").value.contains?("github")
        student_hash[:github] = link.css("a").attribute("href").value
      else
        student_hash[:blog] = link.css("a").attribute("href").value
      end
    end
    binding.pry
  #  :twitter=>"https://twitter.com/jmburges",
  #                            :linkedin=>"https://www.linkedin.com/in/jmburges",
  #                            :github=>"https://github.com/jmburges",
  #                            :blog=>"http://joemburgess.com/",
  #                            :profile_quote=>"\"Reduce to a previously solved problem\"",
  #                            :bio=>
  end

end
