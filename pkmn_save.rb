require 'fileutils'

class Save

  def fill_save(save_state)
    @save_arr = Dir["./dex_seed/*"] + Dir["./dex_store/*"]
    @save_arr.each do |path|
        FileUtils.cp(path, save_state + "/" + path)
    end
  end

  def new_save
    puts
    print 'Please give a name to this save: '
    @save_name = STDIN.gets.chomp.downcase.split(" ").join("_")
    @save_name = './saves/' + @save_name

    FileUtils.mkdir(@save_name)
    FileUtils.cd(@save_name)
    FileUtils.mkdir("dex_seed")
    FileUtils.mkdir("dex_store")
    FileUtils.cd("..")
    FileUtils.cd("..")

    fill_save(@save_name)
  end

  def overwrite
    @current_saves = Dir['./saves/*']

    puts
    puts "List of current save states:"
    puts "There are no existing saves." if @current_saves.empty?
    @count = 0
    @current_saves.each do |save|
      @count += 1
      puts @count.to_s + " - " + save.split("/").pop.split("_").join(" ")
    end
    puts
    print "Give the number of the save you wish to overwrite: "
    @save_num = STDIN.gets.chomp.to_i
    fill_save(@current_saves[@save_num - 1])
  end
end

puts "Would you like to save a new adventure or overwrite an existing save?"
print "Input options: "
print "new or n - new save"
puts "over or o - overwrite save "
@save_method = STDIN.gets.chomp.downcase

case @save_method
when 'new', 'n'
  Save.new.new_save
when 'over', 'o'
  Save.new.overwrite
else
  puts "I am sorry I don't know that input."
end
