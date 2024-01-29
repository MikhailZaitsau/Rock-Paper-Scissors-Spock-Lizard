module Gesture
  def self.rock(gesture)
    %w[scissors lizard].include?(gesture)
  end

  def self.paper(gesture)
    %w[rock spock].include?(gesture)
  end

  def self.scissors(gesture)
    %w[paper lizard].include?(gesture)
  end

  def self.spock(gesture)
    %w[scissors rock].include?(gesture)
  end

  def self.lizard(gesture)
    %w[paper spock].include?(gesture)
  end
end

