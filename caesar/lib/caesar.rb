def caesar_cipher(string, shift)
  caps = ('A'..'Z').to_a
  down = ('a'..'z').to_a
  shift %= 26
  caesar = string.split('').map do |char|
    if caps.include?(char)
      char_position = (char.bytes[0] - 65)
      shifted_position = char_position + shift
      if shifted_position > 25
        shifted_position %= 26
      end
      char = caps[shifted_position]
    elsif down.include?(char)
      char_position = (char.bytes[0] - 97)
      shifted_position = char_position + shift
      if shifted_position > 25
        shifted_position %= 26
      end
      char = down[shifted_position]
    else
      char
    end
  end
  caesar.join
end

puts caesar_cipher("What a string!", 5)
