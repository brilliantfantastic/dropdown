module Dropdown
  class Inflector
    def initialize(word)
      @word = word
    end

    def constant_name
      @word.to_s.split('_').map! { |word| word.capitalize }.join
    end
  end
end
