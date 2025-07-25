use ./solution

# I am imagining just exporting one function,
# which itself returns a list of all the test functions


# each function in the list of test functions will output:
#   the actual value after running the solution
#   the expected value
#   (output as a map for convenience)

fn make-test { |name expected test-input|
  # TODO: maybe see about not hardcoding the solution function name
  var test-function = {}
  eval "set test-function = {\n    var test = [\n      &name=\""$name"\"\n      &expected=\""$expected"\"\n    ]\n    try {\n      put (assoc $test actual (solution:hey \""$test-input"\"))\n    } catch error {\n      fail (assoc $test message $error)\n    }\n  }"
  put $test-function
}

fn tests {
  put [
    (make-test "stating something" "Whatever." "Tom-ay-to, tom-aaaah-to.")
    (make-test "shouting" "WATCH OUT!" "Whoa, chill out!")
  ]
}
