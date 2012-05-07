require 'spec_helper'

describe PulseMeter::Sensor::Timeline do
  include_context :dsl

  let(:name){ :sensor_name }
  let(:ttl){ 100 }
  let(:raw_data_ttl){ 10 }
  let(:interval){ 5 }
  let(:reduce_delay){ 3 }
  let(:good_init_values){ {:ttl => ttl, :raw_data_ttl => raw_data_ttl, :interval => interval, :reduce_delay => reduce_delay} }
  let(:sensor){ described_class.new(name, good_init_values) }

  it_should_behave_like "timeline sensor"

  describe '#new' do
    let(:bad_init_values){ [:q, -1, nil] }
    INIT_VALUE_NAMES = [:ttl, :raw_data_ttl, :interval, :reduce_delay]

    it "should initialize #ttl #raw_data_ttl #interval and #name attributes" do
      sensor.name.should == name.to_s

      sensor.ttl.should == ttl
      sensor.raw_data_ttl.should == raw_data_ttl
      sensor.interval.should == interval
    end

    INIT_VALUE_NAMES.each do |val_name|
      it "should raise exception if a bad value passed for #{val_name.inspect}" do
        bad_init_values.each do |val|
          expect{ described_class.new(name, good_init_values.merge(val_name => val)) }.to raise_exception(ArgumentError)
        end
      end
    end
  end
end
