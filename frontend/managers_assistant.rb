require 'open-uri'
module ManagersAssistant
  def not_in_range?(string_or_num_string, array_for_range)
    int_convert = string_or_num_string.to_i
    smaller_than_arr = int_convert > array_for_range.size
    is_a_string_number = int_convert.to_s == string_or_num_string
    return (smaller_than_arr || !int_convert.positive?) && is_a_string_number
  end

  def random_seed(dex)
    unless dex.empty?
      begin
        @seed = URI.open("https://www.random.org/integers/?num=1&min=1&max=\
          #{dex.size}&col=1&base=10&format=plain&rnd=new").string.chomp.to_i - 1
      rescue
        @seed = rand(1..dex.size) - 1
      end
    end
  end
end
