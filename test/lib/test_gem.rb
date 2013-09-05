require_relative '../test_helper'

describe GemCheck::Gem do

  before do
    VCR.insert_cassette 'gem_check'
  end

  after do
    VCR.eject_cassette
  end

  subject { GemCheck::Gem.new(Faker::Lorem.word, "0.0.1") }

  it "must have a local version" do
    subject.must_respond_to :local_version
  end

  it "must have a remote version" do
    subject.must_respond_to :remote_version
  end

  it "should list local gems" do
    GemCheck::Gem.list.must_be_instance_of Array
  end

  it "should list local gems" do
    GemCheck::Gem.list.first.must_be_instance_of GemCheck::Gem
  end

  describe "remote check" do

    it "must be able to get remote version" do
      subject.must_respond_to :get_remote_version
    end

    it "must be able to respond to outdated" do
      subject.must_respond_to :outdated?
    end

    it "should display a list of out of date gems" do
      GemCheck::Gem.outdated.must_be_instance_of Array
    end

    it "should have a Gem object" do
      GemCheck::Gem.outdated.first.must_be_instance_of GemCheck::Gem
    end

    it "should output an array" do
      GemCheck::Gem.report.must_be_instance_of Array
    end
  end
end
