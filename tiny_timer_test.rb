require 'test/unit'
require 'stringio'

require 'pry'

require './tiny_timer'

class TinyTimerTest < Test::Unit::TestCase
  def test_all
    t = TinyTimer.new('test', StringIO.new)

    r = t.measure('foo') { sleep 0.5; 2 }

    assert_equal 2, r
    t.summarize

    lines = t.dev.string.lines

    assert_equal 4, lines.count
    assert_equal "|test| Start\n", lines.first
    assert_equal "|test| foo: 0.5s\n", lines[1]
    assert_equal "|test| Total run time: 0.5s\n", lines[2]
    assert_match /.test. foo: 99/, lines.last
  end
end
