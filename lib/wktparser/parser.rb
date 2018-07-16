module WKTParser
  class Parser < Parslet::Parser
      def stri(str)
        key_chars = str.split(//)
        key_chars.collect! { |char| match["#{char.upcase}#{char.downcase}"] }.reduce(:>>)
      end

      rule(:space)          { match('\s+').repeat       }
      rule(:space?)         { space.maybe }
      rule(:comma)          { str(",")    }
      rule(:lparen)         { str("(")    }
      rule(:rparen)         { str(")")    }
      rule(:number)         { match('[0-9]')  }
      rule(:operator)       { stri("POINT") | stri("LINESTRING") | stri("POLYGON") }

      # Blocks
      rule(:operand)        { operator.as(:type) >> space }
      rule(:number_pair)    { number.repeat(1).as(:lnumber) >> space >> number.repeat(1).as(:rnumber) }
      rule(:concatenation)  { (number_pair >> comma >> space) | number_pair }
      rule(:array)          { lparen >> concatenation.repeat >> rparen }
      rule(:union)          { (lparen | (comma >> space)) >> array.repeat.as(:union) >> rparen.maybe}

      rule(:operations)     { (union.repeat | array.repeat).as(:geo) }
      rule(:query)          { operand >> operations }


=begin
      POLYGON ((35 10, 45 45, 15 40, 10 20, 35 10), (20 30, 35 35, 30 20, 20 30))


      rule(:simple)         { lparen >> numbers.as(:lnumber) >> space >> numbers.as(:rnumber) >> rparen }
      rule(:complex)        { space? >> lparen.maybe >> numbers.as(:lnumber) >> space >> numbers.as(:rnumber) >> (rparen | comma) }
      rule(:multi)          { space? >> lparen >> complex.repeat >> rparen }
      rule(:nested)         { lparen >> (multi >> comma.maybe).repeat.as(:union) >> rparen }
      rule(:query)          { operator.as(:type) >> space >> (simple | complex.repeat | multi | nested).as(:geo)}
=end


      root :query
  end
end
