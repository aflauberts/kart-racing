require './src/importer'
require './src/helper'
require './src/race'

class Program

  def initialize(file)
    @importer = Importer.new(open_file(file))
  end

  def load
    @race = Race.new(@importer.import)
    @race.expose
  end

end

program = Program.new('./logs/race.txt')
program.load