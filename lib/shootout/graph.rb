#!/bin/env ruby -wdK
# Given an array, print it as a bar graph
# Use FOR SPEED!!!
require 'benchmark'

class AsciiGraph
  WIDTH = 72
  STEPS = WIDTH/6

  def self.draw(sample, options={})
    new(sample, options).draw
  end

  def self.time(command)
    times = 200

    print "Collecting samples"
    sample = (1..times).map do |i|
      print '.'
      Benchmark.realtime{system(command)} * 1000
    end

    print "\n"
    draw(sample, :display => false)
  end


  def initialize(sample, options={})
    @values  = sample
    @height  = sample.size
    @max     = sample.max
    @options = {:display => true}.merge(options)
  end
  private :initialize

  def draw
    # initialize display with blanks
    display = @values.map { |value|
      line = value*((WIDTH - 6)/@max)
      str =  value.to_s[0,5] + ' ' + '#' * (line)
      color = @values.outlier?(value) ? :red : :none
      str = CLI.colorize(str, color)
      str
    }

    puts display if @options[:display]
    puts
    printf "The mean is %f\n", @values.without_outliers.average
    printf "The standard deviation is %f\n", @values.without_outliers.standard_deviation
  end
end

module CLI
  class << self
    COLORS = {
      :none     => "\033[0m",
      :red      => "\033[31m",
      :green_bg => "\033[42m",
      :red_bg   => "\033[41m",
      :white_bg => "\033[47m"
    }

    COLORS.each_key do|color|
      define_method color do |text|
        colorize(text, color)
      end
    end

    def colorize(text, color)
      "#{COLORS[color]}#{text}\033[0m"
    end
  end
end

module Enumerable
  def sum
    self.inject(0) { |acc, i| acc + i }
  end

  def average
    self.sum / self.length.to_f
  end

  def outlier?(item)
    item > self.max * 0.9 || item < self.max * 0.1
  end

  def without_outliers
    reject{|item| self.outlier?(item) }
  end

  def sample_variance
    avg = self.average
    sum = self.inject(0) { |acc, i| acc + (i - avg) ** 2 }
    (1 / self.length.to_f * sum)
  end

  def standard_deviation
    Math.sqrt(self.sample_variance)
  end
end

if __FILE__ == $PROGRAM_NAME
  require 'benchmark'

end
