class ToDoItem
  attr_reader :text
  attr_accessor :done

  def initialize(text, done = false)
    @text = text
    @done = done
  end

  def to_line
    "#{done ? 1 : 0} | #{text}"  # in here it is actually using the getter that attr_* has created
  end

  def self.from_line(line)
    status, text = line.split("|", 2)
    return nil if status.nil? || text.nil?
    done = status.strip == "1"
    ToDoItem.new(text.chomp&.strip, done)  
  end

  def display(index)
    mark = done ? "x" : " "
    "#{index}. [#{mark}] #{text}"
  end
end

class ToDoList
  FILE_NAME = "ToDos.txt"

  def initialize
     @to_dos = []
  end

  def add(text)
    if text.nil? || text.strip.empty?
      puts "Cannot add an empty todo."
      return
    end
    @to_dos << ToDoItem.new(text)
    puts "Added."
  end

  def list_todos()
    @to_dos.each_with_index { |todo, index| puts todo.display(index)}
  end

  def done(index)
    begin
      index = Integer(index)
      raise ArgumentError if index.nil? || index < 0 || index >= @to_dos.length
      @to_dos[index].done = true
      puts "Marked done."
    rescue ArgumentError
      puts "Please enter a number 0 and #{@to_dos.length}."
    end
  end

  def remove(index)
    begin
      index = Integer(index)
      raise ArgumentError if index.nil? || index < 0 || index >= @to_dos.length
      @to_dos.delete_at(index)
      puts "Removed."
    rescue ArgumentError
      puts "Please enter a number 0 and #{@to_dos.length}."
    end
  end

  def save
    content = @to_dos.map(&:to_line).join("\n") + "\n"  # This &:to_line is shorthand for: @items.map { |item| item.to_line }. It’s called “symbol to proc” shorthand.
    File.write(FILE_NAME, content)
    puts("Saved to #{FILE_NAME}")
  end

  def load
    unless File.exist?(FILE_NAME)
      puts "No saved file found with address: #{FILE_NAME}"
    end
    loaded = []
    content = File.read(FILE_NAME)
    content.each_line do |line|
      todo = ToDoItem.from_line(line)
      loaded << todo if todo
    end
    @to_dos = loaded
    puts "Loaded #{@to_dos.length} item(s) from #{FILE_NAME}"
  end

  def quit
    puts "Goodbye!"
    exit(0)
  end

  def run
    puts "Todo CLI. Commands: add, list, done, remove, save, load, quit"
    
    loop do
      print "> "
      raw = gets
      if raw.nil?
        quit
      end
      input = raw.chomp.strip
      next if input.empty?
      
      command, rest = input.split(" ", 2)

      case command
      when "add"
        add(rest)
      when "list"
        list_todos
      when "done"
        done(rest)
      when "remove"
        remove(rest)
      when "save"
        save
      when "load"
        load
      when "quit", "exit"
        quit
      else
        puts "Unknown command. Try: add, list, done, remove, save, load, quit"
      end
    end
  end
end

ToDoList.new.run
