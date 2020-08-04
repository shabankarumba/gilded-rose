require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'item_rule')

describe ItemRule do
  let(:item_name) { 'Normal Item' }
  let(:quality) { 0 }
  let(:sell_in) { 0 }
  let(:item) { Item.new(item_name, sell_in, quality) }
  subject(:rule) { described_class.new(item) }

  describe '#set_quality' do
    context 'when the quality is 0' do
      let(:quality) { 0 }

      it 'does not change the quality' do
        rule.set_quality
        expect(item.quality).to eq 0
      end
    end

    context 'when the quality is 50' do
      let(:quality) { 50 }

      it 'does not change the quality' do
        rule.set_quality
        expect(item.quality).to eq 50
      end
    end

    context 'when the sell is less than or equal to 0' do
      let(:sell_in) { -1 }
      let(:quality) { 10 }

      it 'reduces the quality twice as much' do
        rule.set_quality
        expect(item.quality).to eq 8
      end
    end

    context 'when the sell is more than 0' do
      let(:sell_in) { 1 }
      let(:quality) { 10 }

      it 'does not change the quality' do
        rule.set_quality
        expect(item.quality).to eq 9
      end
    end
  end

  describe '#set_sell_in' do
    it 'changes the sell in value' do
      rule.set_sell_in
      expect(item.sell_in).to eq(-1)
    end
  end

  describe ItemRule::AgedBrieItemRule do
    describe '#set_quality' do
      let(:quality) { 1 }
      let(:rule) { ItemRule::AgedBrieItemRule.new(item) }

      it 'increases the quality by 1' do
        rule.set_quality
        expect(item.quality).to eq(2)
      end
    end
  end

  describe ItemRule::BackStagePassItemRule do
    let(:quality) { 5 }
    let(:item_name) { 'Backstage passes' }
    subject(:rule) { ItemRule::BackStagePassItemRule.new(item) }

    context 'when the concert is less than 10 days away' do
      let(:sell_in) { 10 }

      it 'increases the the quality by 2' do
        rule.set_quality
        expect(item.quality).to eq(7)
      end
    end

    context 'when the concert is less than 10 days away' do
      let(:sell_in) { 5 }

      it 'increases the the quality by 3' do
        rule.set_quality
        expect(item.quality).to eq(8)
      end
    end

    context 'when the concert is less than 10 days away' do
      let(:sell_in) { -1 }

      it 'increases the the quality by 3' do
        rule.set_quality
        expect(item.quality).to eq(0)
      end
    end
  end

  describe ItemRule::SulfurasItemRule do
    let(:quality) { 80 }
    let(:item_name) { 'Backstage passes' }
    subject(:rule) { described_class.new(item) }

    describe '#set_quality' do
      it 'does not change the quality' do
        rule.set_quality
        expect(item.quality).to eq 80
      end
    end

    describe '#sell_in' do
      it 'does not change the quality' do
        rule.set_quality
        expect(item.sell_in).to eq 0
      end
    end
  end

  describe ItemRule::ConjuredItemRule do
    let(:quality) { 50 }
    let(:item_name) { 'Conjured' }
    subject(:rule) { described_class.new(item) }

    context 'when the sell in has passed' do
      let(:sell_in) { 0 }

      it 'quality degrades twice as fast' do
        rule.set_quality
        expect(item.quality).to eq 46
      end
    end

    context 'when the sell in has passed' do
      let(:sell_in) { 1 }

      it 'quality degrades twice as fast' do
        rule.set_quality
        expect(item.quality).to eq 48
      end
    end
  end
end

# Prevent quality going to less than 0
# Add tests for GildedRose
# Refactor