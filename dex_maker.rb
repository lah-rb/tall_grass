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

  def self.type_select(dex_pool, type)
    if type.class == Array
      @method = type.shift if type[0] == false
      type.map!(&:capitalize)
      if @method == false
        dex_pool.reject {|dex| type.any?(dex[3]) || type.any?(dex[4])}
      else
        dex_pool.select {|dex| type.any?(dex[3]) || type.any?(dex[4])}
      end
    else
      return dex_pool
    end
  end

  def self.legend_select(dex_pool, legendary)
    if legendary
      dex_pool.select { |dex| dex[1][-1].match?(/["^"|!|#]/) }
    elsif legendary == false
      dex_pool.reject { |dex| dex[1][-1].match?(/["^"|!|#]/) }
    else
      return dex_pool
    end
  end

  def self.evo_select(dex_pool, evolution)
    if evolution
      dex_pool.select(&evolution)
    else
      return dex_pool
    end
  end

  # Where legendary is booleon, evolution is Proc, and types is an array
  def self.filter_dex(dex_raw, evolution=false, types=false, legendary=false)
    @filtered_dex = self.type_select(dex_raw, types)
    @filtered_dex = self.evo_select(@filtered_dex, evolution)
    @filtered_dex = self.legend_select(@filtered_dex, legendary)
    return @filtered_dex
  end

  def self.write_dex(refined_dex, file_name)
    File.open(file_name, 'w') do |new_dex|
      refined_dex.each do |entry|
        @line = ""
        (0...entry.size).each do
          @line += entry.shift + "-"
        end
        new_dex.puts("#{@line.chop}")
      end
    end
  end

  def self.teaming
    base = rand(1..100)
    case base
    when (1..40)
      return 7
    when (41..86)
      return 12 + rand(0..5) + rand(0..2)*5
    when (87..100)
      return 2 + rand(0..1)*20 + rand(0..2) * 10
    end
  end

  # Dex_pool is array, pages is integer, file is string, type is array
  def self.create_dex(dex_pool, file, specified, pages=self.teaming)
      @refined_dex = []
      self.limit_pool(dex_pool, pages)
      @refined_dex += specified
      self.write_dex(@refined_dex, file)
  end
end
