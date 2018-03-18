require 'spec_helper'

describe Item do
  describe "#initialize" do
    it "should create a item with entered name and code" do
      name = 'rolex'
      code = 'ro1'
      item = Item.new(name, code)
      expect(item.name).to eq name
      expect(item.code).to eq code
    end
  end
end
