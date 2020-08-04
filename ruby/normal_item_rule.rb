class ItemRule
  def initialize(item)
    @item = item
  end

  def set_quality
    return unless item.quality < 50
    return unless item.quality > 0

    (item.sell_in <= 0) ? item.quality -= 2 : item.quality -= 1
  end

  def set_sell_in
    item.sell_in -= 1
  end

  attr_reader :item

  class AgedBrieItemRule < ItemRule
    def set_quality
      return unless item.quality < 50
      item.quality += 1
    end
  end

  class BackStagePassItemRule < ItemRule
    def set_quality
      sell_in = item.sell_in


      if sell_in < 0 && item.quality > 0
        item.quality = item.quality - item.quality
      else
        item.quality += 1 if item.quality < 50

        if sell_in < 11 && item.quality < 50
          item.quality += 1
        end

        if sell_in < 6 && item.quality < 50
          item.quality += 1
        end
      end
    end
  end

  class SulfurasItemRule < ItemRule
    def set_quality
    end
  end

  class ConjuredItemRule < ItemRule
    def set_quality
      return unless item.quality <= 50
      (item.sell_in <= 0) ? item.quality -= 4 : item.quality -= 2
    end
  end
end




