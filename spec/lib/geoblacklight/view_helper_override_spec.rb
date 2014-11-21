require 'spec_helper'

describe Geoblacklight::ViewHelperOverride do
  class GeoblacklightControllerTestClass
    attr_accessor :params
  end
  
  before(:each) do
    @fake_controller = GeoblacklightControllerTestClass.new
    @fake_controller.extend(Geoblacklight::ViewHelperOverride)
  end
  
  describe 'has_spatial_parameters?' do
    it 'should not have spatial parameters' do
      @fake_controller.params = {}
      expect(@fake_controller.has_spatial_parameters?).to be_falsey
    end
    it 'should have spatial parameters' do
      @fake_controller.params = { bbox: '123'}
      expect(@fake_controller.has_spatial_parameters?).to be_truthy
    end
  end
  describe 'render_search_to_s_bbox' do
    it 'returns an empty string for no bbox' do
      @fake_controller.params = {}
      expect(@fake_controller.render_search_to_s_bbox(@fake_controller.params)).to eq ''
    end
    it 'returns render_search_to_s_element when bbox is present' do
      @fake_controller.params = { bbox: '123'}
      params = { 'bbox' => '123' }
      expect(@fake_controller).to receive(:render_search_to_s_element)
      expect(@fake_controller).to receive(:render_filter_value)
      @fake_controller.render_search_to_s_bbox(params)
    end
  end
end
