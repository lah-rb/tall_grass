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
    (0...pages).each do
      self.fill_dex(dex_pool)
    end
  end

  def self.type_select(dex_pool, type)
    @type_dex = []
    dex_pool.each do |entry|
      if type.any?(entry[2]) || type.any?(entry[3])
        @type_dex << entry
      end
    end
    return @type_dex
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

  def self.create_dex(dex_pool, pages, file, *type)
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
