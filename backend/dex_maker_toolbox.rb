module DexMakerToolbox
  public
  # dex_pool: array, file: string, specified: array, size: intger
  def create_dex(dex_pool, file, specified, size=teaming)
    set_refine
    @additional_pages = size - specified.size
    @refined_dex += specified
    limit_pool(dex_pool, @additional_pages) unless @additional_pages == 0
    write_dex(@refined_dex, file)
  end
  module_function :create_dex

  def limit_pool(dex_pool, pages)
    if dex_pool.size > pages
      (0...pages).each { fill_dex(dex_pool) }
    else
      puts
      puts "There were not enough pokemon which meet requirements to fill a pokedex of that size."
      puts "The dex will be filled as much as possible"
      (0...dex_pool.size).each { fill_dex(dex_pool) }
    end

    return @refined_dex
  end
  module_function :limit_pool

  def filter_dex(dex_raw, evolution, types, distinct, priority)
    @only_dex = []
    @reject_dex = []
    @type_dex = type_select(dex_raw, types)
    @evo_dex = evo_select(@type_dex, evolution)
    @reject_dex = distinctions_select(@type_dex, distinct[2]) if distinct[2]
    @thinned_dex = @evo_dex - @reject_dex

    case distinct[0]
    when false
      case distinct[1]
      when false
        return @thinned_dex
      else
        case priority
        when 'd'
          @thinned_dex << distinctions_select(@type_dex, distinct[1])
        when 'e'
          @thinned_dex << evo_select(distinctions_select(@type_dex, distinct[1]), evolution)
        end
      end
    else
      case priority
      when 'd'
        return distinctions_select(@type_dex, distinct[0])
      when 'e'
        return evo_select(distinctions_select(@type_dex, distinct[0]), evolution)
      end
    end
  end
  module_function :filter_dex

  def type_select(dex_pool, type_arr)
    if type_arr.class == Array
      type_arr.map!(&:capitalize)
      @keep_types = type_arr.take_while { |type| type != '|' }
      @remove_types = type_arr.drop_while { |type| type != '|' }
      @remove_types.shift

      unless @keep_types.empty?
        @type_digest = dex_pool.select do |dex|
          @keep_types.any?(dex.prime_type) || @keep_types.any?(dex.second_type)
        end
      else
        @type_digest = dex_pool
      end

      @type_digest.reject! do |dex|
        @remove_types.any?(dex.prime_type) || @remove_types.any?(dex.second_type)
      end

      return @type_digest
    else
      return dex_pool
    end
  end
  module_function :type_select

  def evo_select(dex_pool, evolution)
    unless evolution.instance_variables.include?(:@no_exec)
      evolution.push_local_to_class
      dex_pool.select(&evolution.class)
    else
      return dex_pool
    end
  end
  module_function :evo_select

  def distinctions_select(dex_pool, regexp)
    dex_pool.select { |dex| dex.name[-1].match?(regexp) }
  end
  module_function :distinctions_select

  def write_dex(refined_dex, file_name)
    File.open(file_name, 'w') do |new_dex|
      refined_dex.each do |entry|
        @line = entry.to_a.join('-')
        new_dex.puts("#{@line}")
      end
    end
  end
  module_function :write_dex

  private

  def teaming
    base = rand(1..100)
    case base
    when (1..40)
      return 7
    when (41..86)
      return 12 + rand(0..8) + rand(0..2) * 5
    when (87..96)
      return rand(0..1)*10 + rand(0..1)*20 + rand(0..3) * 10
    when (97..100)
      return 1
    end
  end
  module_function :teaming

  def set_refine
    @refined_dex = Array.new
  end
  module_function :set_refine

  def fill_dex(dex_pool)
    @seed = rand(0...dex_pool.size)
    @specimen = dex_pool[@seed]
    begin
      @refined_dex.none?(@specimen) ? @refined_dex << @specimen : fill_dex(dex_pool)
    rescue(NoMethodError)
      set_refine
      fill_dex(dex_pool)
    end
  end
  module_function :fill_dex
end
