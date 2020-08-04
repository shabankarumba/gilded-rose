require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'normal_item_rule')

describe NormalItemRule do
  let(:item_name) { 'Normal Item' }
  let(:quality) { 0 }
  let(:sell_in) { 0 }
  let(:item) { Item.new(item_name, sell_in, quality) }
  subject(:rule) { described_class.new(item) }

  describe '#apply' do
    context 'when the quality is 0' do
      let(:quality) { 0 }

      it 'does not change the quality' do
        rule.apply
        expect(item.quality).to eq 0
      end
    end

    context 'when the quality is 50' do
      let(:quality) { 50 }

      it 'does not change the quality' do
        rule.apply
        expect(item.quality).to eq 50
      end
    end

    context 'when the sell is less than or equal to 0' do
      let(:sell_in) { -1 }
      let(:quality) { 10 }

      it 'reduces the quality twice as much' do
        rule.apply
        expect(item.quality).to eq 8
      end
    end

    context 'when the sell is more than 0' do
      let(:sell_in) { 1 }
      let(:quality) { 10 }

      it 'does not change the quality' do
        rule.apply
        expect(item.quality).to eq 9
      end
    end

    it 'changes the sell in value' do
      rule.apply
      expect(item.sell_in).to eq(-1)
    end
  end

  describe NormalItemRule::AgedBrieItemRule do
    describe '#apply' do
      let(:quality) { 1 }
      let(:rule) { NormalItemRule::AgedBrieItemRule.new(item) }

      it 'increases the quality by 1' do
        rule.apply
        expect(item.quality).to eq(3)
      end
    end
  end

  describe NormalItemRule::BackStagePassItemRule do
    let(:quality) { 5 }
    let(:item_name) { 'Backstage passes' }
    subject(:rule) { NormalItemRule::BackStagePassItemRule.new(item) }

    describe '#appyly' do
      context 'when the concert is less than 10 days away' do
        let(:sell_in) { 10 }

        it 'increases the the quality by 2' do
          rule.apply
          expect(item.quality).to eq(7)
        end
      end

      context 'when the concert is less than 10 days away' do
        let(:sell_in) { 5 }

        it 'increases the the quality by 3' do
          rule.apply
          expect(item.quality).to eq(8)
        end
      end

      context 'when the concert is less than 10 days away' do
        let(:sell_in) { -1 }

        it 'increases the the quality by 3' do
          rule.apply
          expect(item.quality).to eq(0)
        end
      end
    end
  end

  describe NormalItemRule::SulfurasItemRule do
    let(:quality) { 80 }
    let(:item_name) { 'Backstage passes' }
    subject(:rule) { described_class.new(item) }

    describe '#apply' do
      it 'does not change the quality' do
        rule.apply
        expect(item.quality).to eq 80
      end

      it 'does not change the quality' do
        rule.apply
        expect(item.sell_in).to eq 0
      end
    end
  end

  describe NormalItemRule::ConjuredItemRule do
    let(:quality) { 50 }
    let(:item_name) { 'Conjured' }
    subject(:rule) { described_class.new(item) }

    describe '#apply' do
      context 'when the sell in has passed' do
        let(:sell_in) { 0 }

        it 'quality degrades twice as fast' do
          rule.apply
          expect(item.quality).to eq 46
        end
      end

      context 'when the sell in has passed' do
        let(:sell_in) { 1 }

        it 'quality degrades twice as fast' do
          rule.apply
          expect(item.quality).to eq 48
        end
      end
    end
  end
end

# Prevent quality going to less than 0
# Refactor