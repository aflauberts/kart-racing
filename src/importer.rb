class Importer

  attr_accessor :slots, :file

  Slot = Struct.new(:time, :spaces, :code, :dash, :driver, :spaces1, :lap, :spaces2,:lap_time, :spaces3,:speed)
  LOG_FORMAT = /(\d+:\d+:\d+.\d+)(\s{2,})(\d{3,})(\s\S+\s)(\w.\w+)(\s{1,})(\d+)(\s{1,})(\d+:\d{2}.\d{3,})(\s+)(\d+,\d+)/

  def initialize(log_file)
    @slots = Array.new
    @file = log_file
  end

  def parse_slot(slot)
    slot.match(LOG_FORMAT) { |m| Slot.new(*m.captures) }.to_h.without(:spaces,:spaces1,:spaces2,:dash,:spaces3)
  end

  def import
    @file.split("\n").each { |l| @slots.push(parse_slot(l)) }
    @slots
  end

end

