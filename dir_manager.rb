require 'fileutils'

class DirManager
  prepend FileUtils

  def request_dir(needed_dir)
    @needed_dir = needed_dir
    check_dir
    change_to_needed_dir
  end

  private

  def check_dir
    @current_dir = pwd.split('/').drop_while { |dir| dir != 'tall_grass'}[-1]
  end

  def matching_dir?
    @needed_dir == @current_dir
  end

  def climb_to_top
    until check_dir == 'tall_grass'
      cd('..')
    end
  end

  def change_to_needed_dir
    unless matching_dir?
      if @current_dir == 'tall_grass'
        cd(@needed_dir)
      else
        climb_to_top
        cd(@needed_dir) unless @needed_dir == 'tall_grass'
      end
    end
  end

end
