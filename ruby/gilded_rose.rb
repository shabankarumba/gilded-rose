require File.join(File.dirname(__FILE__), 'normal_item_rule')

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        item_rule = AgedBrieItemRule.new(item)
        item_rule.apply
      when 'Sulfuras, Hand of Ragnaros'
        item_rule = SulfurasItemRule.new(item)
        item_rule.apply
      when 'Backstage passes to a TAFKAL80ETC concert'
        item_rule = BackStagePassItemRule.new(item)
        item_rule.apply
      when 'Conjured'
        item_rule = ConjuredItemRule.new(item)
        item_rule.apply
      else
        item_rule = NormalItemRule.new(item)
        item_rule.apply
      end
    end
  end

  def apply_rule_to_item(rule)
    rule.apply
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
