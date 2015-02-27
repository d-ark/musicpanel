module HomeHelper
  SORTED_COLORS = [:red, :orange, :yellow, :green, :blue, :purple, :white, :grey, :black]

  def sort_colors x
    if x.is_a? Array
      x.sort_by {|x| SORTED_COLORS.find_index x.to_sym }
    else
      puts x.keys
      [:top_1, :top_0, :top_1_value, :top_0_value].each do |key|
        x.delete key
        x.delete key.to_s
      end
      x.sort_by {|x| SORTED_COLORS.find_index x[0].to_sym }
    end
  end
end
