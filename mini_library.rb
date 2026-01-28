# class Book
#   attr_accessor :title, :author, :year

#   def initialize(title, author, year)
#     @title = title
#     @author = author
#     @year = year
#   end

#   def classic?
#     (Time.now.year - year) >= 50
#   end
# end

# module Catalog
#   include Enumerable
# end

# class Library
#   include Catalog

#   def initialize
#     @books = []
#     @title_map = Hash.new { |hash, key| hash[key] = [] }
#     @author_map = Hash.new { |hash, key| hash[key] = [] }
#   end

#   def each(&block)
#     @books.each(&block)
#   end

#   def add(book)
#     @title_map[book.title.downcase] << @books.length
#     @author_map[book.author.downcase] << @books.length
#     @books << book
#   end

#   def remove_by_title(title)
#     indexes = title_map.delete(title.downcase)
#     indexes&.each { |index| books.delete_at(index)}
#   end

#   def find_by_author(author)
#     indexes = author_map[author.downcase]
#     indexes.map { |index| @books[index]}
#   end
#   private
#   attr_accessor :books, :title_map, :author_map
# end

module Catalog
  include Enumerable
end

class Book
  attr_reader :title, :author, :year

  def initialize(title, author, year)
    @title  = title
    @author = author
    @year   = year
  end

  def classic?
    (Time.now.year - year) >= 50
  end
end

class Library
  include Catalog

  def initialize
    @books = []
  end

  def each(&block)
    @books.each(&block)
  end

  def add(book)
    @books << book
  end

  def remove_by_title(title)
    t = title.downcase
    @books.reject! { |b| b.title.downcase == t }
  end

  def find_by_author(author)
    a = author.downcase
    @books.select { |b| b.author.downcase == a }
  end
end