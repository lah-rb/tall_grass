module DexMaker
  @refined_dex = []

  def self.create_dex(dex_pool, pages, file)

    def self.load_dex(dex_pool)
      @seed = rand(0..dex_pool.size - 1)
      @specimen = dex_pool[@seed]
      if @refined_dex.none?(@specimen)
        @refined_dex << @specimen
      else
        self.load_dex(dex_pool)
      end
    end

    def self.limit_pool(dex_pool, pages)
      (0...pages).each do
        self.load_dex(dex_pool)
      end
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

    self.limit_pool(dex_pool, pages)
    self.write_dex(@refined_dex, file)
  end
end
