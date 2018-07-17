module WKTParser
  class Transformer < Parslet::Transform
    rule(:type    => simple(:type))            { type.to_s }
    rule(:lnumber => simple(:lnumber) { lnumber.match(/[eE\.]/) ? Float(lnumber) : Integer(lnumber)},
         :rnumber => simple(:rnumber){ rnumber.match(/[eE\.]/) ? Float(rnumber) : Integer(rnumber)}) { [lnumber, rnumber] }

    rule(:union   => subtree(:u)) do
      if u.count == 1 then
        u[0]
      else
        u
      end
    end
  end
end
