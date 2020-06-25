## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

guard :minitest do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }

  def file_watch
    [
    'dex.rb',
    'dex_maker_toolbox.rb',
    'discover_area.rb',
    'dex_craftsman.rb',
    'event_manager.rb',
    'pkmn_encounter.rb',
    'rediscover_area.rb'
    ]
  end
  @watch_arr = file_watch

  @watch_arr.each do |file|
    watch(file) do
      'test/test_' + file
    end
  end
end
