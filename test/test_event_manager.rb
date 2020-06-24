require 'test_helper'
require 'fileutils'
require_relative '../event_manager.rb'

class TestEventsManager < Minitest::Test
  def setup
    FileUtils.cp("./dex_store/events_dex", "./dex_store/original")
    @coordinator = EventManager.new
  end

  def teardown
    FileUtils.cp("./dex_store/original", "./dex_store/events_dex")
    FileUtils.rm("./dex_store/original")
  end

  def test_for_completition
    assert @coordinator.complete_event(1)
    File.open("./dex_store/events_dex", "r") { |file| @first_line = file.gets.chomp }
    assert_equal '$', @first_line[-1]
  end

  def test_reset
    assert @coordinator.reset_all
    File.open("./dex_store/events_dex", "r") { |file| @first_line = file.gets.chomp }
    p @first_line
    assert_equal '*', @first_line[-1]
  end
end
