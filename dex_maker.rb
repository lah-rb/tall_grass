module DexMaker
  $store = './dex_store/'
  @refined_dex = []

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
    if dex_pool.size > pages
      (0...pages).each { self.fill_dex(dex_pool) }
    else
      puts
      puts "There were not enough pokemon which meet requirements to fill a pokedex of that size."
      puts "The dex will be filled as much as possible"
      (0...dex_pool.size).each { self.fill_dex(dex_pool) }
    end

    return @refined_dex
  end

  def self.type_select(dex_pool, type)
    if type.class == Array
      type.map!(&:capitalize)
      @keep_types = type.take_while { |type| type != '|' }
      @remove_types = type.drop_while { |type| type != '|' }
      @remove_types.shift

      @type_digest = dex_pool.select do |dex|
        @keep_types.any?(dex[3]) || @keep_types.any?(dex[4])
      end

      @type_digest.reject! do |dex|
        @remove_types.any?(dex[3]) || @remove_types.any?(dex[4])
      end
      return @type_digest
    else
      return dex_pool
    end
  end

  def self.legend_select(dex_pool, legendary)
    dex_pool.select { |dex| dex[1][-1].match?(/["^"|!|#]/) }
  end

  def self.evo_select(dex_pool, evolution)
    if evolution
      dex_pool.select(&evolution)
    else
      return dex_pool
    end
  end

  def self.filter_dex(dex_raw, evolution, types, legendary)
    @type_dex = self.type_select(dex_raw, types)
    @evo_dex = self.evo_select(@type_dex, evolution)
    @legend_dex = self.legend_select(@type_dex, legendary)
    case legendary
    when 'only', 'o'
      return @legend_dex
    when 'yes', 'y'
      return @evo_dex << @legend_dex
    when 'no', 'n'
      return @evo_dex - @legend_dex
    else
      return @evo_dex
    end
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
      return 12 + rand(0..5) + rand(0..2) * 5
    when (87..100)
      return 2 + rand(0..1)*20 + rand(0..2) * 10
    end
  end

  # Dex_pool is array, pages is integer, file is string, type is array
  def self.create_dex(dex_pool, file, specified, size=self.teaming)
    @additional_pages = size - specified.size
    self.limit_pool(dex_pool, @additional_pages)
    @refined_dex += specified
    self.write_dex(@refined_dex, file)
  end
end
