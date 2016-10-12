#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'

def sanitize_str s
  s.upcase.delete('^A-Z0-9')
end

def makegrid keyword
  (sanitize_str(keyword).chars + (('A'..'Z').to_a + ('0'..'9').to_a)).uniq.each_slice(6).to_a
end

def findchar grid, c
  grid.each_with_index { |row, i|
    j = row.find_index c
    return [i, j] if j
  }
  raise "Char '#{c}' not found in grid!"
end

def run_playfair mesg, key, decode
  grid = makegrid key

  puts "Grid:"
  puts grid.map { |row| row.join ' ' }.join("\n")

  mesg = sanitize_str mesg
  mesg += 'X' if mesg.size.odd?

  shift = decode ? -1 : 1

  mesg.chars.each_slice(2).map { |c1, c2|
    row1, col1 = findchar grid, c1
    row2, col2 = findchar grid, c2

    if row1 == row2
      # Both on the same row. Slide to the left if decode, to the right if encode.
      grid[row1][(col1 + shift) % 6] + grid[row2][(col2 + shift) % 6]
    elsif col1 == col2
      # Both on the same column. Slide upwards if decode, downwards if encode.
      grid[(row1 + shift) % 6][col1] + grid[(row2 + shift) % 6][col2]
    else
      # Otherwise, slide to other corners of the rectangle.
      grid[row1][col2] + grid[row2][col1]
    end
  }.join(' ')
end

def parse_cmdline
  params = OpenStruct.new(decode: true)

  optp = OptionParser.new

  optp.banner = "Usage: #{File.basename $PROGRAM_NAME} [options] message key"

  optp.on('-h', '-?', '--help', 'Show help message') {
    puts optp
    exit
  }

  optp.on('-d', '--decode', 'Decode message (default)') {
    params.decode = true
  }

  optp.on('-e', '--encode', 'Encode message') {
    params.decode = false
  }

  optp.parse!

  if ARGV.size < 2
    warn 'Error: message and/or key argument missing!'
    warn optp
    exit 1
  end

  params.message, params.key = ARGV
  params
end

params = parse_cmdline

newmessage = run_playfair params.message, params.key, params.decode

puts
puts "#{params.decode ? 'Decoded' : 'Encoded'} message: #{newmessage}"

__END__
