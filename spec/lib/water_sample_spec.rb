require 'spec_helper'

describe WaterSample do
  describe "#find" do
    context "id exists" do
      let(:water_sample) { WaterSample.find(1) }

      specify { expect(water_sample).to be_instance_of(WaterSample) }
      specify { expect(water_sample.site).to                 eq('LA Aquaduct Filteration Plant Effluent') }
      specify { expect(water_sample.chloroform).to           eq(0.00104) }
      specify { expect(water_sample.bromoform).to            eq(0) }
      specify { expect(water_sample.bromodichloromethane).to eq(0.00149) }
      specify { expect(water_sample.dibromichloromethane).to eq(0.00275) }
    end

    context "id does not exist" do
      specify { expect { WaterSample.find(0) }.to raise_exception }
    end
  end

  describe "#all" do
    let(:water_samples) { WaterSample.all }

    specify { expect(water_samples.count).to eq(4) }
    specify { expect(water_samples.map(&:site).sort).to eq(['Jensen Plant Effluent', 'LA Aquaduct Filteration Plant Effluent', 'North Hollywood Pump Station (well blend)', 'Weymouth Plant Effluent']) }
  end
end
