require 'spec_helper'
require './src/importer'
require './src/helper'

describe "Importer Class" do
  it "open the file" do
    expect(Importer.new("./logs/race.txt")).instance_of?(File)
  end

  it "should match an array" do
    @importer = Importer.new("./logs/race.txt")
    expect(@importer.import).to match(Array)
  end



end
