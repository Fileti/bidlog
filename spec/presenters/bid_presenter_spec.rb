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

#  it '#link_to_edit' do
#    link = subject.link_to_edit 'aaaaa'
#    
#    
#    expect( !!(link =~ /aaaaa/) ).to be true
#  end
#
#  it '#link_to_edit with block' do
#    link = subject.link_to_edit(class: 'some-class') do
#      'tags entre a tag de a href'
#    end
#
#    expect( !!(link =~ /<a[^>]+href=/) ).to be true
#    expect( !!( link =~ /class="some-class"/ ) ).to be true
#    
#  end
#
#  it '#link_to_delete with block' do
#    link = subject.link_to_delete class: 'other-class' do 
#      'aaaa'
#    end
#    expect( !!( link =~ /<a[^>]+href=/)).to be true
#    expect( !!( link =~ /class="other-class"/ ) ).to be true
#    expect( !!( link =~ />aaaa</)).to be true
#    expect( !!( link =~ /method="delete"/ )).to be true
#    expect( !!(link =~ /bids\/#{bid.id}/) ).to be true
#  end

#  it '#link_to_delete' do
#    link = subject.link_to_delete 'aaaa', class: 'other-class'
#    expect( !!(link =~ /<a[^>]+href=/)).to be true
#    expect( !!(link =~ /class="other-class"/ ) ).to be true
#    expect( !!(link =~ />aaaa</)).to be true
#    expect( !!(link =~ /method="delete"/ )).to be true
#    expect( !!(link =~ /bids\/#{bid.id}/) ).to be true    
#  end
end