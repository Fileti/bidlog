require 'rails_helper'

RSpec.describe BidPresenter, type: :view do
  fixtures(:bids, :users)

  let(:bid) { bids(:bid1) }

  subject { BidPresenter.new bid }

  it "#delegates" do
    expect(subject.id).to eq(bid.id)
    expect(subject.obs).to eq(bid.obs)
  end

  it '#link_to_edit' do
    link = subject.link_to_edit 'aaaaa'
    expect( !!(link =~ /<a[^>]+href=/) ).to be true
    expect( !!(link =~ /bids\/#{bid.id}\/edit/) ).to be true
    expect( !!(link =~ /aaaaa/) ).to be true
  end

  it '#link_to_edit with block' do
    link = subject.link_to_edit(class: 'some-class') do
      'tags entre a tag de a href'
    end

    expect( !!( link =~ /class="some-class"/ ) ).to be true
    expect( !!( link =~ />tags entre a tag de a href</)).to be true
  end

  it '#link_to_delete' do
    link = subject.link_to_delete(class: 'other-class') do
      'text of link'
    end

    expect( !!( link =~ /class="other-class"/ ) ).to be true
    expect( !!( link =~ />text of link</)).to be true
    expect( !!( link =~ // ))
  end
end