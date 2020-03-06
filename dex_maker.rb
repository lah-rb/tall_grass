module DexMaker

  def self.fill_dex(dex_pool)
    @seed = rand(0...dex_pool.size)
    @specimen = dex_pool[@seed]
    if @refined_dex.none?(@specimen)
      @refined_dex << @specimen
    else
      self.fill_dex(dex_pool)
    end
  end

  def self.limit_pool(dex_pool, pages)
    (0...pages).each { self.fill_dex(dex_pool) }
  end
  
  def self.filter_dex(legendary,types, evolutions)
    #TBC
  end

  def self.type_select(dex_pool, type)
    @type_dex = []
    type.map! {|i| i.capitalize}
    dex_pool.each do |entry|
      if type.any?(entry[3]) || type.any?(entry[4])
        @type_dex << entry
      end
    end
    @type_dex
  end

  def self.write_dex(refined_dex, file_name)
    File.open(file_name, 'w') do |new_dex|
      refined_dex.each do |entry|
        @line = ""
        (0...entry.size).each do
          @line = @line + entry.shift + "-"
        end
        new_dex.puts("#{@line.chop}")
      end
    end
  end

  def self.teaming
    rand(0..1) * 10 + rand(0..10) * 4 + rand(0..5) * 2 + rand(0..2) * 3 + rand(0..4)
  end

  #dex_pool is array, pages is integer, file is string, type is array
  def self.create_dex(dex_pool, file, type, pages=self.teaming)
    @refined_dex = []
    if type.empty?
      self.limit_pool(dex_pool, pages)
      self.write_dex(@refined_dex, file)
    else
      self.limit_pool(self.type_select(dex_pool, type), pages)
      self.write_dex(@refined_dex, file)
    end
  end
end
