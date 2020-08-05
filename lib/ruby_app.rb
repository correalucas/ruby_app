# frozen_string_literal: true

# !/usr/bin/env ruby

require_relative './main'

main = Main.new(ARGV[0])
main.execute
