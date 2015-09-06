#!/usr/bin/env ruby
require 'pp'
require 'yaml'

def llw(line)
  def lw(line); (0..line.length-1).map { |l| line.slice(0..l) } end
  (0..line.length-1)
      .map { |l| lw(line.slice(l..line.length)) }
      .flatten
      .uniq
      .sort
end

def all_left_to_right_words(g)
  g.map { |l| llw(l) }
   .flatten
end

def transpose_grid(g)
  def cword(g, i); g.map {|l| l[i]}.join; end
  (0...g[0].length).map { |c| cword(g, c) }
end

def expanded_grid(grid)
  rg = grid.map {|l| l.reverse }
  tg = transpose_grid(grid)
  rtg = tg.map {|l| l.reverse }
  grid + rg + tg + rtg
end

if ARGV.length < 2
  puts 'Usage: xwords GRID_YAML SEARCH_YAML'
  exit 0
end

grid = YAML.load_file(ARGV[0])
things = YAML.load_file(ARGV[1])
words = all_left_to_right_words(expanded_grid(grid))

pp words & things
