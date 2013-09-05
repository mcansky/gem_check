require_relative '../test_helper'

describe GemCheck do

  it "must be defined" do
    GemCheck::VERSION.wont_be_nil
  end
end
