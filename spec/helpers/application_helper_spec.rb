# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  include FactoryBot::Syntax::Methods

  describe 'full title' do
    it 'returns the site title' do
      expect(helper.full_title).to eq('Hotseat: Data-driven course enrollment for UCLA')
    end

    it 'returns the page and site title if given a page title' do
      expect(helper.full_title('Log in')).to eq('Log in | Hotseat')
    end
  end

  describe 'get alert color' do
    it 'returns red for error or alert' do
      expect(helper.get_alert_color('error')).to eq(ColorHelper::Color::Red)
      expect(helper.get_alert_color('alert')).to eq(ColorHelper::Color::Red)
    end

    it 'returns blue by default' do
      expect(helper.get_alert_color('blah')).to eq(ColorHelper::Color::Blue)
    end
  end

  describe 'get alert symbol' do
    it 'returns an x circle for error or alert' do
      expect(helper.get_alert_symbol('error')).to eq('x-circle')
      expect(helper.get_alert_symbol('alert')).to eq('x-circle')
    end

    it 'returns an info circle by default' do
      expect(helper.get_alert_symbol('blah')).to eq('information-circle')
    end
  end
end
