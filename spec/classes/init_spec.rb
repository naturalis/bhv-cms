require 'spec_helper'
describe 'bhv_cms' do

  context 'with defaults for all parameters' do
    it { should contain_class('bhv_cms') }
  end
end
