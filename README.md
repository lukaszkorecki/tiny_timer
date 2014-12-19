# Tiny Timer

## Usage

Add the gem:

```ruby
gem 'tiny_timer', git: 'git@github.com:lukaszkorecki/tiny_timer.git'
                , branch: 'stable'

```

use in your code:


```ruby
def needs_fixing
  # marker, which IO object wrtie to, do we want rounding or not
  # last 2 args are defaults
  t = TinyTimer.new('GET /documents', STDOUT, true)

  did_something = t.measure('some op') { do_something }
  something_else = t.measure('next op') { do_more(did_something) }

  t.summarize
  something_else
end
```

Will output something like:

```
|GET /documents| Start
|GET /documents| some op: 0.14s
|GET /documents| next op: 2.42s
|GET /documents| Total run time: 2.56s
|GET /documents| some op: 5.36% | next op: 94.51%
```
