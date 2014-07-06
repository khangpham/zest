require 'spec_helper'

describe FactorWeight do
  describe "#find" do
    context "id exists" do
      let(:factor_weight) { FactorWeight.find(1) }

      specify { expect(factor_weight).to be_instance_of(FactorWeight) }
      specify { expect(factor_weight.chloroform_weight).to           eq(0.8) }
      specify { expect(factor_weight.bromoform_weight).to            eq(1.2) }
      specify { expect(factor_weight.bromodichloromethane_weight).to eq(1.5) }
      specify { expect(factor_weight.dibromichloromethane_weight).to eq(0.7) }
    end

    context "id does not exist" do
      specify { expect { FactorWeight.find(0) }.to raise_exception }
    end
  end

  describe "#all" do
    let(:factor_weights) { FactorWeight.all }

    specify { expect(factor_weights.count).to eq(4) }
    specify { expect(factor_weights.map(&:chloroform_weight).sort).to eq([0, 0.8, 0.9, 1]) }
  end

  describe "#table_name" do
    specify { expect(FactorWeight.send(:table_name)).to eq('factor_weights') }
  end
end
