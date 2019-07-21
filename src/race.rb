class Race

  attr_accessor :slots
  LAPS = 4

  def initialize(slots)
    @slots = slots
    @result = Hash.new
  end

  def expose
    @result = prepare
    print "pos\tcode\tdriver\t\tlaps\ttotal_time\tavg_speed\n"
    @result.each_with_index do |z,idx|
      print "#{idx+1}\t#{z[:code]}\t#{z[:driver].ljust(12,' ')}\t#{z[:lap]}\t#{Time.at(z[:lap_time]).utc.strftime('%M:%S.%L')}\t#{z[:speed].round(3)}\n"
    end
  end

  def best_lap(slot)
    slot.min_by {|k| Time.at(parse_lap_time(k[:lap_time]).to_f).utc.strftime("%H:%M:%S.%L")}
  end

  def parse_lap_time(str_time)
    h = str_time.split(":")
    r = h[0].to_f * 60.0 + h[1].to_f
    Time.at(r).utc
  end

  def total_time_n_speed(id)
    v = s = 0
    id.map do |h|
      h[:lap_time] = parse_lap_time(h[:lap_time]).to_f
      v += h[:lap_time]
      h[:lap_time] = v
      h[:speed] = h[:speed].gsub(/[,]/, '.').to_f
      s += h[:speed]
      h[:speed] = s / h[:lap].to_f
    end
  end

  def prepare
    @slots.group_by {|hash| [hash[:code]]}.map do |k, id|
      total_time_n_speed(id)
      id.max_by {|c| c[:lap]}
    end
  end

end