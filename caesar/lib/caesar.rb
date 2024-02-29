# frozen_string_literal: true

# shift a string by a certain offset
# caps stay caps, lower stay lower
# alphabet wraps--no symbols. Z, 1 => A
class Cipher
  CAPS = ('A'..'Z').to_a
  DOWN = ('a'..'z').to_a
  SHIFT_MOD = 26
  CAPS_OFFSET = -65
  DOWN_OFFSET = CAPS_OFFSET - 32

  def offset(char)
    char.bytes[0] + (CAPS.include?(char) ? CAPS_OFFSET : DOWN_OFFSET)
  end

  def shift(char, pos)
    CAPS.include?(char) ? CAPS[pos] : DOWN[pos]
  end

  def cipher(string, shift)
    string.split.map do |char|
      new_pos = offset(char) + shift
      new_pos %= SHIFT_MOD if new_pos >= SHIFT_MOD
      shift(char, new_pos)
    end.join
  end
end
