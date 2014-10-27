require 'rails_helper'
require 'refinements/for_string'

RSpec.describe Refinements::ForString do
  class StringRefTest
    using Refinements::ForString

    def test(str)
      str.email?
    end
  end

  subject { StringRefTest.new }

  it { expect(subject.test('marco@mcorp.io')).to be true }
  it { expect(subject.test('bli bli bli')).to be false }
  it { expect(subject.test('umdois_12@algum.com.br')).to be true }
end