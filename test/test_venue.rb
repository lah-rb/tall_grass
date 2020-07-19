require 'test_helper'
require 'fileutils'
require_relative '../dir_manager.rb'
require './backend/venue.rb'

class TestVenue < Minitest::Test
  prepend FileUtils

  def setup
    @director = DirManager.new
    @director.request_dir('backend')
    cp("./dex_store/events_dex", "./dex_store/original")
    @coordinator = Venue.new
  end

  def teardown
    cp("./dex_store/original", "./dex_store/events_dex")
    rm("./dex_store/original")
  end

  def test_for_completition
    assert @coordinator.complete_event(1)
    File.open("./dex_store/events_dex", "r") { |file| @first_line = file.gets.chomp }
    assert_equal '$', @first_line[-1]
  end

  def test_reset
    assert @coordinator.reset_all
    File.open("./dex_store/events_dex", "r") { |file| @first_line = file.gets.chomp }
    assert_equal '*', @first_line[-1]
  end
end
