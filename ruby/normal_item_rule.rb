class NormalItemRule
  MAXIMUM_QUALITY = 50
  MINIMUM_QUALITY = 0

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def apply
    set_quality
    ensure_quality_value_is_not_negative
    ensure_quality_value_is_below_51
    set_sell_in
  end

  private

  def ensure_quality_value_is_not_negative
    item.quality = MINIMUM_QUALITY if item.quality < MINIMUM_QUALITY
  end

  def ensure_quality_value_is_below_51
    item.quality = MAXIMUM_QUALITY if item.quality > MAXIMUM_QUALITY
  end

  def set_quality
    return unless above_minimum_quality?

    item.quality -= quality_multiplier
  end

  def quality_multiplier
    (item.sell_in <= 0) ? 2 : 1
  end

  def set_sell_in
    item.sell_in -= 1
  end
  
  def above_minimum_quality?
    item.quality > MINIMUM_QUALITY
  end

  def below_maximum_quality?
    item.quality < MAXIMUM_QUALITY
  end
end

class AgedBrieItemRule < NormalItemRule

  private

  def set_quality
    return unless below_maximum_quality?
    item.quality += quality_multiplier
  end
end

class BackStagePassItemRule < NormalItemRule

  private

  def set_quality
    sell_in = item.sell_in


    if sell_in < 0 && above_minimum_quality?
      item.quality = item.quality - item.quality
    else
      item.quality += quality_multiplier
    end
  end

  def quality_multiplier
    sell_in = item.sell_in

    return 0 unless below_maximum_quality?

    if sell_in <= 5
      3
    elsif sell_in <= 10
      2
    elsif sell_in > 10
      1
    end
  end
end

class SulfurasItemRule < NormalItemRule

  def apply
    set_quality
    set_sell_in
  end

  private

  def set_sell_in
  end

  def set_quality
  end
end

class ConjuredItemRule < NormalItemRule

  private

  def set_quality
    return unless above_minimum_quality?

    item.quality -= quality_multiplier
  end

  def quality_multiplier
    (item.sell_in <= 0) ? 4 : 2
  end
end




