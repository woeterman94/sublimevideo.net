# coding: utf-8
require 'spec_helper'

feature 'Legacy redirects' do
  %w[why horizon-video horizon-framework].each do |page|
    scenario "/#{page} redirects to /framework" do
      visit "/#{page}"
      current_url.should eq "http://sublimevideo.dev/framework"
    end
  end

  %w[plans pricing modular-player].each do |page|
    scenario "/#{page} redirects to /features" do
      visit "/#{page}"
      current_url.should eq "http://sublimevideo.dev/features"
    end
  end

  scenario '/customer-showcase redirects to /testimonials' do
    visit '/customer-showcase'
    current_url.should eq "http://sublimevideo.dev/testimonials"
  end

  scenario '/tailor-made-players redirects to /' do
    visit '/tailor-made-players'
    current_url.should eq "http://sublimevideo.dev/"
  end

  %w[demo youtube].each do |page|
    scenario "/#{page} redirects to classic demo" do
      visit "/#{page}"
      current_url.should eq "http://sublimevideo.dev/demos/player-designs/classic"
    end
  end

  %w[sony twit blackhandcinema next15 html5].each do |showcase|
    scenario "/tailor-made-players/#{showcase} redirects to root" do
      visit "/tailor-made-players/#{showcase}"
      current_url.should eq "http://sublimevideo.dev/"
    end
  end
end
