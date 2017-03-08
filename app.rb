require "sinatra"


class Numeric
  Alpha26 = ("a".."z").to_a
  def to_s26
    return "" if self < 1
    s, q = "", self
    loop do
      q, r = (q - 1).divmod(26)
      s.prepend(Alpha26[r])
      break if q.zero?
    end
  s
  end
end


class String
  Alpha26 = ("a".."z").to_a

  def to_i26
    result = 0
    downcase!
    (1..length).each do |i|
      char = self[-i]
      result += 26**(i-1) * (Alpha26.index(char) + 1)
    end
    result
  end

end





def convert_to_cipher(text, keycode)

    if keycode > 26
      key = keycode % 26
    else
      key = keycode
    end

    ciphered = text.split("").map do |char|
      if char =~ /\W/
        char = char
      elsif char === char.upcase then
        char = ((char.to_i26) + key).to_s26.upcase
      else
        char = ((char.to_i26) + key).to_s26
      end
    end
    ciphered.join
end

get '/' do
  to_cipher = params['to_cipher'].to_s
  cipher_key = params['cipher_key'].to_i
  ciphered_result = convert_to_cipher(to_cipher, cipher_key)
  erb :index, :locals => {:ciphered_result => ciphered_result}

end



#puts "Enter a phrase you would like ciphered"
#words_to_convert = gets.to_s.chomp
#puts "and now enter your keycode"
#cipher_key_code = gets.chomp.to_i
#if cipher_key_code < 0
  #puts "enter something greater than zero!"
  #cipher_key_code = gets.chomp.to_i
#end
#
#ciphered_phrase = convert_to_cipher(words_to_convert, cipher_key_code)
#
#puts "Your Caesar's Cipher is: #{ciphered_phrase}"
