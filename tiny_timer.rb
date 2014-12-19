# Simple utility to measure method execution time. No fancy pants stuff.
class TinyTimer
  VERSION = '0.1.0'
  attr_reader :dev

  # @param [String] - name Name of the method, request handler etc
  # @param [IO] - dev file or device to print to. Default STDOUT
  # @param [Boolean] - round,  how many dec places? Default 2
  def initialize(name, dev = STDOUT, round = nil)
    @round = round || 2
    @dev = dev

    @t = Time.now
    @n = name
    @timings = {}
    pr 'Start'
  end


  # Measure a block of code and return its value
  # So given original code:
  #   res = get_items
  #
  # You should change it to:
  #
  #   res = timer.measure('get items') { get_items }
  #
  # @param [String] name
  def measure(name)
    t_local = Time.now
    r =  yield
    t_e = Time.now

    timings = { local: (t_e - t_local).to_f }

    pr "#{name}: #{to_f timings[:local]}s"
    @timings[name] = timings
    r
  end

  # Summarize.
  # Prints the summary to given @dev
  def summarize
    run_time = Time.now - @t
    pr "Total run time: #{to_f run_time}s"
    pr @timings.map { |k, t| "#{k}: #{p(run_time, t[:local])}" }.join(' | ')
  end


  private

  # Calculate percantage of given base
  # @param [Number] base value
  # @param [Number] value for which we caluclate base percentage
  def p(base, item)
    per = (item.to_f * 100) / base.to_f
    "#{to_f per}%"
  end

  # Wrapper for to_f, includes rounding
  def to_f(i)
    i.to_f.round(@round)
  end

  # Write given string to @dev
  # @param [String] s
  def pr(s)
    dev.write "|#{@n}| #{s}\n"
  end
end
