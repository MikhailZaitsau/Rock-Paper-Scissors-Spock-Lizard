class Game
  require './lib/player'
  require './lib/gesture'

  GESTURES = { rock: 'Камень', scissors: 'Ножницы', paper: 'Бумага', lizard: 'Ящерица', spock: 'Спок' }.freeze

  def initialize
    puts_rules
    @first_player = create_player
    greetings(@first_player.name)
    @second_player = create_player
    greetings(@second_player.name)
    round
  end

  private

  def puts_rules
    file = File.open('./lib/rules', 'r')
    rules = file.read
    file.close
    puts rules
  end

  def create_player
    order = @first_player ? 'Второй' : 'Первый'
    puts "#{order} игрок, введите своё имя:"
    player_name = gets.chomp
    Player.new(player_name)
  end

  def greetings(players_name)
    puts "Привет, #{players_name}!"
  end

  def round
    gesture_selection(@first_player)
    gesture_selection(@second_player)
    who_winner?
    again?
  end

  def gesture_selection(player)
    puts "#{player.name}, выберите фигуру и введите соответвтвующее ей число:"
    GESTURES.values.each_index { |index| puts "#{index + 1}) #{GESTURES.values[index]}" }
    gesture_number = gets.chomp
    check_selection(player, gesture_number)
  end

  def check_selection(player, gesture_number)
    return player.gesture = GESTURES.keys[gesture_number.to_i - 1].to_s if ('1'..'5').to_a.include?(gesture_number)

    wrong_enter
    gesture_selection(player)
  end

  def wrong_enter
    puts 'Неверный ввод!'
  end

  def who_winner?
    return draw if @first_player.gesture == @second_player.gesture

    return winner_congratulations(@first_player, @second_player) if Gesture.send @first_player.gesture, @second_player.gesture

    winner_congratulations(@second_player, @first_player)
  end

  def draw
    puts "Ничья! Оба игрока выбрали #{GESTURES[@first_player.gesture.to_sym]}"
  end

  def winner_congratulations(winner, loser)
    puts "#{GESTURES[winner.gesture.to_sym]} сильнее, чем #{GESTURES[loser.gesture.to_sym]}!"
    puts "Поздравляю, #{winner.name}, вы победили!"
  end

  def again?
    puts "Хотите сыграть ещё раз?\n1) Да\n2) Нет"
    case gets.chomp
    when '1'
      puts 'Отлично, давайте сыграем ещё раз!'
      round
    when '2'
      puts 'Очень жаль, до свидания!'
      exit
    else
      wrong_enter
      again?
    end
  end
end

Game.new