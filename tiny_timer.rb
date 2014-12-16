class TinyTimer
  attr_reader :dev

  def initialize(name, dev = STDOUT, round = true)
    @round = round
    @dev = dev

    @t = Time.now
    @n = name
    @timings = {}
    pr 'Start'
  end

  def measure(name)
    t_local = Time.now
    r =  yield
    t_e = Time.now

    timings = { local: (t_e - t_local).to_f }

    pr "#{name}: #{to_f timings[:local]}s"
    @timings[name] = timings
    r
  end

  def summarize
    run_time = Time.now - @t
    pr "Total run time: #{to_f run_time}s"
    pr @timings.map { |k, t| "#{k}: #{p(run_time, t[:local])}" }.join(' | ')
  end

  def p(b, i)
    per = (i.to_f * 100) / b.to_f
    "#{to_f per}%"
  end

  def to_f(i)
    return i unless @round
    i.to_f.round(2)
  end

  def pr(s)
    dev.write "|#{@n}| #{s}\n"
  end
end
