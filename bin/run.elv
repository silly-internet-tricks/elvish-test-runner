# NOTE: for list append, try

fn append { |l e|
  put [$@l $e]
}

fn map-over { |f l|
  var result = []
  for e $l {
    set result = (append $result ($f $e))
  }

  put $result
}

# TODO: test this one
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
  # TODO: handle errors
  # TODO: capture output
  try {
    set test-result = ($test)
  } catch e {
    set test-result = $e
  } else {
    if (eq $test-result[actual] $test-result[expected]) {
      set status = "pass"
    } else {
      set status = "fail"
    }
  }

  var result = {
    &name=$test-result[name]
    &status=$status
    &test_code=$test[def]
  }

  if (eq $status "fail") {
    var message = "Expected "$test-result[expected]" but got "$test-result[actual]
    set result = (assoc result message $message)
  }

  if (eq $status "error") {

  }

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
