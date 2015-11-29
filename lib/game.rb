class Game
  
  DICTIONARY_FILE = "5desk.txt"
  CHANCES = 10

  def self.savefile
    "savefile.yaml"
  end

  def initialize
    @secret_word = nil
    @guessed_letters = []
    @guesses = []
    @lives_left = 0
  end

  def start
    select_word
    prepare_game
    play
  end

  def play
    until game_over?
      obtain_guess
    end
    end_game_message
  end

  private

    def select_word
      random_word = ''
      until is_valid?(random_word)
        random_word = dictionary_words.sample.strip
        # puts "candiadte: #{random_word}"
      end
      @secret_word = random_word
    end

    def prepare_game
      @guessed_letters = ['_'] * @secret_word.length
      @lives_left = CHANCES
    end

    def is_valid?(word)
      return false if /[A-Z]/ =~ word
      word.length.between?(5,12)
    end

    def dictionary_words
      File.readlines(DICTIONARY_FILE)
    end

    def game_over?
      !lives_left? || word_guessed?
    end

    def lives_left?
      @lives_left > 0
    end

    def word_guessed?
      @guessed_letters.join('') == @secret_word
    end

    def obtain_guess
      puts ''
      puts "You have #{@lives_left} lives left."
      puts "Type 'SAVE' to save the game"
      puts "Guesses you have tried: #{@guesses.join(' ')}"
      provide_feedback
      puts "Please guess a character (only the first character will be read):"
      input = gets.chomp
      if input.downcase == 'save'
        save_game
      else
        process_guess(input[0])
      end
    end

    def process_guess(character)
      raise ArgumentError "more than 1 character supplied" if character.length != 1
      @guesses << character.downcase
      good_guess = false
      @secret_word.split('').each_with_index do |secret_character, index|
        if character.downcase == secret_character.downcase
          @guessed_letters[index] = character.downcase
          good_guess = true
        end
      end
      @lives_left -= 1 unless good_guess
    end

    def provide_feedback
      puts @guessed_letters.join(' ')
    end

    def end_game_message
      if word_guessed?
        puts "Congratulations! You have guessed the word - #{@secret_word}!"
      else
        puts "Sorry, you have run out of chances!"
        puts "The secret word was '#{@secret_word}'"
      end
    end

    def save_game
      File.open(Game.savefile, "w") do |file|
        file.write(YAML.dump(self))
      end
      puts "\nGame saved!\n"
    end
end