require 'rubygems'
require 'parslet'

require_relative "wktparser/parser"
require_relative "wktparser/transformer"

module WKTParser
  def self.parse(wkt)
    begin
      WKTParser::Transformer.new.apply(WKTParser::Parser.new.parse(wkt))
    rescue Parslet::ParseFailed => e
      raise Parslet::ParseFailed, e.cause.ascii_tree
    end
  end
end
