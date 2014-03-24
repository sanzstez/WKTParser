require 'rubygems'
require 'parslet'


Dir["lib/wktparser/*.rb"].each {|f| require File.realpath(File.new(f))}


module WKTParser
  def self.parse(wkt)
    begin
      WKTParser::Transformer.new.apply(WKTParser::Parser.new.parse(wkt))
    rescue Parslet::ParseFailed => e
      raise Parslet::ParseFailed, e.cause.ascii_tree
    end
  end
end