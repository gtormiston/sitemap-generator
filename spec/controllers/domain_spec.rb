require 'spec_helper'

describe Domain do

  subject { Domain.new("domain.com") }
  let(:valid_domain) {Domain.new("google.com")}

  context 'initialization' do
    it 'fails when no argument is passed in' do
      expect{Domain.new}.to raise_error(ArgumentError)
    end
    it 'fails on 2 arguments' do
      expect{Domain.new("domain.com","domain-two.com")}.to raise_error(ArgumentError)
    end
    it 'stores the url' do
      expect(subject.url).to eq("domain.com")
    end
  end

  context 'a valid domain' do
    it 'is a valid domain' do
      expect(valid_domain.valid?).to eq(true)
    end
    it 'returns a 200 status code' do
      google = Domain.new("google.com")
      expect(google.status).to eq(true)
    end
  end

  context 'an invalid domain' do
    it 'strips an http / https url to become valid' do
      full_url = Domain.new("http://www.google.com")
      expect(full_url.status).to eq(true)
    end
  end
  
end
