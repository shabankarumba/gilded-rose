class NormalItemRule
  MAX_QUALITY = 50
  
  def initialize(item)
    @item = item
  end

  def apply
    set_quality
    set_sell_in
  end

  private

  def set_quality
    return unless item.quality < MAX_QUALITY
    return unless item.quality > 0

    (item.sell_in <= 0) ? item.quality -= 2 : item.quality -= 1
  end

  def set_sell_in
    item.sell_in -= 1
  end

  attr_reader :item

  class AgedBrieItemRule < NormalItemRule
    private

    def set_quality
      return unless item.quality < MAX_QUALITY
      (item.sell_in <= 0) ? item.quality += 2 : item.quality += 1
    end
  end

  class BackStagePassItemRule < NormalItemRule

    private

    def set_quality
      sell_in = item.sell_in


      if sell_in < 0 && item.quality > 0
        item.quality = item.quality - item.quality
      else
        item.quality += 1 if item.quality < MAX_QUALITY

        if sell_in < 11 && item.quality < MAX_QUALITY
          item.quality += 1
        end

        if sell_in < 6 && item.quality < MAX_QUALITY
          item.quality += 1
        end
      end
    end
  end

  class SulfurasItemRule < NormalItemRule

    private

    def set_sell_in
    end

    def set_quality
    end
  end

  class ConjuredItemRule < NormalItemRule

    private

    def set_quality
      return unless item.quality <= MAX_QUALITY
      (item.sell_in <= 0) ? item.quality -= 4 : item.quality -= 2
    end
  end
end




