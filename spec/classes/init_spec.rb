require 'spec_helper'
describe 'cms' do

  context 'with defaults for all parameters' do
    it { should contain_class('cms') }
  end
end
