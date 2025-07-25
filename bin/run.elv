fn append { |l e|
  put [$@l $e]
}

fn map-over { |f l|
  var map-over-result = []
  for e $l {
    set map-over-result = (append $map-over-result ($f $e))
  }

  put $map-over-result
}

fn fold { |f l acc|
  for e $l {
    set acc = ($f $e $acc)
  }

  put $acc
}

# TODO: handle errors when trying to copy the test and solution files

# $args[0] should be ./tests/example-syntax-error/MiniBob
# (for the moment)
cp $args[0].test.elv ./test.elv
cp $args[0].elv ./solution.elv

# TODO: handle errors when trying to import

use ./test
var tests = (test:tests)

# This file will produce a JSON output, that matches the spec here:
#     https://exercism.org/docs/building/tooling/test-runners/interface

var test-runs = (map-over { |test|
  var status = "error"
  var test-result = [&]
  # TODO: capture output
  try {
    set test-result = ($test)
  } catch e {
    set test-result = $e
    set status = "error"
  } else {
    if (eq $test-result[actual] $test-result[expected]) {
      set status = "pass"
    } else {
      set status = "fail"
    }
  }

  var final-test-result = [
    &name=$test-result[name]
    &status=$status
    &test_code=$test[def]
  ]

  if (eq $status "fail") {
    var message = "Expected \""$test-result[expected]"\", but got \""$test-result[actual]"\"!"
    set final-test-result = (assoc $final-test-result message $message)
  }

  put $final-test-result
} $tests)

# now put together the final json output

var status = (fold { |e acc|
  if (and (eq $acc "error") (eq $e[status] "error") {
    put "error"
  } elif (or (eq $acc "fail")
             (or (eq $e[status] "fail")
                 (eq $e[status] "error")) {
    put "fail"
  } elif (eq $e[status] "pass") {
    put "pass"
  } else {
    fail "invalid status"
  }
} "error")

var output = [
  &version=(num 2)
  &status=$status
  &tests=$test-results
]
