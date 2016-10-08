require 'spec_helper'

describe AwesomeO do
  describe AwesomeO::ItemCollection do
    let(:cart) { AwesomeO::Cart.new(1) }

    before(:each) do
      AwesomeO.config.redis.flushdb
      Object.send(:remove_const, :Bottle) if defined?(Bottle)
      Bottle = double
      allow(Bottle).to receive(:find).and_return(bottle)
    end

    describe '#each_with_object' do
      let(:bottle) { double('Bottle') }

      it 'should be magical' do
        cart.add_item(id: 17, type: 'Bottle', name: 'Bordeux', unit_cost: 92.12, cost: 184.24, quantity: 2)
        expect { |b| cart.items.each_with_object(&b) }.to yield_successive_args([cart.items.first, bottle])
      end

      it "should work with items('Type')" do
        cart.add_item(id: 17, type: 'Bottle', name: 'Bordeux', unit_cost: 92.12, cost: 184.24, quantity: 2)
        cart.add_item(id: 27, type: 'UserGiftCard', unit_cost: 25, quantity: 1)
        expect { cart.items('Bottle').each_with_object {} }.not_to raise_error
      end
    end
  end
end
