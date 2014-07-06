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

  describe "#factor" do
    let!(:water_sample) { WaterSample.find(1) }

    specify { expect(water_sample.factor(1)).to eq(0.004992) } 
    specify { expect{ water_sample.factor(0) }.to raise_exception } 
  end

  describe "#to_hash" do
    let!(:water_sample) { WaterSample.find(1) }

    context "without factors" do
      let!(:hash) { water_sample.to_hash }

      specify { expect(hash[:id]).to                   eq(1) }
      specify { expect(hash[:site]).to                 eq('LA Aquaduct Filteration Plant Effluent') }
      specify { expect(hash[:chloroform]).to           eq(0.00104) }
      specify { expect(hash[:bromoform]).to            eq(0) }
      specify { expect(hash[:bromodichloromethane]).to eq(0.00149) }
      specify { expect(hash[:dibromichloromethane]).to eq(0.00275) }

      specify { expect(hash.keys).to eq([ :id, :site, :chloroform, :bromoform, :bromodichloromethane, :dibromichloromethane ]) }
    end

    context "with factors" do
      let!(:hash) { water_sample.to_hash(true) }

      specify { expect(hash.keys).to include(:factor_1, :factor_2, :factor_3, :factor_4) }
      specify { expect(hash[:factor_1]).to eq(0.004992) }
      specify { expect(hash[:factor_2]).to eq(0.00528) }
      specify { expect(hash[:factor_3]).to eq(0.004523) }
      specify { expect(hash[:factor_4]).to eq(0.0061649999999999995) }
    end
  end

  describe "#table_name" do
    specify { expect(WaterSample.send(:table_name)).to eq('water_samples') }
  end
end
