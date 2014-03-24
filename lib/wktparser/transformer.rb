module WKTParser
  class Transformer < Parslet::Transform
    rule(:type    => simple(:type))            { type.to_s }
    rule(:lnumber => simple(:lnumber),
         :rnumber => simple(:rnumber))         { [lnumber.to_i, rnumber.to_i] }

    rule(:union   => subtree(:u)) do
      if u.count == 1 then
        u[0]
      else
        u
      end
    end
  end
end