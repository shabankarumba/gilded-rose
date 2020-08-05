require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:items) do
    [
      Item.new('Aged Brie', 0, 1),
      Item.new('Sulfuras, Hand of Ragnaros', 0, 80),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 1, 40),
      Item.new('Conjured', 1, 40)
    ]
  end
  subject { described_class.new(items) }

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("fixme", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "fixme"
    end

    it 'updates the items quality and sell in values' do
      subject.update_quality
      updated_items = items.map do |item|
        item.to_s
      end

      expect(updated_items).to eq([
                                    "Aged Brie, -1, 3",
                                    "Sulfuras, Hand of Ragnaros, 0, 80",
                                    "Backstage passes to a TAFKAL80ETC concert, 0, 43",
                                    "Conjured, 0, 38",
                                  ])
    end
  end
end
