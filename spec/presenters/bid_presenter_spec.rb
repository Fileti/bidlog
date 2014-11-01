require 'rails_helper'

RSpec.shared_examples 'a link helper' do
  it 'must be a link' do
    expect( !!(link =~ /<a[^>]+href=/) ).to be true
  end

  it 'must have a href' do
    expect( !!(link =~ /href="#{Regexp.escape(href)}"/) ).to be true
  end

  it 'must have a text' do
    expect( !!( link =~ />#{text}</)).to be true
  end

  it 'must pass extra check' do
    if extra
      expect( !!( link =~ extra) ).to be true
    else
      expect(true).to be true
    end
  end
end

RSpec.shared_examples 'a delete link helper' do
  it_behaves_like 'a link helper'

  it 'must have method delete' do
    expect( !!(link =~ /method="delete"/) ).to be true
  end
end

RSpec.describe BidPresenter, type: :view do
  fixtures(:bids, :users)

  let(:bid) { bids(:bid1) }

  subject { BidPresenter.new bid }

  it "#delegates" do
    expect(subject.id).to eq(bid.id)
    expect(subject.obs).to eq(bid.obs)
  end

  context '#edit' do
    let(:link) { subject.link_to_edit text, class: 'mimimi' }
    let(:href) { "/bids/#{bid.id}/edit" }
    let(:text) { 'aaaaa' }
    let(:extra) { /class="mimimi"/ }
    it_behaves_like 'a link helper'
  end

  context '#edit with block' do
    let(:link) do 
      subject.link_to_edit class: 'mimimi2' do 
        text
      end
    end
    let(:href) { "/bids/#{bid.id}/edit" }
    let(:text) { 'outro texto' }
    let(:extra) { /class="mimimi2"/ }
    it_behaves_like 'a link helper'
  end

  context '#delete' do
    let(:link) { subject.link_to_delete text, class: 'mimimi' }
    let(:href) { "/bids/#{bid.id}" }
    let(:text) { 'aaaaa' }
    let(:extra) { /class="mimimi"/ }
    it_behaves_like 'a delete link helper'
  end

  context '#delete with block' do
    let(:link) do 
      subject.link_to_delete class: 'mimimi3' do
        text
      end
    end
    let(:href) { "/bids/#{bid.id}" }
    let(:text) { 'texto' }
    let(:extra) { /class="mimimi3"/ }
    it_behaves_like 'a delete link helper'    
  end
end