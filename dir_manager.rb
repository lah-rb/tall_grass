require 'fileutils'

class DirManager
  prepend FileUtils

  def initialize(needed_dir)
    @needed_dir = needed_dir
    check_dir
    change_to_needed_dir
  end

  def check_dir
    @current_dir = pwd.split('/').drop_while { |dir| dir != 'tall_grass'}[-1]
  end

  def matching_dir?
    @needed_dir == @current_dir
  end

  def change_to_needed_dir
    unless matching_dir?
      case @current_dir
      when 'tall_grass'
        cd(@needed_dir)
      else
        cd('..')
        cd(@needed_dir) unless @needed_dir == 'tall_grass'
      end
    end
  end
end
