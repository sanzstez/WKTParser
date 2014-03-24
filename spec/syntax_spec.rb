require 'spec_helper'
describe WKTParser do
  before :each do
    @wkt = WKTParser
  end

  describe "supports all the basic operations" do
    it "supports Point type" do
      expect(@wkt::parse("POINT (30 10)")).to eq({
        type: 'POINT',
        geo:  [[30, 10]]
      })
    end

    it "supports LineString type" do
      expect(@wkt::parse("LINESTRING (30 10, 10 30, 40 40)")).to eq({
        type: 'LINESTRING',
        geo:  [[30, 10], [10, 30], [40, 40]]
      })
    end

    describe "supports Polygon type" do
      it "simple ones" do
        expect(@wkt::parse("POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))")).to eq({
          type: 'POLYGON',
          geo:  [[[30, 10], [40, 40], [20, 40], [10, 20], [30, 10]]]
        })
      end

      it "complex ones" do
        expect(@wkt::parse("POLYGON ((35 10, 45 45, 15 40, 10 20, 35 10), (20 30, 35 35, 30 20, 20 30))")).to eq({
          type: 'POLYGON',
          geo:  [[[35, 10], [45, 45], [15, 40], [10, 20], [35, 10]], [[20, 30], [35, 35], [30, 20], [20, 30]]]
        })
      end
    end
  end
end