module DexMaker
  @que = []

  def self.create_dex(dex_pool, pages)

    def self.load_dex(dex_pool)
      @seed = rand(0..dex_pool.size - 1)
      @specimen = dex_pool[@seed]
      if @que.none?(@specimen)
        @que << @specimen
      else
        self.load_dex(dex_pool)
      end
    end

    def self.limit_pool(dex_pool, pages)
      (0...pages).each do |i|
        self.load_dex(dex_pool)
      end
    end
    self.limit_pool(dex_pool, pages)
    return @que
  end

end
